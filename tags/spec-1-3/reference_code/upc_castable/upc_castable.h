/* Reference implementation of upc_castable.h 
 * Copyright 2012, Dan Bonachea
 * This header is hereby placed in the public domain
 */

#ifndef _UPC_CASTABLE_H
#define _UPC_CASTABLE_H

#if __UPC_CASTABLE__ != 1
#error Bad feature macro predefinition
#endif

#include <stddef.h> /* size_t */

#define UPC_CASTABLE_ALL_ALLOC      (1<<0)
#define UPC_CASTABLE_GLOBAL_ALLOC   (1<<1)
#define UPC_CASTABLE_ALLOC          (1<<2)
#define UPC_CASTABLE_STATIC         (1<<3)

#define UPC_CASTABLE_ALL  (            \
           UPC_CASTABLE_ALL_ALLOC    | \
           UPC_CASTABLE_GLOBAL_ALLOC | \
           UPC_CASTABLE_ALLOC        | \
           UPC_CASTABLE_STATIC         \
         )

typedef struct _S_upc_thread_info {
  int guaranteedCastable;
  int probablyCastable;
} upc_thread_info_t;


void *upc_cast(const shared void *);

upc_thread_info_t upc_thread_info(size_t);

#endif /* _UPC_CASTABLE_H */
