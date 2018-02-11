
(defun gp ()
  "Start GP"
  (interactive)
  (switch-to-buffer (make-comint "gp" "gp" nil "-q" "--emacs" "~/cfg/my/gpinit.gp")))

(defun sqlite (fp)
  "Start sqlite with the given file."
  (interactive "FDatabase file: ")
  (switch-to-buffer (make-comint "sqlite" "sqlite3" nil (expand-file-name fp))))
