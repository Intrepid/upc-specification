#ifndef __upc_amo_h__
#define __upc_amo_h__

/* ************************************************************** */
/* These are stand-in types from from upctypes.h                  */
/* \todo: we need to make sure that upc.h enumerates these ops    */
/* in a bit-masked fashion, so that combinations are possible.    */
/* ************************************************************** */

typedef int upc_amo_type_t;

enum {
  UPC_AMO_CHAR     = (1<<0),  
  UPC_AMO_SHORT    = (1<<1),  
  UPC_AMO_INT      = (1<<2),
  UPC_AMO_LONG     = (1<<3),
  UPC_AMO_UCHAR    = (1<<4),
  UPC_AMO_USHORT   = (1<<5),
  UPC_AMO_UINT     = (1<<6),
  UPC_AMO_ULONG    = (1<<7),
  UPC_AMO_INT8     = (1<<8),
  UPC_AMO_INT16    = (1<<9),
  UPC_AMO_INT32    = (1<<10),
  UPC_AMO_INT64    = (1<<11),
  UPC_AMO_UINT8    = (1<<12),
  UPC_AMO_UINT16   = (1<<13),
  UPC_AMO_UINT32   = (1<<14),
  UPC_AMO_UINT64   = (1<<15),
  UPC_AMO_FLOAT    = (1<<16),
  UPC_AMO_DOUBLE   = (1<<17),
  UPC_AMO_LDOUBLE  = (1<<18),
  UPC_AMO_PTS      = (1<<19),
  UPC_AMO_NTYPES   = (1<<20)
};

/* ************************************************************** */
/* These are stand-in types from upctypes.h                       */
/* \todo reconcile these types with those from upc.h              */
/* This might be difficult so adding _AMO_                        */
/* extension to these types to disambiguate - for now             */
/* ************************************************************** */

typedef int upc_amo_op_t;

enum {
  UPC_AMO_GET    = (1<<0),
  UPC_AMO_SET    = (1<<1),
  UPC_NOT        = (1<<2),
  UPC_AMO_SWAP   = (1<<3),
  UPC_AMO_ADD    = (1<<4),
  UPC_AMO_AND    = (1<<5),
  UPC_AMO_XOR    = (1<<6),
  UPC_AMO_OR     = (1<<7),
  UPC_AMO_MIN    = (1<<8),
  UPC_AMO_MAX    = (1<<9),
  UPC_AMO_CSWAP  = (1<<10),
  UPC_AMO_NOPS   = (1<<11)
};

/* ************************************************************** */
/* AMO specific types and enumerations                            */
/* ************************************************************** */

typedef int upc_amohint_t;

enum { 
  UPC_AMO_DEFAULT=0, 
  UPC_AMO_LATENCY, 
  UPC_AMO_THROUGHPUT
};

typedef struct upc_amodomain_t upc_amodomain_t;

/* ************************************************************** */
/*                    domain allocator                            */  
/* ************************************************************** */

upc_amodomain_t * upc_amodomain_all_alloc (upc_amo_op_t ops, 
					   upc_amo_type_t type, 
					   upc_amohint_t hints);

void upc_amodomain_free (upc_amodomain_t *ptr);

/* ************************************************************** */
/*                  domain query: what is implemented?            */
/* ************************************************************** */

int upc_amo_query   (upc_amodomain_t *domain,
		     upc_amo_op_t op, 
		     upc_amo_type_t optype);

/* ************************************************************** */
/*                 prototype declarations for AMOs                */
/* ************************************************************** */

/**
 * \brief STRICT AMO
 * \param domain the AMO domain we operate on
 * \param fetch_ptr: deposit any remote fetched values here
 * \param op: the AMO operation. 
 * \param optype: data type of fetch_ptr, target, operand{1,2}
 * \param target: the (shared) target we are atomically updating
 * \param operand1: the first operand to ADD, etc. or the SWAP compare value
 * \param operand2: the second operand: e.g. the CSWAP new value
 * \returns 0 if operation completed correctly, 1 if unimplemented
 */

int upc_amo_strict  (upc_amodomain_t *domain, 
		     void *fetch_ptr, 
		     upc_amo_op_t op, 
		     upc_amo_type_t optype,
		     shared void *target, 
		     const void *operand1, 
		     const void *operand2);

int upc_amo_relaxed  (upc_amodomain_t *domain, 
		      void *fetch_ptr, 
		      upc_amo_op_t op, 
		      upc_amo_type_t optype,
		      shared void *target, 
		      const void *operand1, 
		      const void *operand2);

#endif
