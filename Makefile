# Copyright 2007-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2 or later

PN = emacs-common-gentoo
PV = $(shell sed '/^[ \t]*\* [Vv]ersion/!d;s/[^0-9.]*\([^ \t]*\).*/\1/;q' \
	ChangeLog)
P = $(PN)-$(PV)

DESKTOPFILES = emacs.desktop emacsclient.desktop
ICONFILES = sink.png \
	emacs22_16.png emacs22_24.png emacs22_32.png emacs22_48.png \
	emacs_16.png emacs_24.png emacs_32.png emacs_48.png emacs_128.png \
	emacs.svg
DISTFILES = site-start.el site-gentoo.el subdirs.el $(DESKTOPFILES) \
	$(addprefix icons/,COPYRIGHT.icons $(ICONFILES))


.PHONY: all dist clean $(DESKTOPFILES)

all:

dist: $(DISTFILES)
	tar -czf $(P).tar.gz --transform='s%^%$(P)/%' $^
	tar -tzvf $(P).tar.gz

$(DESKTOPFILES):
	desktop-file-validate $@

clean:
	-rm -f *~ *.tmp *.gz *.bz2
