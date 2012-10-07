TARGETS=clean distclean draft final make-default

.PHONY: issues $(TARGETS)

all: issues make-default

$(TARGETS):
	$(MAKE) -C lang $@
	$(MAKE) -C lib $@

issues:
	$(MAKE) -C common issues
