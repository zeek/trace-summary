
DISTFILES = README README.html COPYING CHANGES Makefile trace-summary

DISTDIR=trace-summary-`cat VERSION`

docs: README
	rst2html.py README >README.html

dist: docs
	rm -rf $(DISTDIR)
	mkdir $(DISTDIR)
	cp $(DISTFILES) $(DISTDIR)
	tar czvf $(DISTDIR).tgz $(DISTDIR)
	rm -rf $(DISTDIR)


