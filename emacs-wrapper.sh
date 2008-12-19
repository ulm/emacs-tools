#!/bin/bash
# Copyright 2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# Start Emacs with a login shell wrapper to read the user's profile
export SHELL=${SHELL:-/bin/bash}
exec -l "${SHELL}" -c "exec \"${EMACS}\" $*" </dev/null &>/dev/null &
pid=$!

# Wait for Emacs daemon to detach
timeout=${EMACS_TIMEOUT:-30}
while [ ${timeout} -gt 0 ]; do
    sleep 1
    if ! kill -0 ${pid} 2>/dev/null; then
        wait ${pid}		# get exit status
        exit $?
    fi
    let timeout--
done

echo "${0##*/}: timeout waiting for ${EMACS} to detach" >&2
kill ${pid} $(pgrep -P ${pid}) 2>/dev/null
exit 1
