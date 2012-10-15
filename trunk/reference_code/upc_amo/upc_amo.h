#ifndef __upc_amo_h__
#define __upc_amo_h__

#include "upc_types.h"

/* ************************************************************** */
/* These are stand-in types from upctypes.h                       */
/* \todo reconcile these types with those from upc.h              */
/* This might be difficult so adding _AMO_                        */
/* extension to these types to disambiguate - for now             */
/* ************************************************************** */

typedef int upc_amo_op_t;

enum {
  UPC_GET = (1<<9),
  UPC_SET = (1<<10),
  UPC_CSWAP  = (1<<11),
};

/* ************************************************************** */
/* AMO specific types and enumerations                            */
/* ************************************************************** */

/**
 * \brief upc_amodomain_t
 * Opaque data type used to reference UPC AMO domains.
 * upc_amodomain_t is a shared object type, therefore pointers to domains
 * are pointers-to-shared.
 */

typedef shared struct upc_amodomain_t upc_amodomain_t;

/**
 * \brief upc_amohint_t
 * enumerated data type denoting hints to an implementation of AMOs w.r.t.
 * preferred mode of operation.
 */

typedef int upc_amohint_t;

enum { 
  UPC_AMO_HINT_DEFAULT=0, 
  UPC_AMO_HINT_LATENCY=1, 
  UPC_AMO_HINT_THROUGHPUT=2
  /* other implementation-specific values are allowed here */
};

/**
 * \brief type used to indicate whether a set of AMOs are using locks
 */

typedef int upc_amolock_t;

enum {
  UPC_AMO_LOCK_FREE=0,
  UPC_AMO_NOT_LOCK_FREE
};

/* ************************************************************** */
/*                   AMO query function                           */
/* ************************************************************** */

/**
 * \brief Query whether implementation of an AMO function uses locks
 * \param optype: the data type AMO is executed upon
 * \param ops:    the actual operation of the AMO
 * \param addr:   the target address
 * \returns       UPC_AMO_LOCK_FREE if the parameters are valid and 
 *                implementation is lock free; 
 *                UPC_AMO_NOT_LOCK_FREE otherwise.
 */

upc_amolock_t 
upc_amo_query (upc_type_t optype, upc_op_t ops, shared void *addr);

/* ************************************************************** */
/*                    domain allocator                            */  
/* ************************************************************** */

/**
 * \brief AMO collective allocator. Has barrier semantics.
 * \param ops: a bit mask of allowed operations on the new domain.
 * \param type: the data type the domain operates on.
 * \param hints: performance/functionality hints (impl. specific)
 * \returns: a domain object usable in all threads.
 */

upc_amodomain_t * upc_all_amodomain_alloc (upc_amo_op_t ops, 
					   upc_type_t optype, 
					   upc_amohint_t hints);

/**
 * \brief Collectively free an AMO domain. All threads participate.
 */

void upc_all_amodomain_free (upc_amodomain_t * domain);

/**
 * \brief Free an AMO domain. Invoked by a single thread.
 */

void upc_amodomain_free (upc_amodomain_t * domain);


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

void upc_amo_strict  (upc_amodomain_t   * domain, 
		      void              * fetch_ptr, 
		      upc_amo_op_t        op, 
		      shared void       * target, 
		      const void        * operand1, 
		      const void        * operand2);

void upc_amo_relaxed  (upc_amodomain_t  * domain, 
		       void             * fetch_ptr, 
		       upc_amo_op_t       op, 
		       shared void      * target, 
		       const void       * operand1, 
		       const void       * operand2);

#endif
