
(when (require 'ledger-mode nil t)

  (defun ertes-ledger-report (report)
    (ledger-report report nil)
    (other-window 1))

  (defun ertes-ledger-report-assets ()
    (interactive)
    (ertes-ledger-report "assets"))

  (defun ertes-ledger-report-balance ()
    (interactive)
    (ertes-ledger-report "bal"))

  (defun ertes-ledger-report-balance-all ()
    (interactive)
    (ertes-ledger-report "bal-all"))

  (defun ertes-ledger-report-tasks ()
    (interactive)
    (ertes-ledger-report "tasks"))

  (defun ertes-ledger-report-register ()
    (interactive)
    (ertes-ledger-report "account"))

  (add-to-list 'auto-mode-alist '("\.ledger$" . ledger-mode))

  (define-key ledger-mode-map (kbd "C-c b S-b") 'ertes-ledger-report-balance-all)
  (define-key ledger-mode-map (kbd "C-c b a")   'ertes-ledger-report-assets)
  (define-key ledger-mode-map (kbd "C-c b b")   'ertes-ledger-report-balance)
  (define-key ledger-mode-map (kbd "C-c b r")   'ertes-ledger-report-register))
