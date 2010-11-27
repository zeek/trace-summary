
DISTFILES = README README.html COPYING CHANGES Makefile trace-summary

VERSION=$(shell grep ^Version trace-summary | awk 'BEGIN{IFS="[= ]}"}{print $$3}')
DISTDIR=trace-summary-$(VERSION)

docs: README
	rst2html.py README >README.html

dist: docs
	rm -rf $(DISTDIR)
	mkdir $(DISTDIR)
	cp $(DISTFILES) $(DISTDIR)
	tar czvf $(DISTDIR).tgz $(DISTDIR)
	rm -rf $(DISTDIR)


