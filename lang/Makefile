NAME = upc-lang-spec
TEXSRCS =
USE_PDFLATEX = 1
RMDIR = $(RM) -rf
CLEAN_FILES += ${NAME:=.pdfsync}
LATEX2HTML_FLAGS = -init_file latex2html.cfg

$(NAME)_EXTRA_DIST_FILES = \
	ChangeLog \
	latex2html \
	latex2html.cfg \
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
	@$(RM) -f $(NAME).html_dir/WARNINGS
	@$(RMDIR) $(NAME).html_dir/TMP

$(NAME).html_dir: clean-html
