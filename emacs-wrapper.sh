#!/bin/bash

# Start Emacs with a login shell wrapper to read the user's profile.
# (Sorry tcsh users, this is hardcoded to bash. Patches are welcome.)
/bin/bash -l -c "${EMACS} $@" </dev/null &>/dev/null &
pid=$!

# Wait for Emacs daemon to detach
timeout=${EMACS_TIMEOUT:-15}
while [ ${timeout} -gt 0 ]; do
    sleep 1
    kill -0 ${pid} 2>/dev/null || exit 0
    timeout=$((${timeout} - 1))
done

echo "Timeout while waiting for \"${EMACS} $@\" to detach" 1>&2
kill ${pid}
exit 1
