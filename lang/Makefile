#
# Makefile to build the UPC Language Specification.
#
# Run with BUILD_HTNL asserted to also build the
# HTML formatted specification:
#     make BUILD_HTML=1
#
NAME = upc-lang-spec

COMMON = ../common

TEX_INC_SRCS = \
	$(COMMON)/upc-spec-preamble.tex \
	upc-acknowledgments.tex \
	upc-introduction.tex \
	upc-language.tex \
	upc-lang-extensions.tex \
	upc-lib-core.tex \
	upc-lib-mem-semantics.tex \
	upc-mem-consistency-model.tex \
	upc-references.tex \
	upc-scope.tex \
	upc-terms-and-defs.tex \
	upc-vs-c-std-section-nums.tex

include $(COMMON)/Makefile.in
