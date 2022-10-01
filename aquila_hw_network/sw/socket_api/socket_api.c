#include "socket_api.h"

/* Network management */
struct socket_info sockets[MAX_SOCKET_NUM];
uint32_t phy_ip_addr = 0;
uint32_t socket_num  = 0;
uint16_t tcp_fd_map[MAX_SOCKET_NUM];
uint16_t udp_port_map[MAX_SOCKET_NUM];

/* Mutexs */
SemaphoreHandle_t tcp_open_conn_mutex;
SemaphoreHandle_t tcp_listen_port_mutex;
SemaphoreHandle_t tcp_send_mutex;
SemaphoreHandle_t udp_send_mutex;
SemaphoreHandle_t socket_num_mutex;
SemaphoreHandle_t sockets_mutex[MAX_SOCKET_NUM];

/* Interrupt handler */
SemaphoreHandle_t tcp_accept_int_mutex;
SemaphoreHandle_t tcp_rx_int_mutex;
SemaphoreHandle_t udp_rx_int_mutex;

/* Core Tasks */
static void tcp_accept_poll();
static void tcp_recv_poll();
static void udp_recv_poll();

inline void __enable_ext_interrupt () {

    net_set_int(1);

}

inline void __disable_ext_interrupt () {

    net_set_int(0);
    
}

int socket_init (uint32_t ip_addr, uint32_t ip_mask, uint32_t ip_gateway) {

    /* Init the network module */
    phy_ip_addr = ip_addr;
    net_init(ip_addr, ip_mask, ip_gateway);

    /* Init mutexs */
    tcp_open_conn_mutex   = xSemaphoreCreateMutex();
    tcp_listen_port_mutex = xSemaphoreCreateMutex();
    tcp_send_mutex        = xSemaphoreCreateMutex();
    udp_send_mutex        = xSemaphoreCreateMutex();
    socket_num_mutex      = xSemaphoreCreateMutex();

    for (int i = 0; i < MAX_SOCKET_NUM; i++) 
    {
        sockets_mutex[i] = xSemaphoreCreateMutex();
    }
    
    #if USE_INT
        /* For RX path */
        tcp_accept_int_mutex = xSemaphoreCreateBinary();
        tcp_rx_int_mutex     = xSemaphoreCreateBinary();
        udp_rx_int_mutex     = xSemaphoreCreateBinary();

        /* Open the external interrupt */
        net_set_int(1);
        __enable_ext_interrupt();
    #else
        /* Disable ext interrupt */
        net_set_int(0);
        __disable_ext_interrupt();
    #endif

    /* Create core tasks */
    xTaskCreate(tcp_accept_poll, "tcp_accept_poll", 4096, NULL, SOCKET_CORE_DEFAULT_PRIO, NULL);
    xTaskCreate(tcp_recv_poll  , "tcp_recv_poll"  , 4096, NULL, SOCKET_CORE_DEFAULT_PRIO, NULL);
    xTaskCreate(udp_recv_poll  , "udp_recv_poll"  , 4096, NULL, SOCKET_CORE_DEFAULT_PRIO, NULL);
    
    return 0;
}

int socket (int family, int type, int protocol) {

    /* Family       : currently only support PF_INET(IPv4). */
    /* Type         : SOCK_STREAM for TCP sockets, SOCK_DGRAM for UDP sockets. */
    /* Protocol     : currently only support AF_INET(IPv4). */
    /* Return value : fd on success, -1 on failure. */

    int sfd = -1;

    /* Check whether family is valid */
    if (family != PF_INET) return -1;

    /* Check whether type is valid */
    if (type != SOCK_STREAM && type != SOCK_DGRAM) return -1;

    /* Check whether protocol is valid */
    if (protocol != AF_INET) return -1;

    xSemaphoreTake(socket_num_mutex, portMAX_DELAY);

    if (socket_num < MAX_SOCKET_NUM)
    {
        sfd = socket_num;
        socket_num++;

        xSemaphoreTake(sockets_mutex[sfd], portMAX_DELAY);
        sockets[sfd].type    = type;
        sockets[sfd].ip_addr = 0;
        sockets[sfd].port    = 0;
        sockets[sfd].phy_fd  = 0;

        sockets[sfd].data_list.head = NULL;
        sockets[sfd].data_list.tail = NULL;
        xSemaphoreGive(sockets_mutex[sfd]);
    }

    xSemaphoreGive(socket_num_mutex);

    return sfd;
}

int accept (int sfd, struct sockaddr *addr, socklen_t *addr_length) {

    int fd;
    struct data_block_t *data_block;
    struct sockaddr_in  *addr_in = (struct sockaddr_in *)addr;
    volatile struct data_list_t *data_list = &sockets[sfd].data_list;

    if (sockets[sfd].type != SOCK_STREAM)
    {
        return -1;
    }

    /* Wait for connection */
    while (data_list->head == NULL);

    xSemaphoreTake(sockets_mutex[sfd], portMAX_DELAY);
    data_block = data_list->head;

    /* Create a new sfd for connection */
    xSemaphoreTake(socket_num_mutex, portMAX_DELAY);
    fd = socket_num;
    socket_num++;
    xSemaphoreGive(socket_num_mutex);

    /* Fill in the sockaddr */
    addr_in->sin_addr.s_addr = data_block->ip_addr;
    addr_in->sin_port        = data_block->port;

    /* fd is not occupy in this time, so no need to protect it*/
    sockets[fd].type    = SOCK_STREAM;
    sockets[fd].ip_addr = data_block->ip_addr;
    sockets[fd].port    = data_block->port;
    sockets[fd].phy_fd  = data_block->flag;
    sockets[fd].data_list.head = NULL;
    sockets[fd].data_list.tail = NULL;

    tcp_fd_map[data_block->flag] = fd;

    /* Free the allocated memory, and update the data block list */
    data_list->head = data_list->head->next;

    if (data_list->head == NULL)
    {
        data_list->tail = NULL;
    }

    vPortFree(data_block);
    xSemaphoreGive(sockets_mutex[sfd]);

    return fd;
}

int bind (int sfd, const struct sockaddr *addr, socklen_t addr_length) {

    int ret = -1;
    struct sockaddr_in *addr_in = (struct sockaddr_in *)addr;

    /* Check whether is TCP socket */
    if (sockets[sfd].type == SOCK_STREAM)
    {
        xSemaphoreTake(sockets_mutex[sfd], portMAX_DELAY);
        sockets[sfd].ip_addr = addr_in->sin_addr.s_addr;
        sockets[sfd].port    = addr_in->sin_port;
        xSemaphoreGive(sockets_mutex[sfd]);
        ret = 0;
    }
    else if (sockets[sfd].type == SOCK_DGRAM)
    {
        xSemaphoreTake(sockets_mutex[sfd], portMAX_DELAY);
        sockets[sfd].ip_addr = addr_in->sin_addr.s_addr;
        sockets[sfd].port    = addr_in->sin_port;
        udp_port_map[sfd]    = sockets[sfd].port;
        udp_set_port(sockets[sfd].port, 1); // udp_set_port, no need to protect
        xSemaphoreGive(sockets_mutex[sfd]);
        ret = 0;
    }

    return ret;
}

int connect (int sfd, struct sockaddr *addr, socklen_t addr_length) {

    int ret = -1;
    struct sockaddr_in *addr_in = (struct sockaddr_in *)addr;

    if (sockets[sfd].type == SOCK_STREAM) 
    {
        /* TCP connect */
        xSemaphoreTake(sockets_mutex[sfd], portMAX_DELAY);
        sockets[sfd].ip_addr = addr_in->sin_addr.s_addr;
        sockets[sfd].port    = addr_in->sin_port;

        xSemaphoreTake(tcp_open_conn_mutex, portMAX_DELAY);
        ret = tcp_open_connection(sockets[sfd].ip_addr, sockets[sfd].port, &(sockets[sfd].phy_fd));
        xSemaphoreGive(tcp_open_conn_mutex);

        if (ret == 0) tcp_fd_map[sockets[sfd].phy_fd] = sfd;

        xSemaphoreGive(sockets_mutex[sfd]);
    }
    else if (sockets[sfd].type == SOCK_STREAM)
    {
        /* Do nothing */
        ret = 0;
    }

    return ret;
}

int listen (int sfd, int backlog) {

    int success;

    /* Check whether sfd is TCP socket */
    if (sockets[sfd].type != SOCK_STREAM)
    {
        return -1;
    }

    /* Check whether ip address is correct */
    if (!CHECK_PHY_IP_ADDR(sockets[sfd].ip_addr))
    {
        return -1;
    }

    /* Listen port */
    xSemaphoreTake(tcp_listen_port_mutex, portMAX_DELAY);
    success = tcp_listen_port(sockets[sfd].port);
    xSemaphoreGive(tcp_listen_port_mutex);

    if (success)
    {
        return 0;
    }

    return -1;
}

int recv (int sfd, void *buffer, uint32_t num_bytes, int flags) {
    
    uint8_t  *data;
    uint16_t recv_bytes;
    uint16_t packet_bytes;
    uint16_t readed_bytes;
    uint16_t left_bytes;
    struct data_block_t *data_block;
    volatile struct data_list_t *data_list = &sockets[sfd].data_list;

    if (sockets[sfd].type != SOCK_STREAM)
    {
        return -1;
    }

    while (data_list->head == NULL);

    data_block = data_list->head;

    /* Decide how many bytes to receive */
    packet_bytes = data_block->length;
    readed_bytes = data_block->readed_bytes;
    left_bytes   = (packet_bytes - readed_bytes);

    if (num_bytes > left_bytes)
    {
        recv_bytes = left_bytes;
    }
    else
    {
        recv_bytes = num_bytes;
    }

    /* Move data to buffer */
    data = (data_block->data) + readed_bytes;
    memcpy(buffer, data, recv_bytes);

    /* Updata date block */
    data_block->readed_bytes += recv_bytes;

    /* Check whether data block is finished reading */
    if (data_block->length == data_block->readed_bytes)
    {
        xSemaphoreTake(sockets_mutex[sfd], portMAX_DELAY);
        /* Move head */
        data_list->head = data_list->head->next;

        /* If there is no more data block, tail should point to NULL */
        if (data_list->head == NULL)
        {
            data_list->tail = NULL;
        }
        xSemaphoreGive(sockets_mutex[sfd]);

        /* Free the allocated memory */
        vPortFree(data_block->data);
        vPortFree(data_block);
    }

    return recv_bytes;   
}

int send (int sfd, void *buffer, uint32_t num_bytes, int flags) {

    tcp_packet_t packet;
    uint32_t send_bytes;
    uint8_t  data[2048] __attribute__((aligned(32)));

    if (sockets[sfd].type != SOCK_STREAM)
    {
        return -1;
    }

    if (num_bytes == 0)
    {
        return 0;
    }

    memcpy(data, buffer, num_bytes);

    packet.session_id = sockets[sfd].phy_fd;
    packet.length     = num_bytes;
    packet.data       = data;

    xSemaphoreTake(tcp_send_mutex, portMAX_DELAY);
    #if USE_DCA
        send_bytes = tcp_send_dca(&packet);
    #else
        send_bytes = tcp_send(&packet);
    #endif
    xSemaphoreGive(tcp_send_mutex);

    return send_bytes;
}

int recvfrom (int sfd, void *buffer, uint32_t num_bytes, int flags, struct sockaddr *addr, socklen_t *addr_length) {
    
    uint8_t  *data;
    uint16_t recv_bytes;
    uint16_t packet_bytes;
    uint16_t readed_bytes;
    uint16_t left_bytes;
    struct data_block_t *data_block;
    struct sockaddr_in  *addr_in;
    volatile struct data_list_t *data_list = &sockets[sfd].data_list;


    if (sockets[sfd].type != SOCK_DGRAM)
    {
        return -1;
    }
    
    while (data_list->head == NULL);

    data_block = data_list->head;
    addr_in    = (struct sockaddr_in *)addr;

    /* Decide how many bytes to receive */
    packet_bytes = data_block->length;
    readed_bytes = data_block->readed_bytes;
    left_bytes   = (packet_bytes - readed_bytes);

    if (num_bytes > left_bytes)
    {
        recv_bytes = left_bytes;
    }
    else
    {
        recv_bytes = num_bytes;
    }

    /* Move data to buffer */
    data = (data_block->data) + readed_bytes;
    memcpy(buffer, data, recv_bytes);

    /* Fill in the sockaddr */
    addr_in->sin_addr.s_addr = data_block->ip_addr;
    addr_in->sin_port        = data_block->port;

    /* Updata date block */
    data_block->readed_bytes += recv_bytes;

    /* Check whether data block is finished reading */
    if (data_block->length == data_block->readed_bytes)
    {
        xSemaphoreTake(sockets_mutex[sfd], portMAX_DELAY);

        /* Move head */
        data_list->head = data_list->head->next;
        /* If there is no more data block, tail should point to NULL */
        if (data_list->head == NULL)
        {
            data_list->tail = NULL;
        }

        xSemaphoreGive(sockets_mutex[sfd]);
        /* Free the allocated memory */
        vPortFree(data_block->data);
        vPortFree(data_block);
    }
    
    return recv_bytes;
}

int sendto (int sfd, void *buffer, uint32_t num_bytes, int flags, struct sockaddr *addr, socklen_t addr_length) {
    
    udp_packet_t packet;
    struct sockaddr_in *addr_in;
    uint8_t data[2048] __attribute__((aligned(32)));

    if (sockets[sfd].type != SOCK_DGRAM)
    {
        return -1;
    }

    if (num_bytes == 0)
    {
        return 0;
    }

    xSemaphoreTake(udp_send_mutex, portMAX_DELAY);
    memcpy(data, buffer, num_bytes);

    addr_in         = (struct sockaddr_in *)addr;
    packet.ip_addr  = addr_in->sin_addr.s_addr;
    packet.dst_port = addr_in->sin_port;
    packet.src_port = sockets[sfd].port;
    packet.length   = num_bytes;
    packet.data     = data;

    #if USE_DCA
        udp_send_dca(&packet);
    #else
        udp_send(&packet);
    #endif
    xSemaphoreGive(udp_send_mutex);

    return num_bytes;
}

int close (int sfd) {

    int ret = -1;

    if (sockets[sfd].type == SOCK_STREAM) 
    {
        /* TCP */
        xSemaphoreTake(sockets_mutex[sfd], portMAX_DELAY);

        tcp_close_connection(sockets[sfd].phy_fd);

        sockets[sfd].type = 0;
        xSemaphoreGive(sockets_mutex[sfd]);
        
        ret = 0;
    }
    else if (sockets[sfd].type == SOCK_STREAM)
    {
        /* UDP */
        xSemaphoreTake(sockets_mutex[sfd], portMAX_DELAY);

        udp_set_port(sockets[sfd].port, 0);
        sockets[sfd].type = 0;
        udp_port_map[sfd] = 0;

        xSemaphoreGive(sockets_mutex[sfd]);

        ret = 0;
    }

    return ret;
}

static void tcp_accept_poll () {

    uint32_t ip_addr;
    uint16_t port;
    uint16_t session_id;
    uint16_t sfd;
    struct data_block_t *data_block;
    volatile struct data_list_t *data_list;

    while (1)
    {

        while (tcp_get_status(TCP_ACCEPT_STS_VALID) == 0)
        {
            #if USE_INT
                /* Enable the external interrupt */
                __enable_ext_interrupt();
                xSemaphoreTake(tcp_accept_int_mutex, portMAX_DELAY);
            #endif
        }

        tcp_accept(&ip_addr, &port, &session_id);

        /* Find sfd */
        for (sfd = 0; sfd < MAX_SOCKET_NUM; sfd++)
        {
            if (sockets[sfd].port == port)
            {
                break;
            }
        }

        if (sfd != MAX_SOCKET_NUM && sockets[sfd].type == SOCK_STREAM)
        {
            /* Found a match */
            xSemaphoreTake(sockets_mutex[sfd], portMAX_DELAY);
            data_block = pvPortMalloc(sizeof(struct data_block_t));

            data_block->ip_addr      = ip_addr;
            data_block->port         = port;
            data_block->flag         = session_id;
            data_block->length       = 0;
            data_block->readed_bytes = 0;
            data_block->data         = NULL;
            data_block->next         = NULL;
            
            data_list = &sockets[sfd].data_list;

            if (data_list->tail)
            {            
                data_list->tail->next = data_block;
                data_list->tail       = data_list->tail->next;
            }
            else
            {
                data_list->head = data_block;
                data_list->tail = data_block;
            }
            xSemaphoreGive(sockets_mutex[sfd]);
        }

    }

    return;
}

static void tcp_recv_poll () {

    tcp_packet_t packet;
    uint8_t  buffer[2048] __attribute__((aligned(32)));
    uint8_t  *data;
    uint16_t sfd;
    struct data_block_t *data_block;
    volatile struct data_list_t *data_list;

    packet.data = buffer;

    while (1)
    {

        while (tcp_get_status(TCP_NOTIFICATION_VALID) == 0)
        {
            #if USE_INT
                /* Enable the external interrupt */
                __enable_ext_interrupt();
                xSemaphoreTake(tcp_rx_int_mutex, portMAX_DELAY);
            #endif
        }
        
        // printf("p\n");

        #if USE_DCA
            tcp_recv_dca(&packet);
        #else
            tcp_recv(&packet);
        #endif

        if (packet.session_id < MAX_SOCKET_NUM)
        {
            sfd = tcp_fd_map[packet.session_id];

            if (sockets[sfd].type == SOCK_STREAM)
            {

                data       = pvPortMalloc(sizeof(uint8_t) * packet.length); 
                data_block = pvPortMalloc(sizeof(struct data_block_t));

                memcpy(data, buffer, packet.length);

                data_block->ip_addr      = packet.ip_addr;
                data_block->port         = packet.dst_port;
                data_block->flag         = packet.close_flag;
                data_block->length       = packet.length;
                data_block->readed_bytes = 0;
                data_block->data         = data;
                data_block->next         = NULL;

                xSemaphoreTake(sockets_mutex[sfd], portMAX_DELAY);
                data_list = &sockets[sfd].data_list;
                
                if (data_list->tail)
                {            
                    data_list->tail->next = data_block;
                    data_list->tail       = data_list->tail->next;
                }
                else
                {
                    data_list->head = data_block;
                    data_list->tail = data_block;
                }
                xSemaphoreGive(sockets_mutex[sfd]);
            }
        }

    }

    return;
}

static void udp_recv_poll () {

    udp_packet_t packet;
    uint8_t  buffer[2048] __attribute__((aligned(32)));;
    uint8_t  *data;
    uint16_t sfd;
    struct data_block_t *data_block;
    volatile struct data_list_t *data_list;


    packet.data = buffer;

    while (1)
    {

        while (udp_get_status(UDP_RX_META_VALUD) == 0)
        {
            #if USE_INT
                /* Enable the external interrupt */
                __enable_ext_interrupt();
                xSemaphoreTake(udp_rx_int_mutex, portMAX_DELAY);
            #endif
        }

        #if USE_DCA
            udp_recv_dca(&packet);
        #else
            udp_recv(&packet);
        #endif

        /* Find sfd */
        for (sfd = 0; sfd < MAX_SOCKET_NUM; sfd++)
        {

            if (udp_port_map[sfd] == packet.dst_port)
            {
                break;
            }
        }
        
        if (sfd != MAX_SOCKET_NUM && sockets[sfd].type == SOCK_DGRAM)
        {
            /* Found a match */
            xSemaphoreTake(sockets_mutex[sfd], portMAX_DELAY);
            data       = pvPortMalloc(sizeof(uint8_t) * packet.length);
            data_block = pvPortMalloc(sizeof(struct data_block_t));
            
            memcpy(data, buffer, packet.length);

            data_block->ip_addr      = packet.ip_addr;
            data_block->port         = packet.src_port;
            data_block->flag         = 0;
            data_block->length       = packet.length;
            data_block->readed_bytes = 0;
            data_block->data         = data;
            data_block->next         = NULL;
        
            data_list = &sockets[sfd].data_list;

            if (data_list->tail)
            {            
                data_list->tail->next = data_block;
                data_list->tail       = data_list->tail->next;
            }
            else
            {
                data_list->head = data_block;
                data_list->tail = data_block;
            }
            xSemaphoreGive(sockets_mutex[sfd]);
        }
    }

    return;
}

void socket_int_handler ( void ) {

    BaseType_t xSwitchRequired = pdFALSE;

    unsigned int tcp_rx_isr     = tcp_get_status(TCP_NOTIFICATION_VALID);
    unsigned int udp_rx_isr     = udp_get_status(UDP_RX_META_VALUD);
    unsigned int tcp_accept_isr = tcp_get_status(TCP_ACCEPT_STS_VALID);

    /* Check int source, and wake up corresponding task */
    if (tcp_rx_isr)
    {
        __disable_ext_interrupt();
        xSemaphoreGiveFromISR(tcp_rx_int_mutex, &xSwitchRequired);
    } 
    else if (udp_rx_isr)
    {
        __disable_ext_interrupt();
        xSemaphoreGiveFromISR(udp_rx_int_mutex, &xSwitchRequired);
    } 
    else if (tcp_accept_isr)
    {
        __disable_ext_interrupt();
        xSemaphoreGiveFromISR(tcp_accept_int_mutex, &xSwitchRequired);
    }

    portYIELD_FROM_ISR(xSwitchRequired);

}