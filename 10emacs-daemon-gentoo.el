
;;; emacs-daemon site-lisp configuration

(and
 (fboundp 'daemonp)
 (daemonp)
 (not after-init-time)
 (let* ((file (concat "/var/run/emacs/" (user-login-name) "/emacs.pid"))
	(pid (if (file-readable-p file)
		 ;; Get process id from file
		 (with-temp-buffer
		   (ignore-errors
		    (insert-file-contents-literally file nil 0 100)
		    (and (looking-at "[0-9]+")
			 (string-to-number (match-string 0))))))))
   ;; If another Emacs daemon is already running for this user,
   ;; then we would steal its server socket. So we better die.
   (and (integerp pid)
	(equal (cdr (assq 'comm (system-process-attributes pid))) "emacs")
	(/= pid (emacs-pid))
	(kill-emacs))
   (when (file-writable-p file)
     ;; Write process id to file
     (with-temp-file file
       (insert (number-to-string (emacs-pid)) "\n"))
     ;; Remove file on exit
     (add-hook 'kill-emacs-hook
	       `(lambda () (delete-file ,file))))))
