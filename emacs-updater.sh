#!/bin/bash

# Licensed under GPL version 2
# Author Christian Faulhammer <opfer@gentoo.org>

# Only set colours if output is not redirected
if tty -s <&1; then
    BLUE=$'\033[34;01m'
    GREEN=$'\e[32;01m'
    RED=$'\033[31;01m'
    YELLOW=$'\033[33;01m'
    CYAN=$'\033[36;01m'
    BOLD=$'\e[0;01m'
    NORMAL=$'\033[0m'
fi

SITELISP=/usr/share/emacs/site-lisp
VERSION=0.2
TMPFILE="$(mktemp /tmp/emacs-updater.XXXXXX)"


message() {
    local OUTPUT=$@
    echo "${GREEN}*${NORMAL}${BOLD} ${OUTPUT}${NORMAL}"
}

warning() {
    local OUTPUT=$@
    echo "${YELLOW}*${NORMAL}${BOLD} ${OUTPUT}${NORMAL}"
}

failure() {
    local OUTPUT=$@
    echo "${RED}*${NORMAL}${BOLD} ${OUTPUT}${NORMAL}" 
}

echo
echo "Emacs updater version ${VERSION}"
echo "Written by the Gentoo Emacs team http://www.gentoo.org/proj/en/lisp/emacs/"
echo "Find packages that are installed in the wrong location, file bugs on http://bugs.gentoo.org/"
echo
warning "Note, you must use the eclasses from the Emacs Overlay for proper operation! "
echo

if ! [ -x /usr/bin/qfile ]; then
    echo
    failure "Please emerge app-portage/portage-utils to use this tool"
    exit 1
fi

for sf in "${ROOT}/${SITELISP}"/[0-9][0-9]*-gentoo.el
do
    message "Processing ..."
    qfile -qC "${sf}" >> "${TMPFILE}"
done
echo

if [ ! -s "${TMPFILE}" ]; then
    warning "No packages to update, quitting."
    exit 2
fi

message "Packages with site files in the wrong location:"
cat "${TMPFILE}"

echo
echo -n "${BOLD}Remerge packages?${NORMAL} [${GREEN}Yes${NORMAL}/${RED}No${NORMAL}] "
read choice
echo
case "${choice}" in
     y*|Y*|"")
          ;;
     *)
	warning "Quitting."
	exit 10 ;;
esac

emerge -av $(cat "${TMPFILE}")

warning "If a package is being rebuilt over and over again, please report it on http://bugs.gentoo.org/"
