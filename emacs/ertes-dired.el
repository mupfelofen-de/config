
(require 'dired)

(defun ertes-dired-kill-parent ()
  (interactive)
  (save-excursion
    (dired-tree-up 1)
    (dired-kill-subdir)))

(defun ertes-dired-replace-by-subdir ()
  (interactive)
  (dired-insert-subdir (dired-file-name-at-point))
  (ertes-dired-kill-parent))

(define-key dired-mode-map (kbd "C-<return>") 'dired-maybe-insert-subdir)
(define-key dired-mode-map (kbd "C-c k") 'dired-kill-subdir)
(define-key dired-mode-map (kbd "C-c p") 'ertes-dired-kill-parent)
(define-key dired-mode-map (kbd "C-c u") 'dired-tree-up)
(define-key dired-mode-map (kbd "M-<return>") 'ertes-dired-replace-by-subdir)
