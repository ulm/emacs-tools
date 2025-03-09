(if (daemonp)
    ;; Restart the server if signal SIGUSR1 is received
    (define-key special-event-map [sigusr1] #'server-start))
