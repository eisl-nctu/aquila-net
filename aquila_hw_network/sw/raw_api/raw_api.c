// =============================================================================
//  Program : raw_api.c
//  Author  : YI-DE, LEE
//  Date    : Apr/9/2022
// -----------------------------------------------------------------------------
//  Description:
//      The low-level API for the Aquila SoC to invoke the HW TCP/IP stack.
//
// -----------------------------------------------------------------------------
//  License information:
//
//  This software is released under the BSD-3-Clause Licence,
//  see https://opensource.org/licenses/BSD-3-Clause for details.
//  In the following license statements, "software" refers to the
//  "source code" of the complete hardware/software system.
//
//  Copyright 2019,
//                    Embedded Intelligent Systems Lab (EISL)
//                    Deparment of Computer Science
//                    National Chiao Tung Uniersity
//                    Hsinchu, Taiwan.
//
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice,
//     this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice,
//     this list of conditions and the following disclaimer in the documentation
//     and/or other materials provided with the distribution.
//
//  3. Neither the name of the copyright holder nor the names of its contributors
//     may be used to endorse or promote products derived from this software
//     without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.
// =============================================================================
#include "raw_api.h"

// For Read
volatile unsigned int *tcp_inf_status    = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x00);
volatile unsigned int *tcp_open_status   = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x04);
volatile unsigned int *tcp_listen_status = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x08);
volatile unsigned int *tcp_accept_status = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x0C);
volatile unsigned int *tcp_rx_data       = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x14);
volatile unsigned int *tcp_rx_meta       = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x34);
volatile unsigned int *tcp_tx_status     = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x38);
volatile unsigned int *tcp_notification  = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x3C);
volatile unsigned int *udp_inf_status    = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x48);
volatile unsigned int *udp_rx_data       = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x4C);
volatile unsigned int *udp_rx_meta       = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x6C);
volatile unsigned int *net_rx_ticks      = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x84);
volatile unsigned int *net_tx_ticks      = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x88);
// For Write
volatile unsigned int *tcp_close_conn    = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x00);
volatile unsigned int *tcp_open_conn     = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x04);
volatile unsigned int *tcp_listen        = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x0C);
volatile unsigned int *tcp_tx_data_keep  = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x10);
volatile unsigned int *tcp_tx_data_last  = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x14);
volatile unsigned int *tcp_tx_data       = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x18);
volatile unsigned int *tcp_tx_meta       = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x38);
volatile unsigned int *tcp_read          = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x3C);
volatile unsigned int *udp_tx_data_keep  = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x40);
volatile unsigned int *udp_tx_data_last  = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x44);
volatile unsigned int *udp_tx_data       = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x48);
volatile unsigned int *udp_tx_meta       = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x68);
volatile unsigned int *udp_port_cmd      = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x80);
volatile unsigned int *net_ip_addr       = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x84);
volatile unsigned int *net_ip_mask       = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x88);
volatile unsigned int *net_ip_gateway    = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x8C);
volatile unsigned int *net_int_enable    = (unsigned int *)(NETWORK_MODULE_BASE_ADDR + 0x90);

// -----------------------------------------------------
//                      Network API                     
// -----------------------------------------------------
void net_init (uint32_t ip_addr, uint32_t ip_mask, uint32_t ip_gateway) {

    /* byte order need to be reversed */
    *net_ip_addr    = SWAP_UINT32(ip_addr);
    *net_ip_mask    = SWAP_UINT32(ip_mask);
    *net_ip_gateway = SWAP_UINT32(ip_gateway);

    return;
}

int net_get_ticks () {

    unsigned int rx_ticks;
    unsigned int tx_ticks;
    unsigned int round_trip_ticks;

    rx_ticks = *net_rx_ticks;
    tx_ticks = *net_tx_ticks;
    round_trip_ticks = tx_ticks - rx_ticks;

    return round_trip_ticks;
}

void net_set_int (int enable) {

    *net_int_enable = enable;

    return;
}

unsigned int bytes_to_keep (unsigned int bytes) {

    unsigned int keep;

    switch (bytes)
    {
        case  0:
            keep = 0x00000000;
            break;
        case  1:
            keep = 0x00000001;
            break;
        case  2:
            keep = 0x00000003;
            break;
        case  3:
            keep = 0x00000007;
            break;
        case  4:
            keep = 0x0000000F;
            break;
        case  5:
            keep = 0x0000001F;
            break;
        case  6:
            keep = 0x0000003F;
            break;
        case  7:
            keep = 0x0000007F;
            break;
        case  8:
            keep = 0x000000FF;
            break;
        case  9:
            keep = 0x000001FF;
            break;
        case 10:
            keep = 0x000003FF;
            break;
        case 11:
            keep = 0x000007FF;
            break;
        case 12:
            keep = 0x00000FFF;
            break;
        case 13:
            keep = 0x00001FFF;
            break;
        case 14:
            keep = 0x00003FFF;
            break;
        case 15:
            keep = 0x00007FFF;
            break;
        case 16:
            keep = 0x0000FFFF;
            break;
        case 17:
            keep = 0x0001FFFF;
            break;
        case 18:
            keep = 0x0003FFFF;
            break;
        case 19:
            keep = 0x0007FFFF;
            break;
        case 20:
            keep = 0x000FFFFF;
            break;
        case 21:
            keep = 0x001FFFFF;
            break;
        case 22:
            keep = 0x003FFFFF;
            break;
        case 23:
            keep = 0x007FFFFF;
            break;
        case 24:
            keep = 0x00FFFFFF;
            break;
        case 25:
            keep = 0x01FFFFFF;
            break;
        case 26:
            keep = 0x03FFFFFF;
            break;
        case 27:
            keep = 0x07FFFFFF;
            break;
        case 28:
            keep = 0x0FFFFFFF;
            break;
        case 29:
            keep = 0x1FFFFFFF;
            break;
        case 30:
            keep = 0x3FFFFFFF;
            break;
        case 31:
            keep = 0x7FFFFFFF;
            break;
        default:
            keep = 0xFFFFFFFF;
            break;
    }

    return keep;
}

// -----------------------------------------------------
//                        TCP API                       
// -----------------------------------------------------
int tcp_get_status (int item) {
    
    unsigned int status;

    status = *tcp_inf_status;
    status = status & item;

    return status;
}

int tcp_listen_port (uint16_t port) {

    int success;

    /* Write to listen port interface */
    *tcp_listen = port;

    /* Read from listen port status interface */
    success = *tcp_listen_status;

    return success;
}

int tcp_open_connection (uint32_t ip_addr, uint16_t port, uint16_t *session_id) {

    int ret = -1;
    unsigned int tmp;

    /* Write to open connection interface */
    tcp_open_conn[0] = ip_addr;
    tcp_open_conn[1] = port;

    /* Read from open status interface */
    tmp          = *tcp_open_status;
    *session_id  = (uint16_t)tmp;

    if ((tmp >> 16) > 0)
    {
        ret = 0;
    }

    return ret;
}

void tcp_close_connection (uint16_t session_id) {
    
    /* Write to close connection interface */
    *tcp_close_conn = session_id;

    return;
}

void tcp_read_notification (tcp_packet_t *packet) {

    uint32_t tmp[3];

    /* Read from notification interface */
    tmp[0] = tcp_notification[0];
    tmp[1] = tcp_notification[1];
    tmp[2] = tcp_notification[2];

    /* Write to packet */
    packet->session_id = (uint16_t)(tmp[0]);
    packet->length     = (uint16_t)(tmp[0] >> 16);
    packet->ip_addr    = tmp[1];
    packet->dst_port   = (uint16_t)(tmp[2]);
    packet->close_flag = (uint16_t)(tmp[2] >> 16);

    return;
}

void tcp_accept (uint32_t *ip_addr, uint16_t *port, uint16_t *session_id) {

    unsigned int tmp[2];
    
    tmp[0] = tcp_accept_status[0];
    tmp[1] = tcp_accept_status[1];

    *session_id = tmp[0];
    *ip_addr    = (tmp[1] << 16) | (tmp[0] >> 16);
    *port       = (tmp[1] >> 16);

    return;
}

int tcp_recv (tcp_packet_t *packet) {

    uint16_t rx_session_id;
    uint32_t *packet_data = (uint32_t *)packet->data; /* Should align to 256 bits */
    uint32_t recv_bytes = 0;

    /* Read notification */
    tcp_read_notification(packet);

    if (packet->length == 0 || packet->close_flag)
    {
        return 0;
    }

    /* Write Read Request */
    *tcp_read = (packet->length << 16) | packet->session_id;

    /* Read RX Meta */
    rx_session_id = *tcp_rx_meta;

    /* Read RX Data */
    for (int i = 0; recv_bytes < packet->length ; i += 8) 
    {
        packet_data[i]   = tcp_rx_data[0];
        packet_data[i+1] = tcp_rx_data[1];
        packet_data[i+2] = tcp_rx_data[2];
        packet_data[i+3] = tcp_rx_data[3];
        packet_data[i+4] = tcp_rx_data[4];
        packet_data[i+5] = tcp_rx_data[5];
        packet_data[i+6] = tcp_rx_data[6];
        packet_data[i+7] = tcp_rx_data[7];
        recv_bytes += 32;
    }

    return rx_session_id;
}

int tcp_send (tcp_packet_t *packet) {
    
    uint32_t tx_status;
    uint32_t *data_buffer = (uint32_t *)packet->data;
    uint32_t bytes_remain = (packet->length & 0x1F);
    uint32_t words_num    = (packet->length >> 5) + (bytes_remain != 0);

    if (packet->length == 0)
    {
        return 0;
    }

    /* Write Meta */
    *tcp_tx_meta = (packet->length << 16) | packet->session_id;

    *tcp_tx_data_keep = 0xFFFFFFFF;
    *tcp_tx_data_last = 0;

    for (int i = 0 ; i < words_num; i++)
    {
        if (i == (words_num - 1))
        {
            *tcp_tx_data_last = 1;

            if (bytes_remain != 0)
            {
                *tcp_tx_data_keep = bytes_to_keep(bytes_remain);
            }
        }
        
        tcp_tx_data[0] = *data_buffer++;
        tcp_tx_data[1] = *data_buffer++;
        tcp_tx_data[2] = *data_buffer++;
        tcp_tx_data[3] = *data_buffer++;
        tcp_tx_data[4] = *data_buffer++;
        tcp_tx_data[5] = *data_buffer++;
        tcp_tx_data[6] = *data_buffer++;
        tcp_tx_data[7] = *data_buffer++;

    }

    /* Check whether tx status is valid */
    tx_status = *tcp_tx_status;

    return packet->length;
}

// -----------------------------------------------------
//                        UDP API                       
// -----------------------------------------------------
int udp_get_status (int item) {
    
    unsigned int status;

    status = *udp_inf_status;
    status = status & item;

    return status;
}

void udp_set_port (uint16_t port, uint16_t open) {

    /* Write to udp listen port */
    *udp_port_cmd = (port << 16) | open;

    return;
}

inline void udp_read_rx_meta (udp_packet_t *packet) {

    uint32_t tmp[3];

    tmp[0] = udp_rx_meta[0];
    tmp[1] = udp_rx_meta[4];
    tmp[2] = udp_rx_meta[5];

    /* Read RX Meta */
    packet->ip_addr  = tmp[0];
    packet->src_port = (uint16_t)(tmp[1]);
    packet->dst_port = (uint16_t)(tmp[1] >> 16);
    packet->length   = (uint16_t)(tmp[2]) - 8;

    return;
}

inline void udp_write_tx_meta (udp_packet_t *packet) {

    /* Write TX Meta */
    udp_tx_meta[0] = packet->ip_addr;
    udp_tx_meta[1] = packet->ip_addr;
    udp_tx_meta[2] = packet->ip_addr;
    udp_tx_meta[3] = packet->ip_addr;
    udp_tx_meta[4] = (packet->src_port << 16) | packet->dst_port;
    udp_tx_meta[5] = packet->length;

    return;
}

int udp_recv (udp_packet_t *packet) {

    uint32_t *packet_data = (uint32_t *)packet->data;
    uint32_t recv_bytes = 0;

    /* Read RX Meta */
    udp_read_rx_meta(packet);

    if (packet->length == 0)
    {
        return 0;
    } 

    /* Read RX Data */
    for (int i = 0; recv_bytes < packet->length ; i += 8)
    {
        packet_data[i]   = udp_rx_data[0];
        packet_data[i+1] = udp_rx_data[1];
        packet_data[i+2] = udp_rx_data[2];
        packet_data[i+3] = udp_rx_data[3];
        packet_data[i+4] = udp_rx_data[4];
        packet_data[i+5] = udp_rx_data[5];
        packet_data[i+6] = udp_rx_data[6];
        packet_data[i+7] = udp_rx_data[7];
        
        recv_bytes += 32;
    }

    return packet->length;
}

int udp_send (udp_packet_t *packet) {

    uint32_t *data_buffer = (uint32_t *)packet->data;
    uint32_t bytes_remain = (packet->length & 0x1F);
    uint32_t words_num    = (packet->length >> 5) + (bytes_remain != 0);

    if (packet->length == 0)
    {
        return 0;
    }

    /* Write TX Meta */
    udp_write_tx_meta(packet);

    *udp_tx_data_keep = 0xFFFFFFFF;
    *udp_tx_data_last = 0;

    for (int i = 0 ; i < words_num; i++)
    {
        if (i == (words_num - 1))
        {
            *udp_tx_data_last = 1;

            if (bytes_remain != 0)
            {
                *udp_tx_data_keep = bytes_to_keep(bytes_remain);
            }
        }
        
        udp_tx_data[0] = *data_buffer++; 
        udp_tx_data[1] = *data_buffer++;
        udp_tx_data[2] = *data_buffer++;
        udp_tx_data[3] = *data_buffer++;
        udp_tx_data[4] = *data_buffer++;
        udp_tx_data[5] = *data_buffer++;
        udp_tx_data[6] = *data_buffer++;
        udp_tx_data[7] = *data_buffer++;
    }

    return packet->length;
}

// -----------------------------------------------------
//                        DCA API                       
// -----------------------------------------------------

void dca_tcp_store (unsigned int addr, unsigned int length) {

    // .insn r opcode, func3, func7, rd, rs1, rs2
    asm __volatile__ (".insn r 0x0B, 0, 0, x0, %0, %1" :: "r" (addr), "r" (length));

    return;
}

void dca_tcp_load (unsigned int addr, unsigned int length) {

    asm __volatile__ (".insn r 0x0B, 1, 0, x0, %0, %1" :: "r" (addr), "r" (length));
    
    return;
}

void dca_udp_store (unsigned int addr, unsigned int length) {

    asm __volatile__ (".insn r 0x0B, 2, 0, x0, %0, %1" :: "r" (addr), "r" (length));

    return;
}

void dca_udp_load (unsigned int addr, unsigned int length) {

    asm __volatile__ (".insn r 0x0B, 3, 0, x0, %0, %1" :: "r" (addr), "r" (length));

    return;
}

int tcp_recv_dca (tcp_packet_t *packet) {

    uint16_t rx_session_id;

    /* Read from notification interface */
    tcp_read_notification(packet);

    if (packet->length == 0 || packet->close_flag)
    {
        return 0;
    }

    /* Write Read Request */
    *tcp_read = (packet->length << 16) | packet->session_id;

    /* Read RX Meta */
    rx_session_id = *tcp_rx_meta;

    /* Call Direct Cache Access Instruction */
    dca_tcp_load((unsigned int)packet->data, packet->length);

    return packet->length;
}

int tcp_send_dca (tcp_packet_t *packet) {
    
    uint32_t tx_status;

    if (packet->length == 0)
    {
        return 0;
    }

    /* Write Meta */
    *tcp_tx_meta = (packet->length << 16) | packet->session_id;
    
    /* Call Direct Cache Access Instruction */
    dca_tcp_store((unsigned int)packet->data, packet->length);

    /* Check whether tx status is valid */
    tx_status = *tcp_tx_status;

    return packet->length;
}

int udp_recv_dca (udp_packet_t *packet) {
    
    /* Read RX Meta */
    udp_read_rx_meta(packet);

    if (packet->length == 0)
    {
        return 0;
    }

    /* Call Direct Cache Access Instruction */
    dca_udp_load((unsigned int)packet->data, packet->length);

    return packet->length;
}

int udp_send_dca (udp_packet_t *packet) {

    if (packet->length == 0)
    {
        return 0;
    }

    /* Write TX Meta */
    udp_write_tx_meta(packet);

    /* Call Direct Cache Access Instruction */
    dca_udp_store((unsigned int)packet->data, packet->length);

    return packet->length;
}


