SPEC_ISSUES=upc-specification-issues.tex
SPEC_ISSUES_TMP=$(SPEC_ISSUES).tmp

.PHONY: issues

issues:
	@if get_upc_spec_issues_as_tex > $(SPEC_ISSUES_TMP) \
	    && cmp -s $(SPEC_ISSUES) $(SPEC_ISSUES_TMP); then \
	   mv $(SPEC_ISSUES_TMP) $(SPEC_ISSUES); \
	   echo "updated: $(SPEC_ISSUES_TMP)"; \
	 else \
	   rm -f $(SPEC_ISSUES_TMP); \
	fi
