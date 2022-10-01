// =============================================================================
//  Program : raw_api.h
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
//  Copyright 2022,
//                    Embedded Intelligent Systems Lab (EISL)
//                    Deparment of Computer Science
//                    National Yang Ming Chiao Tung Uniersity
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
#ifndef __RAW_API__H__
#define __RAW_API__H__
#include <stdint.h>

#define NETWORK_MODULE_BASE_ADDR        (0xC3000000)
#define SWAP_UINT32(x)                  (((x) >> 24) | (((x) & 0x00FF0000) >> 8) | (((x) & 0x0000FF00) << 8) | ((x) << 24))

/* Interface status */
#define TCP_LISTEN_PORT_READY     (1 << 0)
#define TCP_LISTEN_PORT_STS_VALID (1 << 1)
#define TCP_ACCEPT_STS_VALID      (1 << 2)
#define TCP_OPEN_CONN_READY       (1 << 3)
#define TCP_OPEN_STS_VALID        (1 << 4)
#define TCP_CLOSE_CONN_READY      (1 << 5)
#define TCP_NOTIFICATION_VALID    (1 << 6)
#define TCP_READY_PACKET_READY    (1 << 7)
#define TCP_RX_META_VALID         (1 << 8)
#define TCP_RX_DATA_VALID         (1 << 9)
#define TCP_TX_META_READY         (1 << 10)
#define TCP_TX_DATA_READY         (1 << 11)
#define TCP_TX_STS_VALID          (1 << 12)

#define UDP_PORT_CMD_READY        (1 << 0)
#define UDP_RX_DATA_VALID         (1 << 1)
#define UDP_TX_DATA_READY         (1 << 2)
#define UDP_RX_META_VALUD         (1 << 3)
#define UDP_TX_META_READY         (1 << 4)

/*
    ip_addr represent, 
        - recv : source ip address
        - send : destination ip address
*/

typedef struct tcp_packet_t {
    uint32_t ip_addr;
    uint16_t dst_port;
    uint16_t session_id;
    uint16_t length;
    uint16_t close_flag;
    uint8_t  *data;
} tcp_packet_t;

typedef struct udp_packet_t {
    uint32_t ip_addr;
    uint16_t dst_port;
    uint16_t src_port;
    uint16_t length;
    uint8_t  *data;
} udp_packet_t;

/* Network API */
void net_init(uint32_t ip_addr, uint32_t ip_mask, uint32_t ip_gateway);
int net_get_ticks();
void net_set_int(int enable);
/* TCP/IP API */
int tcp_get_status(int item);
int tcp_listen_port(uint16_t port);
int tcp_open_connection(uint32_t ip_addr, uint16_t port, uint16_t *session_id);
void tcp_close_connection(uint16_t session_id);
void tcp_read_notification(tcp_packet_t *packet);
void tcp_accept(uint32_t *ip_addr, uint16_t *port, uint16_t *session_id);
int tcp_recv(tcp_packet_t *packet);
int tcp_send(tcp_packet_t *packet);
/* UDP API */
int udp_get_status(int item);
void udp_set_port(uint16_t port, uint16_t open);
void udp_read_rx_meta(udp_packet_t *packet);
void udp_write_tx_meta(udp_packet_t *packet);
int udp_recv(udp_packet_t *packet);
int udp_send(udp_packet_t *packet);
/* DCA Instructions */
void dca_tcp_load(unsigned int addr, unsigned int length);
void dca_tcp_store(unsigned int addr, unsigned int length);
void dca_udp_load(unsigned int addr, unsigned int length);
void dca_udp_store(unsigned int addr, unsigned int length);
/* DCA User API */
int tcp_recv_dca(tcp_packet_t *packet);
int tcp_send_dca(tcp_packet_t *packet);
int udp_recv_dca(udp_packet_t *packet);
int udp_send_dca(udp_packet_t *packet);

#endif
