#include <raw_api.h>
/* Standard includes. */
#include <stdio.h>
#include <string.h>

void tcp_echo_client(uint32_t ip, uint16_t port)
{

    unsigned int ticks;
    int ret;
    uint16_t session_id;
    volatile char data[2048] __attribute__((aligned(32)));
    tcp_packet_t packet;

    ret = tcp_open_connection(ip, port, &session_id);
    printf("[Client test] TCP connect success, session_id : %d\n", session_id);

    packet.session_id = session_id;
    packet.data = (uint8_t *)data;

    while (1)
    {
        tcp_recv(&packet);
        tcp_send(&packet);

        ticks = net_get_ticks();
        printf("%d\n", ticks);
    }

    return;
}

void tcp_echo_server(uint16_t port)
{

    unsigned int ticks;
    int success;
    volatile char data[2048] __attribute__((aligned(32)));
    tcp_packet_t packet;

    success = tcp_listen_port(port);
    printf("[Server test] TCP listen port success : %d\n", success);

    packet.data = (uint8_t *)data;

    while (1)
    {
        tcp_recv(&packet);
        tcp_send(&packet);

        ticks = net_get_ticks();
        printf("%d\n", ticks);
    }

    return;
}

void tcp_echo_server_dca(uint16_t port)
{

    unsigned int ticks;
    int success;
    volatile char data[2048] __attribute__((aligned(32)));
    tcp_packet_t packet;

    success = tcp_listen_port(port);
    printf("[Server test] TCP listen port success : %d\n", success);

    packet.data = (uint8_t *)data;

    while (1)
    {
        tcp_recv_dca(&packet);
        tcp_send_dca(&packet);

        ticks = net_get_ticks();
        printf("%d\n", ticks);
    }

    return;
}

void udp_echo_server(uint16_t port)
{

    unsigned int ticks;
    volatile char data[2048] __attribute__((aligned(32)));
    udp_packet_t packet;
    uint16_t tmp;

    udp_set_port(port, 1);
    packet.data = (uint8_t *)data;

    while (1)
    {
        udp_recv(&packet);

        tmp = packet.dst_port;
        packet.dst_port = packet.src_port;
        packet.src_port = tmp;

        udp_send(&packet);

        ticks = net_get_ticks();
        printf("%d\n", ticks);
    }

    return;
}

void udp_echo_server_dca(uint16_t port)
{

    unsigned int ticks;
    volatile char data[2048] __attribute__((aligned(32)));
    udp_packet_t packet;
    uint16_t tmp;

    udp_set_port(port, 1);
    packet.data = (uint8_t *)data;

    while (1)
    {
        udp_recv_dca(&packet);

        tmp = packet.dst_port;
        packet.dst_port = packet.src_port;
        packet.src_port = tmp;

        udp_send_dca(&packet);

        ticks = net_get_ticks();
        printf("%d\n", ticks);
    }

    return;
}

int main(void)
{
    /*   local ip       net mask      gateway  */
    /* 10.1.212.209, 255.255.255.0, 10.1.212.1 */
    net_init(0x0A01D4D1, 0xFFFFFF00, 0x0A01D401);

    printf("Start raw echo test\n");

    tcp_echo_server(12345);
    // tcp_echo_server_dca(12345);

    // udp_echo_server(12345);
    // udp_echo_server_dca(12345);

    return 0;
}
