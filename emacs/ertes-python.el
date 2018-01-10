
(require 'python)

(defun ertes-python-go-top ()
  (interactive)
  (split-window-vertically)
  (other-window 1)
  (beginning-of-buffer)
  (search-forward-regexp "import" nil t)
  (beginning-of-line))

(define-key python-mode-map (kbd "C-c i i") 'ertes-python-go-top)
(define-key python-mode-map (kbd "C-c r") 'delete-window)
