TARGETS=clean distclean draft final make-default

.PHONY: $(TARGETS)

all: make-default

$(TARGETS):
	$(MAKE) -C req $@
	$(MAKE) -C opt $@
	$(MAKE) -C proposed $@
