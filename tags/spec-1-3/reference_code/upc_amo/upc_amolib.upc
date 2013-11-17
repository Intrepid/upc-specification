#include <upc.h>
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#include "upc_amo.h"

/* ************************************************************************ */
/*               internal type definition for AMO domain                    */
/* ************************************************************************ */

struct upc_amodomain_t
{
  upc_lock_t * lock;    /* we use a generic lock */
  uint32_t     ops;     /* bitmask of allowed operators */
  uint32_t     optype;  /* the type we operate upon */
};


#define AMO_OP_GET				\
  case UPC_GET:					\
  break;			

#define AMO_OP_SET						      \
  case UPC_SET: 						      \
  assert (operand1 != NULL && target != NULL);			      \
  (*target) = (*operand1);					      \
  break;

#define AMO_OP_ADD							\
  case UPC_ADD:								\
  assert (operand1 != NULL);						\
  (*target) += (*operand1);						\
  break;

#define AMO_OP_MULT							\
  case UPC_MULT:							\
  assert (operand1 != NULL);						\
  (*target) *= (*operand1);						\
  break;

#define AMO_OP_AND							\
  case UPC_AND:								\
  assert (operand1 != NULL);						\
  (* target) &= (* operand1);						\
  break;

#define AMO_OP_OR							\
  case UPC_OR:								\
  assert (operand1 != NULL);						\
  (*target) |= (*operand1);						\
  break;

#define AMO_OP_XOR						\
  case UPC_XOR:								\
  assert (operand1 != NULL);						\
  (*target) ^= (*operand1);						\
  break;

#define AMO_OP_LAND							\
  case UPC_LOGAND:							\
  assert (operand1 != NULL);						\
  (* target) = (*target) && (* operand1);				\
  break;

#define AMO_OP_LOR							\
  case UPC_LOGOR:							\
  assert (operand1 != NULL);						\
  (*target) = (*target) || (*operand1);					\
  break;

#define AMO_OP_MIN							\
  case UPC_MIN:							\
  assert (operand1 != NULL);						\
  if ((*target)>(*operand1)) *target = *operand1;			\
  break;

#define AMO_OP_MAX							\
  case UPC_MAX:							\
  assert (operand1 != NULL);						\
  if ((*target)<(*operand1)) *target = *operand1;			\
  break;

#define AMO_OP_CSWAP							\
  case UPC_CSWAP:							\
  assert (operand2 != NULL && operand1 != NULL);			\
  if ((*target)==(*operand1)) (*target)=(*operand2);			\
  break;

#define AMO_OP_DFLT(__type__)						\
  default:								\
  {									\
    fprintf(stderr, "AMO operation not implemented on "			\
	    "op=%d type=" #__type__ "\n", op);				\
    upc_global_exit(1);							\
  }

/* ************************************************************************ */
/* Implementation macro for basic (lock-based) AMO, for integer types       */
/* ************************************************************************ */

#define AMO_OP_DEFI(__name__,__type__)					\
  static void upc_amo_##__name__ (upc_amo_op_t           op,		\
				  __type__             * fetch,		\
				  shared __type__      * target,	\
				  const __type__       * operand1,	\
				  const __type__       * operand2)	\
  {									\
    assert (target != NULL);						\
    if (fetch) (*fetch) = (*target);					\
    switch (op) {							\
      AMO_OP_GET;  AMO_OP_SET;  AMO_OP_CSWAP;				\
      AMO_OP_ADD;  AMO_OP_MULT;						\
      AMO_OP_AND;  AMO_OP_OR;   AMO_OP_XOR; 				\
      AMO_OP_LAND; AMO_OP_LOR;						\
      AMO_OP_MIN;  AMO_OP_MAX;						\
      AMO_OP_DFLT(__type__);						\
    }									\
  }									\
  
/* ************************************************************************ */
/* Implementation macro for basic (lock-based) AMO, for floating point      */
/* ************************************************************************ */

#define AMO_OP_DEFF(__name__,__type__)					\
  static void upc_amo_##__name__ (upc_amo_op_t          op,		\
				  __type__            * fetch,		\
				  shared __type__     * target,		\
				  const __type__      * operand1,	\
				  const __type__      * operand2)	\
  {									\
    assert (target != NULL);						\
    if (fetch) (*fetch) = (*target);					\
    switch (op) {							\
      AMO_OP_GET;  AMO_OP_SET;  AMO_OP_CSWAP;				\
      AMO_OP_ADD;  AMO_OP_MULT;						\
      AMO_OP_LAND; AMO_OP_LOR;						\
      AMO_OP_MIN;  AMO_OP_MAX;						\
      AMO_OP_DFLT(__type__);						\
    }									\
  }									\
  
/* ************************************************************************ */
/* Implementation macro for basic (lock-based) AMO, for pointer types       */
/* ************************************************************************ */
typedef shared void * svptr_t;

#define AMO_OP_DEFP(__name__,__type__)					\
  static void upc_amo_##__name__ (upc_amo_op_t         op,		\
				  __type__           * fetch,		\
				  shared __type__    * target,		\
				  const __type__     * operand1,	\
                                  const __type__     * operand2)	\
  {                                                                     \
    assert (target != NULL);                                            \
    if (fetch) (*fetch) = (*target);                                    \
    switch (op) {                                                       \
      AMO_OP_CSWAP;							\
      AMO_OP_DFLT(__type__);						\
    }									\
  }
  
/* ************************************************************************ */
/*                  instantiate the implementations                         */
/* ************************************************************************ */

AMO_OP_DEFI(chr,    char);
AMO_OP_DEFI(uchr,   unsigned char);
AMO_OP_DEFI(srt,    short);
AMO_OP_DEFI(usrt,   unsigned short);
AMO_OP_DEFI(int,    int);
AMO_OP_DEFI(uint,   unsigned int);
AMO_OP_DEFI(long,   long);
AMO_OP_DEFI(ulng,   unsigned long);
AMO_OP_DEFI(int8,   int8_t);
AMO_OP_DEFI(uint8,  uint8_t);
AMO_OP_DEFI(int16,  int16_t);
AMO_OP_DEFI(uint16, uint16_t);
AMO_OP_DEFI(int32,  int32_t);
AMO_OP_DEFI(uint32, uint32_t);
AMO_OP_DEFI(int64,  int64_t);
AMO_OP_DEFI(uint64, uint64_t);
AMO_OP_DEFF(flt,    float);
AMO_OP_DEFF(dbl,    double);
AMO_OP_DEFF(ldbl,   long double);
AMO_OP_DEFP(ptr,    svptr_t);

/* ************************************************************************ */
/* ************************************************************************ */

void upc_amo_relaxed  (upc_amodomain_t  * domain,
		       void             * fetch_ptr,
		       upc_amo_op_t       op,
		       shared void      * target,
		       const void       * operand1,
		       const void       * operand2)
{
  struct upc_amodomain_t * ldomain = (struct upc_amodomain_t *) &domain[MYTHREAD];
  upc_lock (ldomain->lock);
  
#define UPC_AMO_CALL(__name__,__type__)					\
  upc_amo_##__name__(op, (__type__ *)fetch_ptr, (shared __type__ *)target, \
		     (const __type__ *)operand1,			\
		     (const __type__ *)operand2); break;

  switch (ldomain->optype)
    {
    case UPC_CHAR:    UPC_AMO_CALL(chr,char);
    case UPC_SHORT:   UPC_AMO_CALL(srt,short);
    case UPC_INT:     UPC_AMO_CALL(int,int);
    case UPC_LONG:    UPC_AMO_CALL(long,long);
    case UPC_UCHAR:   UPC_AMO_CALL(uchr,unsigned char);
    case UPC_USHORT:  UPC_AMO_CALL(usrt,unsigned short);
    case UPC_UINT:    UPC_AMO_CALL(uint,unsigned int);
    case UPC_ULONG:   UPC_AMO_CALL(ulng,unsigned long);      
    case UPC_INT8:    UPC_AMO_CALL(int8,int8_t);
    case UPC_INT16:   UPC_AMO_CALL(int16,int16_t);
    case UPC_INT32:   UPC_AMO_CALL(int32,int32_t);
    case UPC_INT64:   UPC_AMO_CALL(int64,int64_t);
    case UPC_UINT8:   UPC_AMO_CALL(uint8,uint8_t);
    case UPC_UINT16:  UPC_AMO_CALL(uint16,uint16_t);
    case UPC_UINT32:  UPC_AMO_CALL(uint32,uint32_t);
    case UPC_UINT64:  UPC_AMO_CALL(uint64,uint64_t);      
    case UPC_FLOAT:   UPC_AMO_CALL(flt,float);
    case UPC_DOUBLE:  UPC_AMO_CALL(dbl,double);
    case UPC_LDOUBLE: UPC_AMO_CALL(ldbl,long double);
    case UPC_PTS:     UPC_AMO_CALL(ptr, svptr_t);
    }
  upc_unlock (ldomain->lock);
}

/* ************************************************************************ */
/* ************************************************************************ */

void upc_amo_strict (upc_amodomain_t  * domain,
		     void             * fetch_ptr,
		     upc_amo_op_t       op,
		     shared void      * target,
		     const void       * operand1,
		     const void       * operand2)
{
  upc_fence;
  upc_amo_relaxed (domain, fetch_ptr, op, target, operand1, operand2);
  upc_fence;
}

/* ***************************************************************************/
/*            UPC AMO domain allocator (collective)                          */
/* ***************************************************************************/

upc_amodomain_t * upc_all_amodomain_alloc (upc_amo_op_t ops,
                                           upc_type_t optype,
                                           upc_amohint_t hints)
{
  upc_amodomain_t * domain = (upc_amodomain_t *)
    upc_all_alloc (THREADS, sizeof(struct upc_amodomain_t));
  assert (domain != NULL);
  struct upc_amodomain_t * ldomain = (struct upc_amodomain_t*)
    &domain[MYTHREAD];
  ldomain->lock = upc_all_lock_alloc ();
  assert (domain->lock != NULL);
  ldomain->ops = ops;
  ldomain->optype = optype;
  /* we ignore hint in this baseline implementation */
  return domain;
}

/* ***************************************************************************/
/*           UPC AMO domain free (one-sided)                                 */
/* ***************************************************************************/

void upc_amodomain_free (upc_amodomain_t * domain)
{
  assert (domain != NULL);
  upc_lock_free (domain->lock);
  upc_free (domain);
}

/* ***************************************************************************/
/*           UPC AMO domain free (collective)                                */
/* ***************************************************************************/

void upc_all_amodomain_free (upc_amodomain_t * domain)
{
  assert (domain != NULL);
  upc_barrier;
  if (MYTHREAD==0) {
    upc_lock_free (domain->lock);
    upc_free (domain);
  }
  upc_barrier;
}

/* ************************************************************************ */
/*          UPC AMO query                                                   */
/* ************************************************************************ */
/* Since this is a brain dead implementation we always return non-lock-free */
/* ************************************************************************ */

upc_amolock_t
upc_amo_query (upc_type_t optype, upc_op_t ops, shared void *addr)
{
  return UPC_AMO_NOT_LOCK_FREE;
}

