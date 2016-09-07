
(when (require 'paredit nil t)
   (defun ertes-init-paredit ()
     (interactive)
     (define-key paredit-mode-map (kbd "C-<left>") 'backward-word)
     (define-key paredit-mode-map (kbd "C-<right>") 'forward-word)
     (define-key paredit-mode-map (kbd "M-+") 'paredit-forward-slurp-sexp)
     (define-key paredit-mode-map (kbd "M--") 'paredit-forward-barf-sexp))

   (add-hook 'emacs-lisp-mode-hook 'ertes-init-paredit)
   (add-hook 'emacs-lisp-mode-hook 'paredit-mode)

   (add-hook 'scheme-mode-hook 'ertes-init-paredit)
   (add-hook 'scheme-mode-hook 'paredit-mode))
