get_upc_spec_issues

	A Perl script that fetches the current list of UPC specification
	issues as a CSV file; it then parses the list of issues and
	writes a tab-separated text file with the following fields:
	"Id", "Status", "Priority", "Owner", "Comments",
	and "Summary". This list is currently limited to
	Spec. 1.3 issues only with status 'New' or 'Accepted'.

send-upc-draft-release-mail

	This script will send the UPC Specification Draft release
	notice out to various relevant mailing lists.
	usage: send-upc-draft-release-mail draft_number draft_date

upc-spec-1-3-draft-1-notice.txt

	The Draft 1 release notice dated August 25, 2012.

upc-spec-1-3-draft-2-notice.txt

	The Draft 2 release notice dated September 22, 2012.

