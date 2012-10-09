#include <upc.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>

#include "upc_amo.h"

#define TEST_ADD(__name__,__type__)					\
  shared __type__ _test_amo_add_##__name__;				\
  									\
  void test_amo_add_##__name__ (upc_amodomain_t * domain)		\
  {									\
    if (MYTHREAD==0) { printf ("test amo_add " #__name__		\
			       " ... "); fflush(stdout); }		\
    __type__ incr = 1;							\
    _test_amo_add_##__name__ = 0;					\
    upc_barrier;							\
    upc_amo_relaxed (domain, NULL,					\
		     UPC_AMO_ADD, UPC_AMO_##__name__,			\
		     &_test_amo_add_##__name__,				\
		     & incr, NULL);					\
    upc_barrier;							\
    if (MYTHREAD==0)							\
      if (_test_amo_add_##__name__ != THREADS)				\
	printf ("failed exp=%d actual=%d\n",				\
		THREADS, (int)_test_amo_add_##__name__);		\
      else								\
	printf ("passed\n");						\
  }									\
  
TEST_ADD(CHAR, char);
TEST_ADD(SHORT, short);
TEST_ADD(INT, int);
TEST_ADD(LONG, long);
TEST_ADD(UCHAR, unsigned char);
TEST_ADD(USHORT, unsigned short);
TEST_ADD(UINT, unsigned int);
TEST_ADD(ULONG, unsigned long);
TEST_ADD(INT8, int8_t);
TEST_ADD(INT16, int16_t);
TEST_ADD(INT32, int32_t);
TEST_ADD(INT64, int64_t);
TEST_ADD(UINT8, uint8_t);
TEST_ADD(UINT16, uint16_t);
TEST_ADD(UINT32, uint32_t);
TEST_ADD(UINT64, uint64_t);
TEST_ADD(FLOAT, float);
TEST_ADD(DOUBLE, double);
TEST_ADD(LDOUBLE, long double);


int main(int argc, char ** argv)
{
  upc_amodomain_t * d = upc_amodomain_all_alloc (0, 0, 0);
  test_amo_add_CHAR(d);
  test_amo_add_SHORT (d);
  test_amo_add_INT (d);
  test_amo_add_LONG (d);
  test_amo_add_UCHAR (d);
  test_amo_add_USHORT(d);
  test_amo_add_UINT (d);
  test_amo_add_ULONG (d);


  if (MYTHREAD==0) upc_amodomain_free (d);
  return 0;
}

