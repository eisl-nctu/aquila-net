#ifndef AQUILA_ETH_H
#define AQUILA_ETH_H

unsigned int get_rx_valid ();
unsigned int get_tx_ready ();
void get_eth_rx_last (unsigned int *last);
void get_eth_rx_keep (unsigned int *keep);
void read_eth_rx_data (unsigned int *data);
void set_eth_tx_last (unsigned int last);
void set_eth_tx_keep (unsigned int keep);
void write_eth_tx_data (unsigned int data);
unsigned int get_rst_done ();
void get_ticks();
unsigned int get_ticks_by_csr ();

#endif