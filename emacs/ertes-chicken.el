
(require 'chicken-scheme nil t)

(when (featurep 'chicken-scheme)
  (add-hook 'scheme-mode-hook 'setup-chicken-scheme)
  (define-key scheme-mode-map (kbd "C-c ?") 'chicken-show-help))

(provide 'ertes-chicken)
