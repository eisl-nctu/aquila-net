#ifndef __ARCH_CC_H__
#define __ARCH_CC_H__

#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>

typedef int wchar_t;
typedef unsigned int wint_t;
#define LWIP_RAND() ((u32_t)rand())
#define LWIP_TIMEVAL_PRIVATE 0
#define LWIP_ERRNO_INCLUDE <errno.h>

#endif
