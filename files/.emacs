; -*-emacs-lisp-*-

(add-to-list 'load-path "~/cfg/my/emacs")
(add-to-list 'load-path "~/.nix-profile/share/x86_64-linux-ghc-8.0.2/Agda-2.5.2/emacs-mode")

(setq package-user-dir "~/.nix-profile/share/emacs/site-lisp/elpa")
(package-initialize)

(load "ProofGeneral/generic/proof-site")

(require 'agda2 nil t)
(require 'calc)
(require 'dired-x)
(require 'ibuf-ext)
(require 'imaxima nil t)
(require 'nix-mode)
(require 'nxml-mode)
(require 'yasnippet)

(load "ertes-cmd")
(load "ertes-dired")
(load "ertes-edit")
(load "ertes-haskell")
(load "ertes-ledger")
(load "ertes-mail")
(load "ertes-org")
(load "ertes-paredit")
(load "ertes-python")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-verbatim-environments (quote ("verbatim" "verbatim*" "boxedverbatim")))
 '(TeX-PDF-mode t)
 '(TeX-auto-save nil)
 '(TeX-parse-self t)
 '(abbrev-mode t t)
 '(backup-directory-alist (quote ((".*" . "~/log/emacs-backup"))))
 '(bbdb-gui t)
 '(bbdb-time-display-format "%Y-%m-%d")
 '(blink-cursor-blinks 500)
 '(blink-cursor-interval 0.3)
 '(blink-cursor-mode t)
 '(browse-url-firefox-new-window-is-tab t)
 '(browse-url-firefox-program "palemoon")
 '(c-basic-offset 4)
 '(c-offsets-alist
   (quote
    ((case-label . +)
     (access-label . -2)
     (label . +)
     (arglist-intro . +))))
 '(calc-highlight-selections-with-faces t)
 '(calendar-mark-diary-entries-flag t)
 '(calendar-week-start-day 1)
 '(case-fold-search t)
 '(cdlatex-command-alist
   (quote
    (("arr" "Insert array environment." "" cdlatex-environment
      ("arr")
      t t)
     ("eq*" "Insert equation* environment." "" cdlatex-environment
      ("equation*")
      t t))))
 '(cdlatex-math-modify-alist
   (quote
    ((98 "\\mathbb" "\\mathbb" t nil nil)
     (116 "\\text" "\\text" t nil nil))))
 '(cdlatex-math-symbol-alist
   (quote
    ((61
      ("\\equiv" "\\equiv_{?}"))
     (100
      ("\\diamond" "\\delta" "\\Delta")))))
 '(colon-double-space t)
 '(column-number-mode t)
 '(comint-scroll-show-maximum-output nil)
 '(compilation-ask-about-save nil)
 '(compilation-read-command nil)
 '(compilation-scroll-output t)
 '(compilation-search-path (quote (nil ".." "../.." "../../.." "../../../..")))
 '(compilation-skip-threshold 1)
 '(compilation-window-height 14)
 '(compile-command "rmake -k ")
 '(current-language-environment "UTF-8")
 '(cursor-type (quote bar))
 '(darcsum-whatsnew-switches "-l")
 '(default-input-method "german-postfix")
 '(default-justification (quote left))
 '(delete-old-versions t)
 '(delete-selection-mode t)
 '(desktop-file-name-format (quote local))
 '(desktop-path (quote ("~" "~/.emacs.d/" ".")))
 '(dired-dwim-target t)
 '(dired-listing-switches "-alhq --group-directories-first")
 '(dired-omit-files "^\\(\\.\\|.boring\\|_darcs\\|cabal-dev\\|dist\\)$")
 '(dired-omit-mode t t)
 '(dired-trivial-filenames "^\\.$\\|^#")
 '(doc-view-continuous t)
 '(electric-indent-mode nil)
 '(enable-local-variables t)
 '(erc-disable-ctcp-replies t)
 '(erc-email-userid "ertes")
 '(erc-fill-column 90)
 '(erc-fill-prefix "    ")
 '(erc-generate-log-file-name-function (quote erc-generate-log-file-name-short))
 '(erc-join-buffer (quote bury))
 '(erc-keywords (quote ("ertugrul" "s\\(oe\\|ö\\)ylemez")))
 '(erc-kill-server-buffer-on-quit t)
 '(erc-log-channels-directory "~/log/erc")
 '(erc-log-insert-log-on-open t)
 '(erc-log-write-after-insert t)
 '(erc-log-write-after-send t)
 '(erc-lurker-hide-list (quote ("JOIN" "NICK" "PART" "QUIT")))
 '(erc-max-buffer-size 65536)
 '(erc-modules
   (quote
    (autojoin button completion fill irccontrols match move-to-prompt netsplit networks noncommands readonly ring track truncate)))
 '(erc-nick
   (quote
    ("ertes" "ertesx" "ertes-t6v" "ertes-9L2" "ertes-8pU")))
 '(erc-nickserv-identify-mode (quote nick-change))
 '(erc-prompt-for-nickserv-password nil)
 '(erc-rename-buffers t)
 '(erc-server-flood-penalty 2)
 '(erc-track-faces-priority-list
   (quote
    (erc-error-face
     (erc-nick-default-face erc-current-nick-face)
     erc-current-nick-face erc-keyword-face
     (erc-nick-default-face erc-pal-face)
     erc-pal-face)))
 '(erc-track-priority-faces-only (quote all))
 '(erc-whowas-on-nosuchnick t)
 '(file-coding-system-alist (quote ((".*" utf-8 . utf-8))))
 '(fill-column 72)
 '(fill-prefix nil)
 '(font-latex-fontify-script nil)
 '(font-latex-fontify-sectioning 1.0)
 '(font-latex-script-display (quote (nil)))
 '(font-lock-maximum-size 1048576)
 '(geiser-active-implementations (quote (guile)))
 '(geiser-guile-load-path (quote (".")))
 '(geiser-guile-manual-lookup-nodes (quote ("Guile" "guile-2.0" "guile")))
 '(global-font-lock-mode t nil (font-lock))
 '(gnus-inhibit-images t)
 '(grep-command "grep --color -HinR ")
 '(haskell-cabal-list-comma-position (quote after))
 '(haskell-doc-prettify-types nil)
 '(haskell-doc-show-reserved nil)
 '(haskell-import-mapping
   (quote
    (("Applicative" . "import Control.Applicative
")
     ("B" . "import Data.ByteString (ByteString)
import qualified Data.ByteString as B
")
     ("Bl" . "import qualified Data.ByteString.Lazy as Bl
")
     ("Codensity" . "import Control.Monad.Codensity
")
     ("Foldable" . "import Data.Foldable
")
     ("IO" . "import Control.Monad.IO.Class
")
     ("M" . "import Data.Map.Strict (Map)
import qualified Data.Map.Strict as M
")
     ("Mh" . "import Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as Mh
")
     ("Mi" . "import Data.IntMap.Strict (IntMap)
import qualified Data.IntMap.Strict as Mi
")
     ("Monad" . "import Control.Monad
")
     ("Monoid" . "import Data.Monoid
")
     ("T" . "import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import qualified Data.Text.IO as T
")
     ("Tl" . "import qualified Data.Text.Lazy as Tl
import qualified Data.Text.Lazy.Encoding as Tl
import qualified Data.Text.Lazy.IO as Tl
")
     ("Traversable" . "import Data.Traversable
")
     ("V" . "import Data.Vector.Generic (Vector)
import qualified Data.Vector.Generic as V
")
     ("Vb" . "import qualified Data.Vector as Vb
")
     ("Vbm" . "import qualified Data.Vector.Mutable as Vbm
")
     ("Vm" . "import Data.Vector.Generic.Mutable (MVector)
import qualified Data.Vector.Generic.Mutable as Vm
")
     ("Vs" . "import qualified Data.Vector.Storable as Vs
")
     ("Vu" . "import qualified Data.Vector.Unboxed as Vu
")
     ("S" . "import Data.Set (Set)
import qualified Data.Set as S
")
     ("Sh" . "import Data.HashSet (HashSet)
import qualified Data.HashSet as Sh
")
     ("Si" . "import Data.IntSet (IntSet)
import qualified Data.IntSet as Si
"))))
 '(haskell-indent-after-keywords
   (quote
    (("where" 0 0)
     ("of" 2)
     ("do" 4)
     ("mdo" 2)
     ("rec" 2)
     ("in" 2 0)
     ("{" 2)
     "if" "then" "else" "let")))
 '(haskell-indent-rhs-align-column 4)
 '(haskell-indent-spaces 4)
 '(haskell-indent-thenelse 2)
 '(haskell-interactive-mode-scroll-to-bottom t)
 '(haskell-process-args-cabal-repl
   (quote
    ("--ghc-option=-fdefer-typed-holes" "--ghc-option=-ferror-spans" "--ghc-option=-ignore-dot-ghci")))
 '(haskell-process-args-ghci
   (quote
    ("-DDEVEL" "-Wall" "-Wno-type-defaults" "-Wno-unused-do-bind" "-fdefer-typed-holes" "-ferror-spans" "-ignore-dot-ghci" "-fshow-loaded-modules")))
 '(haskell-process-path-cabal "nix-cabal")
 '(haskell-process-path-ghci "nix-ghci")
 '(haskell-process-prompt-restart-on-cabal-change nil)
 '(haskell-process-show-debug-tips nil)
 '(haskell-process-suggest-language-pragmas nil)
 '(haskell-process-suggest-overloaded-strings nil)
 '(haskell-process-type (quote ghci))
 '(ibuffer-expert t)
 '(ibuffer-never-show-predicates
   (quote
    ("^app\\.org$" "^bitlbee$" "^&bitlbee$" "^\\*calc trail\\*$" "^\\*calculator\\*$" "^\\*calendar\\*$" "^\\*compilation\\*$" "^\\*completions\\*$" "^\\*customize " "^diary$" "^freenode$" "^\\*help\\*$" "^\\*hs-error\\*$" "^\\*ledger report\\*$" "^\\*magit[:-]" "^\\*messages\\*$" "^notes.org$" "^\\*notmuch-hello\\*$" "^personal\\.ledger$" "^\\*scratch\\*$" "^\\*shell command output\\*$" "^#")) nil (ibuf-ext))
 '(imaxima-equation-color "gray")
 '(imaxima-fnt-size "huge")
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice nil)
 '(jit-lock-stealth-time 0.5)
 '(jq-indent-offset 4)
 '(kept-new-versions 7)
 '(kept-old-versions 2)
 '(keyboard-coding-system (quote utf-8))
 '(ledger-highlight-xact-under-point nil)
 '(ledger-post-amount-alignment-column 60)
 '(ledger-reconcile-default-commodity "EUR")
 '(ledger-reports
   (quote
    (("account" "ledger -f %(ledger-file) -c reg %(account)")
     ("assets" "ledger -f %(ledger-file) -c -P --payee='tag(\"tid\")' reg '%tid'")
     ("bal" "ledger -f %(ledger-file) -c bal")
     ("bal-all" "ledger -f %(ledger-file) bal")
     ("budget" "ledger -f %(ledger-file) -c -p \"this month\" budget")
     ("payee" "ledger -f %(ledger-file) -c reg @%(payee)")
     ("tasks" "ledger -f %(ledger-file) -c -P reg '^aktiv:' '^aufgaben:'"))))
 '(ledger-use-iso-dates t)
 '(list-directory-verbose-switches "-lh")
 '(ls-lisp-dirs-first t)
 '(magit-diff-arguments (quote ("--stat" "--stat-width=200" "--no-ext-diff")))
 '(mail-envelope-from (quote header))
 '(mail-specify-envelope-from t)
 '(markdown-asymmetric-header t)
 '(markdown-enable-math t)
 '(markdown-footnote-location (quote header))
 '(markdown-indent-on-enter nil)
 '(menu-bar-mode nil)
 '(message-auto-save-directory "~/tmp/mail")
 '(message-citation-line-function (quote ignore))
 '(message-kill-buffer-on-exit t)
 '(message-sendmail-envelope-from (quote header))
 '(mm-text-html-renderer (quote shr))
 '(mml-secure-openpgp-encrypt-to-self t)
 '(mml-secure-openpgp-sign-with-sender t)
 '(mouse-wheel-follow-mouse t)
 '(mouse-yank-at-point t)
 '(notmuch-archive-tags (quote ("-inbox" "-unread")))
 '(notmuch-crypto-process-mime t)
 '(notmuch-fcc-dirs "posteo-Sent")
 '(notmuch-hello-sections
   (quote
    (notmuch-hello-insert-header notmuch-hello-insert-saved-searches notmuch-hello-insert-search notmuch-hello-insert-alltags notmuch-hello-insert-footer)))
 '(notmuch-mua-cite-function (quote message-cite-original-without-signature))
 '(notmuch-saved-searches
   (quote
    ((:name "inbox" :query "tag:inbox" :key "i")
     (:name "unread" :query "tag:unread" :key "u")
     (:name "diaspora" :query "from:diaspora@nerdpol.ch tag:unread" :key "cd")
     (:name "recent" :query "date:48h.. not from:diaspora@nerdpol.ch" :key "r")
     (:name "flagged" :query "tag:flagged" :key "f")
     (:name "sent" :query "tag:sent" :key "t")
     (:name "drafts" :query "tag:draft" :key "d")
     (:name "all mail" :query "*" :key "a"))))
 '(notmuch-tree-result-format
   (quote
    (("date" . "%12s  ")
     ("authors" . "%-30s")
     ((("tree" . "%s")
       ("subject" . "%s"))
      . " %-54s ")
     ("tags" . "(%s)"))))
 '(nxml-attribute-indent 6)
 '(nxml-auto-insert-xml-declaration-flag nil)
 '(nxml-char-ref-display-glyph-flag nil)
 '(nxml-child-indent 4)
 '(nxml-outline-child-indent 2)
 '(nxml-sexp-element-flag t)
 '(nxml-slash-auto-complete-flag t)
 '(org-adapt-indentation nil)
 '(org-agenda-files
   (quote
    ("~/prj/intelego/intelego.org" "~/org/app.org" "~/org/notes.org")))
 '(org-agenda-time-grid
   (quote
    ((daily today)
     #("----------------" 0 16
       (org-heading t))
     (800 1000 1200 1400 1600 1800 2000))))
 '(org-capture-templates
   (quote
    (("a" "Appointment" entry
      (file+datetree+prompt "~/org/app.org")
      "* APP %T %?
Erstellt: %<%a, %F %T>" :prepend t :empty-lines-after 1)
     ("n" "Note" entry
      (file+olp "~/org/notes.org" "Notizen")
      "* %?
Erstellt: %U" :prepend t)
     ("p" "Password" entry
      (file+olp "~/org/passwords.org" "Passwörter")
      "* %?  :crypt:" :prepend t :unnarrowed t)
     ("t" "Task" entry
      (file+olp "~/org/notes.org" "Aufgaben")
      "* TODO %?
Erstellt: %U" :prepend t))))
 '(org-catch-invisible-edits (quote smart))
 '(org-clock-idle-time 30)
 '(org-columns-default-format "%30ITEM %TODO %Effort{:} %CLOCKSUM %TAGS")
 '(org-crypt-disable-auto-save t)
 '(org-crypt-key "FC31295C")
 '(org-default-notes-file "~/org/notes.org")
 '(org-file-apps
   (quote
    ((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ("\\.pdf\\'" . "zathura %s"))))
 '(org-format-latex-options
   (quote
    (:foreground default :background default :scale 2 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\["))))
 '(org-global-properties
   (quote
    (("Effort_ALL" . "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 7:00 8:00"))))
 '(org-latex-classes
   (quote
    (("article" "\\documentclass[11pt]{article}"
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
      ("\\paragraph{%s}" . "\\paragraph*{%s}")
      ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
     ("report" "\\documentclass[11pt]{report}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
     ("book" "\\documentclass[11pt]{book}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("\\subsection{%s}" . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
     ("textonly" "\\documentclass[11pt]{article}"
      ("\\iffalse %s \\fi" . "\\iffalse %s \\fi")))))
 '(org-log-into-drawer t)
 '(org-refile-allow-creating-parent-nodes t)
 '(org-refile-targets
   (quote
    ((nil :maxlevel . 2)
     (org-agenda-files :maxlevel . 2))))
 '(org-refile-use-outline-path t)
 '(org-support-shift-select t)
 '(org-tags-exclude-from-inheritance (quote ("crypt")))
 '(org-tags-sort-function (quote string<))
 '(org-treat-insert-todo-heading-as-state-change t)
 '(pc-select-override-scroll-error t)
 '(pc-select-selection-keys-only t)
 '(pc-selection-mode t)
 '(proof-autosend-delay 0.2)
 '(proof-splash-enable nil)
 '(python-shell-interpreter "nix-python")
 '(read-quoted-char-radix 10)
 '(save-place-mode t nil (saveplace))
 '(scroll-bar-mode (quote right))
 '(scroll-error-top-bottom t)
 '(send-mail-function (quote sendmail-send-it))
 '(sgml-validate-command "xmllint")
 '(sgml-xml-mode t)
 '(show-paren-mode t nil (paren))
 '(show-trailing-whitespace t)
 '(special-display-buffer-names nil)
 '(speck-aspell-coding-system (quote utf-8))
 '(speck-aspell-default-dictionary-name "de_DE")
 '(speedbar-show-unknown-files t)
 '(standard-indent 4)
 '(tab-always-indent (quote complete))
 '(tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60)))
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(tool-bar-mode nil nil (tool-bar))
 '(tramp-default-method "ssh")
 '(truncate-lines t)
 '(unibyte-display-via-language-environment nil)
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(version-control t)
 '(wdired-allow-to-change-permissions (quote advanced))
 '(yas-indent-line (quote fixed))
 '(yas-snippet-dirs (quote ("~/.emacs.d/snippets")) nil (yasnippet)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#310" :foreground "gray" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 150 :width normal :foundry "PfEd" :family "DejaVu Sans Mono"))))
 '(agda2-highlight-datatype-face ((t (:foreground "cyan"))))
 '(agda2-highlight-function-face ((t (:foreground "cyan"))))
 '(agda2-highlight-postulate-face ((t (:foreground "cyan"))))
 '(agda2-highlight-primitive-face ((t (:foreground "cyan"))))
 '(agda2-highlight-primitive-type-face ((t (:foreground "cyan"))))
 '(agda2-highlight-record-face ((t (:foreground "cyan"))))
 '(agda2-highlight-unsolved-constraint-face ((t (:background "#530"))))
 '(agda2-highlight-unsolved-meta-face ((t (:background "#530"))))
 '(erc-input-face ((t (:foreground "cyan"))))
 '(erc-my-nick-face ((t (:foreground "cyan"))))
 '(notmuch-message-summary-face ((t (:background "#808"))))
 '(trailing-whitespace ((t (:background "dark red")))))

(defun ertes-invert-colours ()
  (interactive)
  (if (equal "white" (frame-parameter nil 'background-color))
      (progn
        (set-background-color "black")
        (set-foreground-color "gray"))
    (progn
      (set-background-color "white")
      (set-foreground-color "black"))))

(defun ertes-toggle-transparency ()
  (interactive)
  (if (not (eq 85 (frame-parameter nil 'alpha)))
      (set-frame-parameter nil 'alpha 85)
    (set-frame-parameter nil 'alpha 100)))

(add-hook 'find-file-hook 'capitalized-words-mode)

(add-to-list 'auto-mode-alist '("\.html$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\.jq$" . jq-mode))
(add-to-list 'auto-mode-alist '("\.nix$" . nix-mode))
(add-to-list 'auto-mode-alist '("\.xml$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\.xsl$" . nxml-mode))

(global-set-key (kbd "<f11>") 'ertes-invert-colours)
(global-set-key (kbd "<f12>") 'ertes-toggle-transparency)
(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c d d") 'darcsum-whatsnew)
(global-set-key (kbd "C-c d p") (lambda () (interactive) (async-shell-command "darcs push -a")))
(global-set-key (kbd "C-c f") 'next-error)
(global-set-key (kbd "C-c h") 'info-display-manual)
(global-set-key (kbd "C-c -") 'comment-or-uncomment-region)
(global-set-key (kbd "C-c .") 'bury-buffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-c <backspace>") 'browse-url)
(global-set-key (kbd "M-<down>") 'enlarge-window)
(global-set-key (kbd "M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-<up>") 'shrink-window)

; (define-key agda2-mode-map (kbd "C-c C-v") 'agda2-give)

(define-key calc-mode-map (kbd "C-<down>") 'calc-truncate-down)
(define-key calc-mode-map (kbd "C-<up>") 'calc-truncate-up)

(yas-global-mode 1)

(with-demoted-errors "Unable to load ERC: %S"
  (load "~/.emacs.d/my-erc"))
