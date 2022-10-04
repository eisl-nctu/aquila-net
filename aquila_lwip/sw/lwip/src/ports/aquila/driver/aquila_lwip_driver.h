#ifndef AQUILA_LWIP_DRIVER_H
#define AQUILA_LWIP_DRIVER_H

void low_level_init(struct netif *netif);
err_t low_level_output(struct netif *netif, struct pbuf *p);
err_t ethernetif_init(struct netif *netif);
struct pbuf *low_level_input(struct netif *netif);
void ethernetif_input(void *pParams);
#endif