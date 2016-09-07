
(when (require 'org nil t)
  (require 'org-crypt)
  (require 'ox-md)

  (defun org-summary-todo (n-done n-not-done)
    "Switch entry to DONE when all subentries are done, to TODO otherwise."
    (let (org-log-done org-log-states)
      (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

  (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

  (org-crypt-use-before-save-magic)

  (define-key org-mode-map (kbd "C-c y") 'yas-expand)
  (define-key org-mode-map (kbd "C-<down>") 'forward-paragraph)
  (define-key org-mode-map (kbd "C-<up>") 'backward-paragraph)

  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c n") 'org-capture)
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c p") 'org-decrypt-entry))
