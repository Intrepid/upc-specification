#
# Makefile to build the UPC Language Specification.
#
# Run with BUILD_HTNL asserted to also build the
# HTML formatted specification:
#     make BUILD_HTML=1
#
NAME = upc-lang-spec
TEXSRCS =
USE_PDFLATEX = 1
RMDIR = $(RM) -rf
CLEAN_FILES += ${NAME:=.pdfsync}
LATEX2HTML_FLAGS = -init_file latex2html.cfg

$(NAME)_EXTRA_DIST_FILES = \
	check_l2h_cfg \
	ChangeLog \
	latex2html.cfg \
	README.txt
$(NAME)_EXTRA_DIST += $(NAME).pdf
ifdef BUILD_HTML
$(NAME)_EXTRA_DIST += $(NAME).html_dir
endif
$(NAME)_EXTRA_DIST += $($(NAME)_EXTRA_DIST_FILES)

ALL = pdf
ifdef BUILD_HTML
ALL += check-l2h html
else
ALL += $(NAME)_rm_html_dir
endif
ALL += dist

.PHONY: make-default
make-default: $(ALL)

.PHONY: clean-html
clean-html: html
	@$(RM) -f $(NAME).html_dir/WARNINGS
	@$(RMDIR) $(NAME).html_dir/TMP

$(NAME).html_dir: clean-html

.PHONY: $(NAME)_rm_html_dir
$(NAME)_rm_html_dir:
	@$(RMDIR) $(NAME).html_dir

.PHONY: check-l2h
check-l2h:
	@echo "Checking that latex2html has been installed ..."
	@which $(LATEX2HTML)
	@env LATEX2HTML='$(LATEX2HTML)' check_l2h_cfg

include $(LATEX_MK_DIR)/latex.gmk
