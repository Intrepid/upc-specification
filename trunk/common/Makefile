SPEC_ISSUES=upc-specification-issues.tex
SPEC_ISSUES_TMP=$(SPEC_ISSUES).tmp

.PHONY: issues

issues:
	@if get_upc_spec_issues_as_tex > $(SPEC_ISSUES_TMP) \
	    && test -f $(SPEC_ISSUES) \
	    && cmp -s $(SPEC_ISSUES) $(SPEC_ISSUES_TMP); then \
	   rm -f $(SPEC_ISSUES_TMP); \
	else \
	   mv $(SPEC_ISSUES_TMP) $(SPEC_ISSUES); \
	   echo "updated: $(SPEC_ISSUES)"; \
	fi
