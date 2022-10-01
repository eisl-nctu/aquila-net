#include "socket_api.h"
/* Standard includes. */
#include "stdio.h"
#include "string.h"

/* FreeRTOS includes. */
#include "FreeRTOS.h"
#include "task.h"

#define LOCAL_IP_ADDRESS   (0x0A01D4D1) // 10.1.212.209
#define NET_MASK           (0xFFFFFF00) // 255.255.255.0
#define GATEWAY_IP_ADDRESS (0x0A01D401) // 10.1.212.1

static void tcp_echo_server(void *port);
static void tcp_echo_client(void *port);
static void udp_echo_server(void *port);

int main (void)
{
    uint16_t tcp_client_port = 12345;
    uint16_t tcp_server_port = 12345;
    uint16_t udp_server_port = 12345;

    socket_init(LOCAL_IP_ADDRESS, NET_MASK, GATEWAY_IP_ADDRESS);
    
    // xTaskCreate(tcp_echo_client, "tcp_echo_client", 4096, &tcp_client_port, SOCKET_USER_DEFAULT_PRIO, NULL);
    xTaskCreate(tcp_echo_server, "tcp_echo_server", 4096, &tcp_server_port, SOCKET_USER_DEFAULT_PRIO, NULL);
    // xTaskCreate(udp_echo_server, "udp_echo_server", 4096, &udp_server_port, SOCKET_USER_DEFAULT_PRIO, NULL);
    vTaskStartScheduler(); 

    return 0;
}

static void tcp_echo_server (void *port) {

    char buffer[2048];

    struct sockaddr_in server_addr, client_addr;
    socklen_t addr_length;
    unsigned int recv_bytes;
    unsigned int send_bytes;
    unsigned int ticks;
    int sfd, cfd;

    /* Get socket fd */
    sfd = socket(PF_INET, SOCK_STREAM, AF_INET);
    printf("Aquired socket fd: %d\n", sfd);

    /* Bind socket */
    server_addr.sin_family      = AF_INET;
    server_addr.sin_addr.s_addr = LOCAL_IP_ADDRESS;
    server_addr.sin_port        = *(uint16_t *)port;

    if (bind(sfd, (const struct sockaddr *)&server_addr, sizeof(server_addr)) != 0)
    {
        printf("Bind error!\n");
        return;
    }

    if (listen(sfd, 5) != 0)
    {
        printf("Listen error!\n");
        return;
    }
    else
    {
        printf("Socket Listening.\n");
    }

    while (1)
    {
        printf("Wait for connection, sfd: %d\n", sfd);

        cfd = accept(sfd, (struct sockaddr *)&client_addr, &addr_length);
        printf("Connection accepted, cfd: %d\n", cfd);

        while (1) 
        {
            recv_bytes = recv(cfd, buffer, 2048, 0);
            // printf("[tcp echo] Recv %d bytes, cfd %d\n", recv_bytes, cfd);

            if (recv_bytes == 0)
            {
                break;
            }
            else
            {
                send_bytes = send(cfd, buffer, recv_bytes, 0);
                // printf("[tcp echo] Send %d bytes, cfd %d\n", send_bytes, cfd);

                ticks = net_get_ticks();
                printf("%d\n", ticks);
            }
        }

    }

    return;
}

static void tcp_echo_client (void *port) {

    char buffer[2048];
    unsigned int recv_bytes;
    unsigned int send_bytes;
    unsigned int ticks;
    struct sockaddr_in server_addr;
    int sfd;

    /* Get socket fd */
    sfd = socket(PF_INET, SOCK_STREAM, AF_INET);
    printf("Aquired socket fd: %d\n", sfd);

    /* Connect socket */
    server_addr.sin_family      = AF_INET;
    server_addr.sin_addr.s_addr = 0x0A01D40A;
    server_addr.sin_port        = *(uint16_t *)port;

    while (connect(sfd, (struct sockaddr *) &server_addr, sizeof(server_addr)) != 0) ;

    while (1) 
    {
        recv_bytes = recv(sfd, buffer, 2048, 0);
        // printf("[tcp echo] Recv from %x:%d, %d bytes\n", (unsigned int)server_addr.sin_addr.s_addr, (unsigned int)server_addr.sin_port, (unsigned int)recv_bytes);

        if (recv_bytes == 0)
        {
            break;
        }
        else
        {
            send_bytes = send(sfd, buffer, recv_bytes, 0);
            // printf("[tcp echo] Send to %x:%d, %d bytes\n", (unsigned int)server_addr.sin_addr.s_addr, (unsigned int)server_addr.sin_port, (unsigned int)send_bytes);

            ticks = net_get_ticks();
            printf("%d\n", ticks);
        }
    }

    return;
}

static void udp_echo_server (void *port) {

    char buffer[2048];
    unsigned int recv_bytes;
    unsigned int send_bytes;
    unsigned int ticks;
    struct sockaddr_in server_addr, client_addr;
    socklen_t client_addr_len;
    int sfd;

    /* Get socket fd */
    sfd = socket(PF_INET, SOCK_DGRAM, AF_INET);
    printf("Aquired socket fd: %d\n", sfd);

    /* Bind socket */
    server_addr.sin_family      = AF_INET;
    server_addr.sin_addr.s_addr = 0x0A01D401;
    server_addr.sin_port        = *(uint16_t *)port;
    bind(sfd, (struct sockaddr *) &server_addr, sizeof(server_addr));

    while (1) 
    {
        recv_bytes = recvfrom(sfd, buffer, 2048, 0, (struct sockaddr *)&client_addr, &client_addr_len);
        // printf("[udp echo] Recv from %lx:%d, %d bytes\n", client_addr.sin_addr.s_addr, client_addr.sin_port, recv_bytes);
        send_bytes = sendto(sfd, buffer, recv_bytes, 0, (struct sockaddr *)&client_addr, sizeof(client_addr));
        // printf("[udp echo] Send to %lx:%d, %d bytes\n", client_addr.sin_addr.s_addr, client_addr.sin_port, send_bytes);
        
        ticks = net_get_ticks();
        printf("%d\n", ticks);

        if (strncmp(buffer, "close", 5) == 0)
        {
            close(sfd);
            break;
        }
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

