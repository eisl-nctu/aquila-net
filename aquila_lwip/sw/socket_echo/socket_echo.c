/* Standard includes. */
#include <stdio.h>
#include <string.h>
#include <time.h>

/* LWIP includes */
#include "lwip/timeouts.h"
#include "lwip/tcpip.h"
#include "lwip/sockets.h"
#include "netif/ethernet.h"

/* ETH includes */
#include "aquila_lwip_driver.h"
#include "eth.h"

/* FreeRTOS includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "semphr.h"

#define mainRAM_DISK_NAME    "/ram"
uint8_t  ip_addr[4] = {10, 1, 212, 209};
uint8_t  gw_addr[4] = {10, 1, 212, 1};
uint8_t  netmask[4] = {255, 255, 255, 0};
uint16_t port = 12345;

void vApplicationMallocFailedHook(void);
void vApplicationIdleHook(void);
void vApplicationStackOverflowHook(TaskHandle_t pxTask, char *pcTaskName);
void vApplicationTickHook(void);

static void Udp_echo_thread(void *pvParameters);
static void Tcp_echo_thread(void *pvParameters);

void network_init(struct netif* netif);
void do_echo(int sock);
int create_socket();

int main( void ) {

    struct netif netif;

    tcpip_init(NULL, NULL);
    udp_init();
    network_init(&netif);
    printf("[INFO] LWIP sofware stack init finish.\r\n");
    // xTaskCreate(Udp_echo_thread, "Echo", 4096, NULL, 4, NULL);
    xTaskCreate(Tcp_echo_thread, "Echo", 4096, NULL, 4, NULL);
    vTaskStartScheduler(); 

    return 0;
}

void network_init(struct netif* netif) {

    ip_addr_t ip_s, nm_s, gw_s;
    
    /* setting the IP address */
    IP4_ADDR(&ip_s, ip_addr[0], ip_addr[1], ip_addr[2], ip_addr[3]);
    IP4_ADDR(&gw_s, gw_addr[0], gw_addr[1], gw_addr[2], gw_addr[3]);
    IP4_ADDR(&nm_s, netmask[0], netmask[1], netmask[2], netmask[3]);

    netif_add(netif, &ip_s, &nm_s, &gw_s, NULL, &ethernetif_init, &ethernet_input);
    netif_set_default(netif);
    netif_set_up(netif);
    
    return;
}

int create_socket_tcp() {

    int sock = -1;
    struct sockaddr_in server_addr;
    socklen_t addr_len = sizeof(server_addr);

    sock = lwip_socket(AF_INET, SOCK_STREAM, 0);
    if (sock < 0) {
        printf("[ERROR] create socket fail.\n");
        return -1;
    }
    printf("[INFO] socket created.\n");

    memset(&server_addr, 0, addr_len);
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    server_addr.sin_port = htons(port);

    if (lwip_bind(sock, (struct sockaddr *) &server_addr, addr_len) < 0 )
    {
        printf("[ERROR] bind socket fail.\n");
        return -1;
    }
    printf("[INFO] socket binded.\n");

    if (lwip_listen(sock, 1) < 0)
    {
        printf("[ERROR] listen socket fail.\n");
        return -1;
    }
    printf("[INFO] socket listen on '%d.%d.%d.%d:%d'.\n", ip_addr[0], ip_addr[1], ip_addr[2], ip_addr[3], port);

    return sock;
}

void do_echo_tcp(int sock) {

    char buff[2048];
    int recv_bytes;

    while (1) {
        recv_bytes = lwip_recv(sock, buff, 2048, 0);
        /* Echo back */
        if (lwip_send(sock, buff, recv_bytes, 0) < 0) break;
        if (recv_bytes <= 0) break;
    }

    printf("[INFO] sock %d closed.\n", sock);
    lwip_close(sock);
    return;
}

static void Tcp_echo_thread(void *pvParameters) {
    struct sockaddr_in client_addr;
    socklen_t addr_len = sizeof(client_addr);
    int server_sock;
    int client_sock;

    server_sock = create_socket_tcp();

    while (1) {
        client_sock = lwip_accept(server_sock, (struct sockaddr *)&client_addr, &addr_len);
        if (client_sock < 0) printf("[ERROR] connect fail\n.");
        else do_echo_tcp(client_sock);
    }

    return;
}

static void Udp_echo_thread (void *pvParameters) {

    int recv_bytes;
    int sock = -1;
    char buff[2048];

    struct sockaddr_in server_addr, client_addr;
    socklen_t addr_len;

    sock = lwip_socket(AF_INET, SOCK_DGRAM, 0);

    if (sock < 0) {
        printf("[ERROR] create socket fail.\n");
        return;
    }

    printf("[INFO] socket created.\n");

    memset(&(server_addr.sin_zero), 0, sizeof((server_addr.sin_zero)));
    memset(&(client_addr.sin_zero), 0, sizeof((client_addr.sin_zero)));
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    server_addr.sin_port = htons(12345);


    if (lwip_bind(sock, (struct sockaddr *) &server_addr, sizeof(server_addr)) < 0 )
    {
        printf("[ERROR] bind socket fail.\n");
        return;
    }
    printf("[INFO] socket binded.\n");

    while (1)
    {
        recv_bytes = lwip_recvfrom(sock, (char *)buff, 2048, 0, (struct sockaddr *)&client_addr, &addr_len);
        lwip_sendto(sock, (char *)buff, recv_bytes, 0, (struct sockaddr *)&client_addr, sizeof(client_addr));
    }
    

    return;
}

void vApplicationMallocFailedHook(void)
{
    /* vApplicationMallocFailedHook() will only be called if
       configUSE_MALLOC_FAILED_HOOK is set to 1 in FreeRTOSConfig.h.  It is a hook
       function that will get called if a call to pvPortMalloc() fails.
       pvPortMalloc() is called internally by the kernel whenever a task, queue,
       timer or semaphore is created.  It is also called by various parts of the
       demo application.  If heap_1.c or heap_2.c are used, then the size of the
       heap available to pvPortMalloc() is defined by configTOTAL_HEAP_SIZE in
       FreeRTOSConfig.h, and the xPortGetFreeHeapSize() API function can be used
       to query the size of free heap space that remains (although it does not
       provide information on how the remaining heap might be fragmented). */
    taskDISABLE_INTERRUPTS();
    for (;;);
}

void vApplicationIdleHook(void)
{
    /* vApplicationIdleHook() will only be called if configUSE_IDLE_HOOK is set
       to 1 in FreeRTOSConfig.h.  It will be called on each iteration of the idle
       task.  It is essential that code added to this hook function never attempts
       to block in any way (for example, call xQueueReceive() with a block time
       specified, or call vTaskDelay()).  If the application makes use of the
       vTaskDelete() API function (as this demo application does) then it is also
       important that vApplicationIdleHook() is permitted to return to its calling
       function, because it is the responsibility of the idle task to clean up
       memory allocated by the kernel to any task that has since been deleted. */
}

void vApplicationStackOverflowHook(TaskHandle_t pxTask, char *pcTaskName)
{
    (void) pcTaskName;
    (void) pxTask;

    /* Run time stack overflow checking is performed if
       configCHECK_FOR_STACK_OVERFLOW is defined to 1 or 2.  This hook
       function is called if a stack overflow is detected. */
    taskDISABLE_INTERRUPTS();
    for (;;);
}

void vApplicationTickHook(void)
{
    /* vApplicationTickHook */
}

void vAssertCalled(void)
{
    taskDISABLE_INTERRUPTS();
    while (1)
    {
        __asm volatile ("NOP");
    }
}


