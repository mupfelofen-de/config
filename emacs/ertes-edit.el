
(put 'downcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)

(defun ertes-open-line-after ()
  (interactive)
  (end-of-line)
  (newline))

(defun ertes-open-line-before ()
  (interactive)
  (beginning-of-line)
  (open-line 1))

(global-set-key (kbd "<delete>")    'delete-char)
(global-set-key (kbd "C-<tab>")     'dabbrev-expand)
(global-set-key (kbd "C-M-<left>")  'backward-sentence)
(global-set-key (kbd "C-M-<right>") 'forward-sentence)
(global-set-key (kbd "C-M-o")       'ertes-open-line-after)
(global-set-key (kbd "C-S-o")       'ertes-open-line-before)
(global-set-key (kbd "C-^")         'beginning-of-line-text)
(global-set-key (kbd "C-c t")       'transpose-sentences)
(global-set-key (kbd "S-<delete>")  'kill-paragraph)
