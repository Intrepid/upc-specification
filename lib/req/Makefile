#
# Makefile to build the UPC Language Specification.
#
# Run with BUILD_HTNL asserted to also build the
# HTML formatted specification:
#     make BUILD_HTML=1
#
NAME = upc-lib-required-spec

COMMON = ../../common

TEX_INC_SRCS = \
	$(COMMON)/upc-spec-preamble.tex \
	$(COMMON)/upc-specification-issues.tex \
	upc-lib-required-spec.tex \
	upc-lib-required-spec-draft.tex \
	upc-lib-collectives.tex \
	upc-lib-tick.tex

include $(COMMON)/Makefile.in
