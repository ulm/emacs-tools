# Copyright 2007-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2 or later

PN = emacs-common-gentoo
PV = $(shell sed '/^[ \t]*\* [Vv]ersion/!d;s/[^0-9.]*\([^ \t]*\).*/\1/;q' \
	ChangeLog)
P = $(PN)-$(PV)

DESKTOPFILES = emacs.desktop emacsclient.desktop
ICONFILES = emacs.png sink.png \
	emacs_16.png emacs_24.png emacs_32.png emacs_48.png \
	emacs23_16.png emacs23_24.png emacs23_32.png emacs23_48.png \
	emacs23_128.png
DISTFILES = subdirs.el $(DESKTOPFILES) \
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
