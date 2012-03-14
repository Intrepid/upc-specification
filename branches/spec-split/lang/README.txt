Setting up the Tex Environment
------------------------------

   Building in this directory uses two features beyond a standard
   'texlive/2011' distribution: latex-mk and latex2html.  Latex2html
   is required only if you plan to build the HTML formatted specification
   (see the following section).

   Under linux, install the latex-mk and latex2html packages.  The
   latex-mk package installs /etc/profile.d/latex-mk.sh, which sets
   the LATEX_MX_DIR environment variable so that the Makefile template
   can be located via make's 'include' mechanism.

   Under OS/X you may use the 'ports' package to get these packages.

   Alternatively, you may install latex-mk (available at
   http://latex-mk.sourceforge.net/) and latex2html (available from CTAN
   at http://www.ctan.org/tex-archive/support/latex2html/) manually.
   You then will need to set environment variables, something like:

       export LATEX_MK_DIR=/usr/local/share/latex-mk/
       export TEXINPUTS=.:/usr/local/share/lib/latex2html/texinputs/:

Building the HTML Formatted Specification
-----------------------------------------

   The HTML formatted specification can be built by asserting
   BUILD_HTML when invoking `make'.  For example:
       make BUILD_HTML=1

File Description
----------------

Makefile

	Makefile which creates .pdf and (optionally) .html
	from the specification .tex file.

upc-language.tex

	The UPC language specification main description.
	
upc-lang-spec.tex

	Driver file for the UPC Specification.

upc-lang-spec.tar.gz

	gzip'd tar file containing all UPC specification source files,
	build/make files, the generated .pdf file and
	(optionally) the generated .html_dir directory
	containing the HTML formatted specification.

upc-lib-core.tex

	The UPC core library description.

upc-acknowledgments.tex

	The "Acknowledgments" section of the UPC language specification.


upc-introduction.tex

	The "Introduction" section of the UPC language specification.

upc-lang-extensions.tex

	The UPC library extensions guidelines of the UPC language
	specification.

upc-lib-mem-semantics.tex

	The UPC library memory semantics section of the UPC language
	specification.

upc-references.tex

	The "References" section of the UPC language specification.

upc-scope.tex

	The "Scope" section of the UPC language specification.

upc-terms-and-defs.tex

	The "Terms, definitions and symbols" section of the UPC language
	specification.
	
upc-mem-consistency-model.tex

	The memory consistency model description.

upc-vs-c-std-section-nums.tex

	The UPC to ISO C standard section mapping description.

                            -- end --
