#
# Makefile to build the UPC Language Specification.
#
# Run with BUILD_HTNL asserted to also build the
# HTML formatted specification:
#     make BUILD_HTML=1
#
NAME = upc-lib-optional-spec

COMMON = ../../common

TEX_INC_SRCS = \
	$(COMMON)/upc-spec-preamble.tex \
	$(COMMON)/upc-specification-issues.tex \
	upc-lib-optional-spec.tex \
	upc-lib-optional-spec-draft.tex \
	upc-lib-atomic-ops.tex \
	upc-lib-castability.tex \
	upc-lib-io.tex \
	upc-lib-nb-mem-ops.tex

include $(COMMON)/Makefile.in
