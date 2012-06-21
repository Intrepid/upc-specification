check_l2h_cfg

	A Perl script that checks that latex2html has been configured
	correctly.

latex/

	A directory containing local LaTeX package and class files.
	This directory is added to the TEXINPUTS path variable last,
	to ensure that any system installed packages are used first.

latex.gmk

	A Makefile file fragment that is defined by the latex-mk
	package.  This copy of the file is used if the latex-mk package
	has not been installed on the system.

latex-mk

	A shell script that will run the latex utility repetitively in
	order to create the desired output.  This script is defined
	by the latex-mk package.  If the latex-mk package is not
	installed on the system, this copy of the script is used
	instead.

latex2html.cfg

	A configuration/customization file for latex2html.

Makefile.in

	Common Makefile fragment that is included from the
	Makefile in each build sub-directory.  Requires 'latex-mk'
	Makefile infrastructure.

upc-spec-preamble.tex

	The LaTeX preamble, to be included (via \input) from each
	sub-part of the UPC specification.

                            -- end --
