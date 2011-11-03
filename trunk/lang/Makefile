NAME = upc-specs-1-2
TEXSRCS =
USE_PDFLATEX = 1
RMDIR = $(RM) -rf
CLEAN_FILES += ${NAME:=.pdfsync}

$(NAME)_EXTRA_DIST_FILES = \
	ChangeLog \
	latex2html \
	.latex2html-init \
	latex2html.cfg.pl \
	README.txt
$(NAME)_EXTRA_DIST += $(NAME).pdf
$(NAME)_EXTRA_DIST += $(NAME).html_dir
$(NAME)_EXTRA_DIST += $($(NAME)_EXTRA_DIST_FILES)

ALL = pdf html dist

.PHONY: make-default
make-default: $(ALL)

include $(LATEX_MK_DIR)/latex.gmk

.PHONY: clean-html
clean-html: html
	@$(RM) -f $</WARNINGS
	@$(RMDIR) $</TMP

$(NAME).html_dir: clean-html
