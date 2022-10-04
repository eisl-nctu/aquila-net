#include "eth.h"
#include "stdio.h"

// Read
volatile unsigned int *eth_rx_data     = (unsigned int*)(0xC3000000);
volatile unsigned int *eth_rx_keep     = (unsigned int*)(0xC3000004);
volatile unsigned int *eth_rx_valid    = (unsigned int*)(0xC3000008);
volatile unsigned int *eth_rx_last     = (unsigned int*)(0xC300000C);
volatile unsigned int *eth_tx_ready    = (unsigned int*)(0xC3000010);
volatile unsigned int *eth_rst_done    = (unsigned int*)(0xC3000014);
volatile unsigned int *eth_ticks_valid = (unsigned int*)(0xC3000018);
volatile unsigned int *eth_rx_ticks    = (unsigned int*)(0xC300001C);
volatile unsigned int *eth_tx_ticks    = (unsigned int*)(0xC3000020);

// Write
volatile unsigned int *eth_tx_data     = (unsigned int*)(0xC3000000);
volatile unsigned int *eth_tx_keep     = (unsigned int*)(0xC3000004);
volatile unsigned int *eth_tx_last     = (unsigned int*)(0xC3000008);


unsigned int get_rx_valid () {

    return *eth_rx_valid;
}



void get_eth_rx_last (unsigned int *last) {

    *last = *eth_rx_last; 

}

void get_eth_rx_keep (unsigned int *keep) {

    *keep = *eth_rx_keep; 

}

void read_eth_rx_data (unsigned int *data) {

    while (get_rx_valid() == 0) /* wait */ ;
    *data = *eth_rx_data; 
    // printf("[ETH] Recv data: 0x%x\r\n", *data);
    return;
}

unsigned int get_tx_ready () {
    return *eth_tx_ready;
}

void set_eth_tx_last (unsigned int last) {

    *eth_tx_last = last;

}

void set_eth_tx_keep (unsigned int keep) {

    *eth_tx_keep = keep;

}

void write_eth_tx_data (unsigned int data) {

    while (get_tx_ready() == 0) /* wait */ ;
    *eth_tx_data = data;
    // printf("[ETH] Send data: 0x%x\r\n", data);

}

unsigned int get_rst_done () 
{
    unsigned int rst_done = *eth_rst_done;
    return rst_done;
}

void get_ticks () 
{
    unsigned int rx_ticks;
    unsigned int tx_ticks;
    unsigned int round_trip_ticks;

    while (*eth_ticks_valid == 0) /* wait */ ;

    rx_ticks = *eth_rx_ticks;
    tx_ticks = *eth_tx_ticks;

    round_trip_ticks = tx_ticks - rx_ticks;

    printf("HW counter: %d ticks\n", round_trip_ticks);

    return;
}

unsigned int get_ticks_by_csr () {

    unsigned int tick;

    asm volatile ("csrrs %0, mcycle, x0" : "=r" (tick));

    return tick;
}