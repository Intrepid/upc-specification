# Procedure for releasing new UPC Spec drafts #

  1. Create an issue ticket to track the progress of the draft release. (example: [issue #84](https://code.google.com/p/upc-specification/issues/detail?id=#84))
  1. Review the cover note and List of Changes section to ensure accuracy. Write a release announcement email summarizing the changes in this draft.
  1. Update draft number to be an integer (eg Draft 2)
  1. Generate the official PDF output, both with and without change bars.
  1. Visually scan each page of the output for formatting problems. Fix any problems and start over.
  1. Password protect the PDFs and digitally sign them
  1. Create a project-wide SVN tag for the draft
  1. Upload the draft into the downloads section, set "Featured" tag
  1. Mail a pre-release announcement to the spec group: `upc-spec-dev@googlegroups.com, upc-spec-wg@googlegroups.com`
  1. Wait for confirmation from at least one other person that everything looks good
  1. Mail the draft to the whole world with release announcement: `upc-spec@hermes.gwu.edu, upc@hermes.gwu.edu, upc-help@hermes.gwu.edu, upc-users@lbl.gov`
  1. Increment the draft number for future commits to be a non-integer (eg. Draft 2.1)
  1. Update this wiki with any changes made to the release procedure