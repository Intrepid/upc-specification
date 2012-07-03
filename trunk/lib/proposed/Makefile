TARGETS=clean distclean draft final make-default

SUBDIRS=$(dir $(wildcard */Makefile))

.PHONY: $(TARGETS)

all: make-default

$(TARGETS):
	@for subdir in $(SUBDIRS); do \
	  $(MAKE) -C $$subdir $@; \
	done
