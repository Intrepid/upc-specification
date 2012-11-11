#include <upc.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>

#include "upc_amo.h"

#define TEST(__name__,__type__)						\
  shared __type__ _test_amo_add_##__name__;				\
  									\
  void test_amo_add_##__name__ (void)					\
  {									\
    if (MYTHREAD==0) { printf ("test amo_add " #__name__		\
			       " ... "); fflush(stdout); }		\
    __type__ incr = 1;							\
    _test_amo_add_##__name__ = 0;					\
    upc_amodomain_t *d =upc_all_amodomain_alloc (0, UPC_##__name__,0);	\
    upc_barrier;							\
    upc_amo_relaxed (d, NULL,						\
		     UPC_ADD,						\
		     &_test_amo_add_##__name__,				\
		     & incr, NULL);					\
    upc_barrier;							\
    if (MYTHREAD==0)							\
      if (_test_amo_add_##__name__ != THREADS)				\
	printf ("failed exp=%d actual=%d\n",				\
		THREADS, (int)_test_amo_add_##__name__);		\
      else								\
	printf ("passed\n");						\
    upc_all_amodomain_free (d);						\
  }									\
									\
  shared __type__ _test_amo_cswap_##__name__;				\
									\
  void test_amo_cswap_##__name__ (void)					\
  {									\
    if (MYTHREAD==0) { printf ("test amo_cswap " #__name__		\
			       " ... "); fflush(stdout); }		\
    __type__ cmp = 0;							\
    __type__ myval = MYTHREAD;						\
    __type__ fetch;							\
    _test_amo_cswap_##__name__ = 0;					\
    _test_amo_add_##__name__ = 0;					\
    upc_amodomain_t *d =upc_all_amodomain_alloc (0, UPC_##__name__,0);	\
    upc_barrier;							\
    /* GET THE LOCK */							\
    do {								\
      upc_amo_relaxed (d, &fetch,					\
		       UPC_CSWAP,					\
		       &_test_amo_cswap_##__name__,			\
		       & cmp, &myval);					\
    } while (fetch!=0);							\
    									\
    /* INCREMENT THE COUNTER */						\
    _test_amo_add_##__name__++;						\
									\
    /* UNLOCK */							\
    upc_amo_relaxed(d, NULL, UPC_SET,					\
		    &_test_amo_cswap_##__name__,			\
		    &cmp, NULL);					\
									\
    upc_barrier;							\
    if (MYTHREAD==0)							\
      if (_test_amo_add_##__name__ != THREADS)				\
	printf ("failed exp=%d actual=%d\n",				\
		THREADS, (int)_test_amo_add_##__name__);		\
      else								\
	printf ("passed\n");						\
    upc_all_amodomain_free (d);						\
  }									\

TEST(INT, int);
TEST(DOUBLE, double);

int main(int argc, char ** argv)
{
  test_amo_add_INT();
  test_amo_add_DOUBLE();

  test_amo_cswap_INT();
  return 0;
}

