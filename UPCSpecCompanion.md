# Contents #


# Introduction #

This document is intended as a companion to the UPC Specification. It provides non-authoritative additional information to assist in interpreting that specification. The contents fall into several general categories:

  * Clarification: The UPC Specification is a formal specification document, written as a diff to C99. It is intentionally designed to be concise and minimalistic, but this can occasionally obscure some subtle points which are only apparent with a good working knowledge of the C99 specification. This document helps to further explain the implications of the UPC specification for cases of common confusion.
  * Rationale: Some of the design choices made in the UPC specification lack an obvious motivation, or have implications for users or implementations which can be subtle. This document attempts to provide rationale for such aspects of the spec, to help reveal the motivations and design philosophy underlying the specification.
  * Best-Practice : The community has developed a number of informal "Best-Practice" techniques for effective, efficient and portable UPC programming. This document collects and presents this advice to UPC users.
  * Advice to Implementations: There are numerous non-obvious techniques and algorithms that can be useful for implementing UPC on various platforms. This document provides a common knowledge base for sharing of advice to implementers.

# Scope and Normative References #


This document is intended to accompany the following documents:

  * [[UPCSpec](http://upc-specification.googlecode.com/files/upc_specs_1.2.pdf)]       The UPC Language Specification version 1.2, ratified May 2005
  * [[UPCSpecDraft](UPCSpecDraft.md)]  The UPC Language and Core Library Specification version 1.3, currently in draft
  * [[UPCLibOptDraft](UPCLibOptDraft.md)]  The UPC Optional Libraries specification version 1.3, currently in draft
  * [[UPCLibReqDraft](UPCLibReqDraft.md)]  The UPC Optional Libraries specification version 1.3, currently in draft
  * [[C99](http://www.iso-9899.info/wiki/The_Standard)]           ISO/IEC 9899: 1999(E), Programming languages - C

# Authority #

It should be noted that in all cases this is NOT an authoritative document. The formally ratified [[UPCSpec](UPCSpec.md)] is the sole authoritative source on all matters UPC, and if this document makes any statements or implications that differ (through error or version drift), then it is this document that is incorrect. Any clarifications, examples or expanded descriptions stated herein are also not authoritative - the UPC intentionally leaves some matters underspecified to allow implementation freedom, and any statement herein does not further constrain the implementation behavior required by [UPCSpec](UPCSpec.md).

# General Rationale #

# Best-Practices and Advice to Users #

# General Advice to Implementers #

# Section-wise Language Clarifications and Rationale #

This section provides section-by-section clarification and rationale information to accompany the UPC specifications.

## Section 3: Terms and Definitions ##

## Section 5: Environment ##

## Section 6.3: Pre-Defined Identifiers ##

## Section 6.4: Expressions ##

## Section 6.5: Declarations ##

## Section 6.6: Statements and Blocks ##

## Section 6.7: Preprocessing Directives ##

## Appendix A: Process for Specification Changes and Updates ##

## Appendix B: Formal UPC Memory Consistency Semantics ##

# Library Clarifications and Rationale #

## Section 7.2: Core UPC Utility Library <upc.h> ##

### Section 7.2.2: Shared Memory Allocation Functions ###

### Section 7.2.3: Pointer-to-Shared Manipulation Functions ###

### Section 7.2.4: UPC Lock Functions ###

### Section 7.2.5: Synchronous Bulk Transfer Functions ###

## Collective Utilities Library <upc\_collective.h> ##

## Parallel I/O Library <upc\_io.h> ##


# Frequently Asked Questions (FAQ) #

## General FAQ ##
### What platforms support UPC? ###
> ...
### Where can I find more information about current implementations? ###
> ...
### Where can I find examples of application code written in UPC? ###
> ...
## Language Issues FAQ ##

## Library Issues FAQ ##