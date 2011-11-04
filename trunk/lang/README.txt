Setting up the Tex environment:

   Building in this directory uses two features beyond a standard
   'texlive/2011' distribution: latex2html and latex-mk

   Under linux, install the latex2html and latex-mk packages.  The
   latex-mk package installs /etc/profile.d/latex-mk.sh, which sets
   the LATEX_MX_DIR environment variable so that the Makefile template
   can be located via make's 'include' mechanism.

   Under OS/X you may use the 'ports' package to get these packages.

   Alternatively, you may install latex2html (available from CTAN) and
   latex-mk (available at http://latex-mk.sourceforge.net/) manually.
   You then will need to set environment variables, something like:

       export LATEX_MK_DIR=/usr/local/share/latex-mk/
       export TEXINPUTS=.:/usr/local/share/lib/latex2html/texinputs/:


latex2html

	A slightly modified version of the installed latex2html
	script that provides an improved error diagnostic when
	an unmatched HTML tag is encountered.  This is not
	necessary, but does help debug problems with generated HTML.

latex2html.cfg

	A configuration/customization file for latex2html.

Makefile

	Makefile which creates .pdf and .html from the specification
	.tex file. If latex2html gives you trouble, you can make just
	just the pdf with 'make upc-lang-spec.pdf'
	

upc-lang-spec.tex

	Updated .tex mark up for the UPC Specification.
	Changes were made to make the document eaisier
	to maintain and to produce meaningful HTML output.

upc-lang-spec.tar.gz

	gzip'd tar file containing all UPC specification source files,
	build/make files, the generated .pdf file and the generated
	.html_dir directory containing the HTML formatted specification.

                            -- end --
