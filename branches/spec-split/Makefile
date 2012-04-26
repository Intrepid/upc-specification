TARGETS=clean distclean make-default

.PHONY: $(TARGETS)

all: make-default

$(TARGETS):
	$(MAKE) -C lang $@
	$(MAKE) -C lib $@

