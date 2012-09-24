TARGETS=clean distclean draft final make-default

.PHONY: $(TARGETS)

all: make-default

$(TARGETS):
	$(MAKE) -C lang $@
	$(MAKE) -C lib $@

