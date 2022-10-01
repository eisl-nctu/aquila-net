/* Standard includes. */
#include <stdio.h>
#include <string.h>
#include <time.h>

/* LWIP includes */
#include "lwip/timeouts.h"
#include "lwip/init.h"
#include "lwip/tcp.h"
#include "lwip/udp.h"
#include "netif/ethernet.h"

/* ETH includes */
#include "aquila_lwip_driver.h"
#include "eth.h"

uint8_t  ip_addr[4] = {10, 1, 212, 209};
uint8_t  gw_addr[4] = {10, 1, 212, 1};
uint8_t  netmask[4] = {255, 255, 255, 0};
uint16_t port       = 12345;

extern unsigned int start_ticks, end_ticks;

void network_init(struct netif* netif);
int tcp_echo(struct netif* netif);
err_t tcp_accept_callback(void *arg, struct tcp_pcb *new_pcb, err_t err);
err_t tcp_recv_callback(void *arg, struct tcp_pcb *tpcb, struct pbuf *p, err_t err);
int udp_echo(struct netif* netif);
static void udp_recv_callback(void *arg, struct udp_pcb *tpcb, struct pbuf *p, const ip_addr_t *addr, u16_t port);

int main( void ) {

    struct netif netif;

    lwip_init();
    network_init(&netif);
    printf("[INFO] LWIP sofware stack init finish.\r\n");
    tcp_echo(&netif);
    // udp_echo(&netif);

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

int tcp_echo(struct netif* netif) {

    struct tcp_pcb *pcb;
    int err;

    /* Create PCB */
    pcb = tcp_new();
    if (!pcb) {
        printf("Error Creating PCB.\r\n");
        return -1;
    }

    printf("[INFO]TCP PCB created.\r\n");

    /* Bind PCB */
    err = tcp_bind(pcb, IP_ADDR_ANY, port);
    if (err != ERR_OK) {
        printf("Unable to bind to port %d\r\n", port);
        return -1;
    }

    printf("[INFO]TCP Binded.\r\n");
    
    pcb = tcp_listen(pcb);
    
    tcp_accept(pcb, tcp_accept_callback);

    /* Recv data from netif */
    while (1) {
        ethernetif_input(netif);
    }

    return 0;
}

err_t tcp_accept_callback(void *arg, struct tcp_pcb *new_pcb, err_t err) {

    tcp_recv(new_pcb, tcp_recv_callback);

    return ERR_OK;
}

err_t tcp_recv_callback(void *arg, struct tcp_pcb *tpcb, struct pbuf *p, err_t err) {

    if (!p)
    {
        tcp_close(tpcb);
        tcp_recv(tpcb, NULL);
        return ERR_OK;
    }

    tcp_recved(tpcb, p->len);

    if (tcp_sndbuf(tpcb) > p->len)
    {
        tcp_write(tpcb, p->payload, p->len, 1);

    }

    pbuf_free(p);

    return ERR_OK;
}


int udp_echo(struct netif* netif) {

    struct udp_pcb *pcb;
    int err;

    /* Create UDP PCB */
    pcb = udp_new();
    if (!pcb) {
        printf("Error Creating PCB.\r\n");
        return -1;
    }

    printf("[INFO]UDP PCB created.\r\n");

    /* Bind UDP PCB */
    err = udp_bind(pcb, IP_ADDR_ANY, port);
    if (err != ERR_OK) {
        printf("Unable to bind to port %d\r\n", port);
        return -1;
    }

    printf("[INFO]UDP Binded.\r\n");
    
    /* Set Recv Callback function */
    udp_recv(pcb, udp_recv_callback, NULL);

    /* Recv data from netif */
    while (1) {
        ethernetif_input(netif);
    }

    return 0;
}

static void udp_recv_callback(void *arg, struct udp_pcb *tpcb, struct pbuf *p, const ip_addr_t *addr, u16_t port) {

    err_t err = udp_sendto(tpcb, p, addr, port);
    pbuf_free(p);

    return;
}

u32_t sys_now(void) {
    return clock();
}

