
DISTFILES = README COPYING CHANGES Makefile trace-summary

BUILD=build
DISTDIR=trace-summary-`test -e VERSION && cat VERSION || cat ../VERSION`

dist:
	@install -d $(BUILD)
	rm -rf $(BUILD)/$(DISTDIR)
	mkdir $(BUILD)/$(DISTDIR)
	cp $(DISTFILES) $(BUILD)/$(DISTDIR)
	( cd $(BUILD) && tar czvf $(DISTDIR).tgz $(DISTDIR) )
	rm -rf $(BUILD)/$(DISTDIR)
	@echo "Package: $(BUILD)/$(DISTDIR).tgz"

distclean:
	rm -rf $(BUILD)
