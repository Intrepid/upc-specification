# Introduction #

This page lists the UPC specification changes introduced in version 1.3 that are likely to have an implementation impact on existing UPC 1.2 compilers seeking to upgrade their compliance. Wording clarifications and other minor changes that are unlikely to have an implementation impact are omitted, but can be seen in the [complete list of changes to the spec](http://code.google.com/p/upc-specification/issues/list?can=1&q=status%3ARatified+Milestone%3DSpec-1.3&sort=id). In many cases constructs that were accepted or underspecified in 1.2 have become explicitly prohibited/undefined under 1.3; in the case of a strengthened Constraint, type-checker implementations are required to issue a diagnostic to be in full compliance. In the case of Semantic behavior that has become undefined, implementations may already be compliant, although there may be an opportunity to remove some outdated support which is no longer required for compliance.

Each change links to the relevant issue thread, which usually includes extensive discussion and the actual spec wording changes near the end. The issue numbers also correspond to those appearing in the "List of Changes" section and footnotes of the [draft specification](http://code.google.com/p/upc-specification/downloads/detail?name=upc-lang-spec-1.3-draft-3.pdf).

# Type-checker changes #

  * [Issue 3](http://code.google.com/p/upc-specification/issues/detail?id=3): Address of a shared array is a pointer-to-shared
  * [Issue 33](http://code.google.com/p/upc-specification/issues/detail?id=33): MYTHREAD/THREADS are not l-values
  * [Issue 64](http://code.google.com/p/upc-specification/issues/detail?id=64): Barrier argument type relaxation
  * [Issue 71](http://code.google.com/p/upc-specification/issues/detail?id=71): `shared [*]` layout prohibited in typedefs
  * [Issue 78](http://code.google.com/p/upc-specification/issues/detail?id=78): Shared array initialization removed (undefined)
  * [Issue 94/95](http://code.google.com/p/upc-specification/issues/detail?id=94): Constraint on dimension expr in shared array types under dynamic THREADS
  * [Issue 104](http://code.google.com/p/upc-specification/issues/detail?id=104): Relational operators on PTS (new constraint and semantic clarification)
  * [Issue 105](http://code.google.com/p/upc-specification/issues/detail?id=105): Update the predefined macro UPC\_VERSION

# Code-generator changes #

  * [Issue 59](http://code.google.com/p/upc-specification/issues/detail?id=59): upc\_forall negative affinity undefined
  * [Issue 70](http://code.google.com/p/upc-specification/issues/detail?id=70): phase reset on cast/assign of incomplete PTS type
  * [Issue 83](http://code.google.com/p/upc-specification/issues/detail?id=83): Default #pragma upc relaxed
  * [Issue 85](http://code.google.com/p/upc-specification/issues/detail?id=85): Address/index arithmetic on multi-D shared arrays
  * [Issue 88](http://code.google.com/p/upc-specification/issues/detail?id=88): Nested `upc_forall` deprecation
  * [Issue 112](http://code.google.com/p/upc-specification/issues/detail?id=112): Removing implicit phase reset for pointer-to-shared-array casting/assignment with differing referent type but matching ultimate element type


# Runtime/Library Changes #

  * [Issue 10](http://code.google.com/p/upc-specification/issues/detail?id=10): `upc_types.h` header (required)
  * [Issue 12](http://code.google.com/p/upc-specification/issues/detail?id=12): `upc_all_(lock_)free` function (required)
  * [Issue 9](http://code.google.com/p/upc-specification/issues/detail?id=9): `upc_tick_t` library (required)
  * [Issue 7](http://code.google.com/p/upc-specification/issues/detail?id=7): Atomics library (optional)
  * [Issue 37](http://code.google.com/p/upc-specification/issues/detail?id=37): Castability library (optional)
  * [Issue 41](http://code.google.com/p/upc-specification/issues/detail?id=41): Non-blocking `upc_mem*` library (optional)
  * [Issue 51](http://code.google.com/p/upc-specification/issues/detail?id=51): Barrier matching rules corner cases
