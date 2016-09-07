
(when (require 'bbdb nil t)
  (bbdb-initialize 'message))

(when (and (require 'message nil t) (require 'mml nil t))
  (add-hook 'message-setup-hook 'mml-secure-message-sign)

  (define-key message-mode-map (kbd "C-c e e") 'mml-secure-message-sign-encrypt)
  (define-key message-mode-map (kbd "C-c e s") 'mml-secure-message-sign)
  (define-key message-mode-map (kbd "C-c r")
    (lambda ()
      (interactive)
      (forward-paragraph)
      (newline)
      (kill-whole-line)
      (open-line 3)))

  (global-set-key (kbd "C-c m") 'notmuch-mua-new-mail))

(when (require 'notmuch nil t)
  (defun ertes-notmuch-poll ()
    (interactive)
    (with-current-buffer (get-buffer-create "*mbsync*")
      (help-mode)
      (let ((inhibit-read-only t))
        (erase-buffer)
        (insert "--- mbsync ---\n")
        (unless (equal 0 (call-process "mbsync" nil t t "all"))
          (switch-to-buffer-other-window "*mbsync*")
          (error "Unable to retrieve mails"))))
    (notmuch-poll-and-refresh-this-buffer))

  (define-key notmuch-hello-mode-map (kbd "C-c g") 'ertes-notmuch-poll))
