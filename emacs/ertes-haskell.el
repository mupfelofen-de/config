
(when (package-activate 'haskell-mode)
  (require 'haskell-interactive-mode)
  (require 'haskell-process)

  (defun ertes-haskell-add-import (&optional module)
    (interactive)
    (save-excursion
      (goto-char (point-max))
      (haskell-navigate-imports)
      (insert (haskell-import-for-module
               (or module
                   (haskell-complete-module-read
                    "Module: "
                    (map 'list 'car haskell-import-mapping)))))
      (haskell-sort-imports)))

  (defun ertes-haskell-go-exports ()
    (interactive)
    (split-window-vertically)
    (other-window 1)
    (beginning-of-buffer)
    (search-forward-regexp "^module")
    (search-forward-regexp "^ +where")
    (beginning-of-line)
    (previous-line))

  (defun ertes-haskell-go-extensions ()
    (interactive)
    (split-window-vertically)
    (other-window 1)
    (beginning-of-buffer)
    (cond ((search-forward-regexp "^{-# LANGUAGE " nil t)
           (beginning-of-line)
           (open-line 1))
          ((search-forward-regexp "^module")
           (beginning-of-line)
           (open-line 2))
          (t (error "Can't find module declaration")))
    (insert "{-# LANGUAGE  #-}")
    (backward-char 4))

  (defun ertes-haskell-go-imports ()
    (interactive)
    (split-window-vertically)
    (other-window 1)
    (haskell-navigate-imports-go)
    (if (search-forward-regexp "^import " nil t)
        (progn
          (beginning-of-line)
          (open-line 1))
      (open-line 2))
    (insert "import "))

  (defun ertes-haskell-return ()
    (interactive)
    (save-excursion
      (haskell-navigate-imports-go)
      (haskell-sort-imports)

      (beginning-of-buffer)
      (if (search-forward-regexp "^{-# LANGUAGE " nil t)
          (progn
            (beginning-of-line)
            (let ((p1 (point)))
              (if (search-forward-regexp "^$" nil t)
                  (sort-lines nil p1 (point)))))))

    (delete-window))

  (defun ertes-haskell-run-devel ()
    (interactive)
    (if (get-buffer "DevelMain.hs")
        (haskell-process-reload-devel-main)
      (with-current-buffer (haskell-interactive-buffer)
        (haskell-interactive-mode-do-expr ":main")
        (mapc (lambda (x)
                (with-selected-window x (goto-char (point-max))))
              (get-buffer-window-list (haskell-interactive-buffer))))))

  (add-hook 'haskell-mode-hook 'capitalized-words-mode)
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-doc)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

  (define-key haskell-mode-map (kbd "C-c b") 'haskell-interactive-bring)
  (define-key haskell-mode-map (kbd "C-c i a") 'ertes-haskell-add-import)
  (define-key haskell-mode-map (kbd "C-c i e") 'ertes-haskell-go-exports)
  (define-key haskell-mode-map (kbd "C-c i i") 'ertes-haskell-go-imports)
  (define-key haskell-mode-map (kbd "C-c i l") 'ertes-haskell-go-extensions)
  (define-key haskell-mode-map (kbd "C-c k") 'haskell-cabal-visit-file)
  (define-key haskell-mode-map (kbd "C-c m") 'ertes-haskell-run-devel)
  (define-key haskell-mode-map (kbd "C-c R") 'haskell-process-restart)
  (define-key haskell-mode-map (kbd "C-c r") 'ertes-haskell-return)
  (define-key haskell-mode-map (kbd "C-c t") 'haskell-mode-show-type-at)
  (define-key haskell-mode-map (kbd "M-.") 'haskell-mode-jump-to-def-or-tag)

  (define-key haskell-cabal-mode-map (kbd "C-<down>") 'forward-paragraph)
  (define-key haskell-cabal-mode-map (kbd "C-<up>") 'backward-paragraph)
  (define-key haskell-cabal-mode-map (kbd "C-c b") 'haskell-interactive-bring)
  (define-key haskell-cabal-mode-map (kbd "M-.") 'haskell-mode-jump-to-def-or-tag))
