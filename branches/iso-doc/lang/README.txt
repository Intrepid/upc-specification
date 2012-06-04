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

Building the Language Specification on RHEL 6
---------------------------------------------

We have determined that in addition to the texlive-2007 package
you will need to install a few extra packages.  Those
packages are not available in the default Redhat
RPM repository.

We have uploaded a .zip file that contains RHEL-6
RPM's with the necessary additional packages.
http://upc-specification.googlecode.com/files/upc-spec-rhel6-rpms.zip

The zip file contains:

    latex2html-2008-4.el6.noarch.rpm
    latex-mk-2.1-1.el6.noarch.rpm
    texinfo-tex-4.13a-8.el6.x86_64.rpm

You can also download and install the packages locally, but if
you have the ability to install RPM's this should save some time.

After installing the latex-mk RPM, you'll need to logout
and login again to pick up the necessary environment variable setting.

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
