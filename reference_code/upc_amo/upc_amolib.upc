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
  upc_lock_t * lock;   /* we use a generic lock */
  uint32_t     ops;    /* bitmask of allowed operators */
  uint32_t     types;  /* bitmask of allowed types */
};


/* ************************************************************************ */
/*    Implementation macro for basic (lock-based) AMO, for each type        */
/* This is for integer type data types that support bitwise operations.     */
/* ************************************************************************ */

#define AMO_OP_DEF(__name__,__type__)					\
  static void upc_amo_##__name__ (upc_amo_op_t op,			\
				  __type__ * fetch,			\
				  shared __type__ * target,		\
				  const __type__ * operand1,		\
				  const __type__ * operand2)		\
  {									\
    switch (op) {							\
    case UPC_AMO_GET:							\
      assert (fetch != NULL && target != NULL);				\
      (*fetch) = (*target);						\
      break;								\
    case UPC_AMO_SET:							\
      assert (operand1 != NULL && target != NULL);			\
      (*target) = (*operand1);						\
      break;								\
    case UPC_NOT:							\
      assert (target != NULL);						\
      (*target) = !(*target);						\
      break;								\
    case UPC_AMO_SWAP:							\
      assert (fetch != NULL && operand1!=NULL && target != NULL);	\
      (*fetch) = (*target); (*target) = (*operand1);			\
      break;								\
    case UPC_AMO_ADD:							\
      assert (operand1 != NULL && target != NULL);			\
      (*target) += (*operand1);						\
      break;								\
    case UPC_AMO_AND:							\
      assert (operand1 != NULL && target != NULL);			\
      (* target) &= (* operand1);					\
      break;								\
    case UPC_AMO_XOR:							\
      assert (operand1 != NULL && target != NULL);			\
      (*target) ^= (*operand1);						\
      break;								\
    case UPC_AMO_OR:							\
      assert (operand1 != NULL && target != NULL);			\
      (*target) |= (*operand1);						\
      break;								\
    case UPC_AMO_MIN:							\
      assert (operand1 != NULL && target != NULL);			\
      if ((*target)>(*operand1)) *target = *operand1;			\
      break;								\
    case UPC_AMO_MAX:							\
      assert (operand1 != NULL && target != NULL);			\
      if ((*target)<(*operand1)) *target = *operand1;			\
      break;								\
    case UPC_AMO_CSWAP:							\
      assert (fetch != NULL && operand2 != NULL &&			\
	      operand1 != NULL && target != NULL);			\
      (*fetch) = (*target);						\
      if ((*target)==(*operand1))					\
	(*target)=(*operand2);						\
      break;								\
    default:								\
      {									\
	fprintf(stderr, "AMO operation not implemented on "		\
		"op=%d type=" #__type__ "\n", op);			\
	upc_global_exit(1);						\
      }									\
    }									\
  }									\


/* ************************************************************************ */
/*    Implementation macro for basic (lock-based) AMO, for each type        */
/* This is for float types that do not support bitwise operations.          */
/* ************************************************************************ */

#define AMO_OP_DEFF(__name__,__type__)					\
  static void upc_amo_##__name__ (upc_amo_op_t op,			\
				  __type__ * fetch,			\
				  shared __type__ * target,		\
				  const __type__ * operand1,		\
				  const __type__ * operand2)		\
  {									\
    switch (op) {							\
    case UPC_AMO_GET:							\
      assert (fetch != NULL && target != NULL);				\
      (*fetch) = (*target);						\
      break;								\
    case UPC_AMO_SET:							\
      assert (operand1 != NULL && target != NULL);			\
      /* (*target) = (*operand1); */					\
      break;								\
    case UPC_NOT:							\
      assert (target != NULL);						\
      (*target) = !(*target);						\
      break;								\
    case UPC_AMO_SWAP:							\
      assert (fetch != NULL && operand1!=NULL && target != NULL);	\
      (*fetch) = (*target); (*target) = (*operand1);			\
      break;								\
    case UPC_AMO_ADD:							\
      assert (operand1 != NULL && target != NULL);			\
      (*target) += (*operand1);						\
      break;								\
    case UPC_AMO_MIN:							\
      assert (operand1 != NULL && target != NULL);			\
      if ((*target)>(*operand1)) *target = *operand1;			\
      break;								\
    case UPC_AMO_MAX:							\
      assert (operand1 != NULL && target != NULL);			\
      if ((*target)<(*operand1)) *target = *operand1;			\
      break;								\
    case UPC_AMO_CSWAP:							\
      assert (fetch != NULL && operand2 != NULL &&			\
	      operand1 != NULL && target != NULL);			\
      (*fetch) = (*target);						\
      if ((*target)==(*operand1))					\
	(*target)=(*operand2);						\
      break;								\
    default:								\
      {									\
	fprintf(stderr, "AMO operation not implemented\n"); 		\
	upc_global_exit(1);						\
      }									\
    }									\
  }									\





  
/* ************************************************************************ */
/*                  instantiate the implementations                         */
/* ************************************************************************ */

AMO_OP_DEF(chr,    char);
AMO_OP_DEF(srt,    short);
AMO_OP_DEF(int,    int);
AMO_OP_DEF(long,   long);
AMO_OP_DEF(uchr,   unsigned char);
AMO_OP_DEF(usrt,   unsigned short);
AMO_OP_DEF(uint,   unsigned int);
AMO_OP_DEF(ulng,   unsigned long);
AMO_OP_DEF(int8,   int8_t);
AMO_OP_DEF(int16,  int16_t);
AMO_OP_DEF(int32,  int32_t);
AMO_OP_DEF(int64,  int64_t);
AMO_OP_DEF(uint8,  uint8_t);
AMO_OP_DEF(uint16, uint16_t);
AMO_OP_DEF(uint32, uint32_t);
AMO_OP_DEF(uint64, uint64_t);
AMO_OP_DEFF(flt,    float);
AMO_OP_DEFF(dbl,    double);
AMO_OP_DEFF(ldbl,   long double);

/**
 * ***************************************************************************
 * \brief AMO 
 * 
 * ***************************************************************************
 */

int  upc_amo_relaxed  (upc_amodomain_t  * domain,
		       void             * fetch_ptr,
		       upc_amo_op_t       op,
		       upc_amo_type_t     optype,
		       shared void      * target,
		       const void       * operand1,
		       const void       * operand2)
{
  struct upc_amodomain_t * ldomain = (struct upc_amodomain_t *) &domain[MYTHREAD];
  upc_lock (ldomain->lock);
  
#define UPC_AMO_CALL(__name__,__type__)					\
  upc_amo_##__name__(op, (__type__ *)fetch_ptr, (shared __type__ *)target, \
		     (const __type__ *)operand1, \
		     (const __type__ *)operand2); break;

  if (ldomain->ops != 0 && ((ldomain->ops&op)==0)) return 1;
  if (ldomain->types != 0 && ((ldomain->types&optype)==0)) return 1;
  
  switch (optype)
    {
    case UPC_AMO_CHAR:    UPC_AMO_CALL(chr,char);
    case UPC_AMO_SHORT:   UPC_AMO_CALL(srt,short);
    case UPC_AMO_INT:     UPC_AMO_CALL(int,int);
    case UPC_AMO_LONG:    UPC_AMO_CALL(long,long);
    case UPC_AMO_UCHAR:   UPC_AMO_CALL(uchr,unsigned char);
    case UPC_AMO_USHORT:  UPC_AMO_CALL(usrt,unsigned short);
    case UPC_AMO_UINT:    UPC_AMO_CALL(uint,unsigned int);
    case UPC_AMO_ULONG:   UPC_AMO_CALL(ulng,unsigned long);      
    case UPC_AMO_INT8:    UPC_AMO_CALL(int8,int8_t);
    case UPC_AMO_INT16:   UPC_AMO_CALL(int16,int16_t);
    case UPC_AMO_INT32:   UPC_AMO_CALL(int32,int32_t);
    case UPC_AMO_INT64:   UPC_AMO_CALL(int64,int64_t);
    case UPC_AMO_UINT8:   UPC_AMO_CALL(uint8,uint8_t);
    case UPC_AMO_UINT16:  UPC_AMO_CALL(uint16,uint16_t);
    case UPC_AMO_UINT32:  UPC_AMO_CALL(uint32,uint32_t);
    case UPC_AMO_UINT64:  UPC_AMO_CALL(uint64,uint64_t);      
    case UPC_AMO_FLOAT:   UPC_AMO_CALL(flt,float);
    case UPC_AMO_DOUBLE:  UPC_AMO_CALL(dbl,double);
    case UPC_AMO_LDOUBLE: UPC_AMO_CALL(ldbl,long double);
    }
  upc_unlock (ldomain->lock);
  return 0;
}

int upc_amo_strict (upc_amodomain_t  * domain,
		    void             * fetch_ptr,
		    upc_amo_op_t           op,
		    upc_amo_type_t         type,
		    shared void      * target,
		    const void       * operand1,
		    const void       * operand2)
{
  int r;
  upc_fence;
  r = upc_amo_relaxed (domain, fetch_ptr, op, type,target, operand1, operand2);
  upc_fence;
  return r;
}

/* ***************************************************************************/
/*  AMO  domain collective allocator                                         */
/* ***************************************************************************/

upc_amodomain_t * upc_amodomain_all_alloc (upc_amo_op_t ops,
                                           upc_amo_type_t types,
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
  ldomain->types = types;
  /* we ignore hint */
  return domain;
}

/* ***************************************************************************/
/*  AMO  domain one-sided allocator                                          */
/* ***************************************************************************/

upc_amodomain_t * upc_amodomain_global_alloc (upc_amo_op_t ops,
					      upc_amo_type_t types,
					      upc_amohint_t hints)
{
  upc_amodomain_t * domain = (upc_amodomain_t *)
    upc_global_alloc (THREADS, sizeof(struct upc_amodomain_t));
  assert (domain != NULL);
  struct upc_amodomain_t * ldomain = (struct upc_amodomain_t*)
    &domain[MYTHREAD];
  ldomain->lock = upc_global_lock_alloc ();
  assert (domain->lock != NULL);
  ldomain->ops = ops;
  ldomain->types = types;
  /* we ignore hint */
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

