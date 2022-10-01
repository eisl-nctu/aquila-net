#ifndef __SOCKET_API__H__
#define __SOCKET_API__H__
#include "raw_api.h"
#include "stdint.h"
#include "stdlib.h"
#include "string.h"
#include "stdio.h"
/* FreeRTOS includes. */
#include "FreeRTOS.h"
#include "semphr.h"
#include "task.h"

/* Use Direct Cache Access */
#define USE_DCA         1

/* Use interrupt mechanism */
#define USE_INT         1

/* Priority */
#define SOCKET_USER_DEFAULT_PRIO 3

#if USE_INT
    #define SOCKET_CORE_DEFAULT_PRIO 6
#else
    #define SOCKET_CORE_DEFAULT_PRIO 3
#endif
/* Socket family and protocol */
#define AF_INET         2
#define PF_INET         AF_INET
/* Socket type */
#define SOCK_STREAM     1
#define SOCK_DGRAM      2

#define MAX_SOCKET_NUM 64
#define CHECK_PHY_IP_ADDR(ip) (ip == phy_ip_addr)

typedef uint32_t socklen_t;

struct in_addr {
    uint32_t s_addr;
};

struct sockaddr_in {
    uint8_t         sin_len;
    uint8_t         sin_family;
    uint16_t        sin_port;
    struct in_addr  sin_addr;
    char            sin_zero[8];
};

struct sockaddr {
    uint8_t     sa_len;
    uint8_t     sa_family;
    char        sa_data[14];
};

struct data_block_t {
    uint32_t ip_addr;
    uint16_t port;
    uint16_t flag;
    uint16_t length;
    uint16_t readed_bytes;
    uint8_t  *data;
    struct data_block_t *next;
};

struct data_list_t {
    struct data_block_t *head;
    struct data_block_t *tail;
};

struct socket_info {
    uint8_t  type;
    uint32_t ip_addr;
    uint16_t port;
    uint16_t phy_fd;
    struct data_list_t data_list;
};

/* Socket APIs */
int socket_init();
int socket(int family, int type, int protocol);
int accept(int sfd, struct sockaddr *addr, socklen_t *addr_length);
int bind(int sfd, const struct sockaddr *addr, socklen_t addr_length);
int connect(int sfd, struct sockaddr *addr, socklen_t addr_length);
int listen(int sfd, int backlog);
int recv(int sfd, void *buffer, uint32_t num_bytes, int flags);
int send(int sfd, void *buffer, uint32_t num_bytes, int flags);
int recvfrom(int sfd, void *buffer, uint32_t num_bytes, int flags, struct sockaddr *addr, socklen_t *addr_length);
int sendto(int sfd, void *buffer, uint32_t num_bytes, int flags, struct sockaddr *addr, socklen_t addr_length);
int close(int sfd);

/* Interrupt Handler */
void socket_int_handler();

#endif