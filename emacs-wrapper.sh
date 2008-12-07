#!/bin/bash

# Start Emacs with a login shell wrapper to read the user's profile.
export SHELL=${SHELL:-/bin/bash}
exec -l "${SHELL}" -c "exec \"${EMACS}\" $@" </dev/null &>/dev/null &
pid=$!

# Wait for Emacs daemon to detach
timeout=${EMACS_TIMEOUT:-15}
while [ ${timeout} -gt 0 ]; do
    sleep 1
    kill -0 ${pid} 2>/dev/null || exit 0
    timeout=$((${timeout} - 1))
done

echo "${0##*/}: timeout waiting for \"${EMACS} $@\" to detach" 1>&2
pkill -P ${pid}
kill ${pid} 2>/dev/null
exit 1
