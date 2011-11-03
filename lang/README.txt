latex2html

	A slightly modified version of the installed latex2html
	script that provides an improved error diagnostic when
	an unmatched HTML tag is encountered.  This is not
	necessary, but does help debug problems with generated HTML.

latex2html.cfg.pl -> .latex2html-init

	This is a symlink to the "dot file" .latex2html-init in order
	to make the file more visible and easier to find.

.latex2html-init

	A configuration/customization file for latex2html.

Makefile

	Makefile which creates .pdf and .html from the specification .tex file.
	This make file includes $(LATEX_MK_DIR)/latex.gmk which is
	a boiler plate Makefile provided by the 'latex-mk' RPM under
	Fedora Core Linux.  That package installs
	/etc/profile.d/latex-mk.sh, which sets the LATEX_MX_DIR
	environment variable so that the Makefile template can
	be located via make's 'include' mechanism.

upc-lang-spec.tex

	Updated .tex mark up for the UPC Specification.
	Changes were made to make the document eaisier
	to maintain and to produce meaningful HTML output.

upc-lang-spec.tar.gz

	gzip'd tar file containing all UPC specification source files,
	build/make files, the generated .pdf file and the generated
	.html_dir directory containing the HTML formatted specification.

                            -- end --
