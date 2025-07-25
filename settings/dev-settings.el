;; -*- Emacs-Lisp -*-
;; This file is a extension for edit-settings.

;; autoloads
;; ------------------------------------------------------------------
(autoload 'highlight-indentation-mode "highlight-indentation" "")
(autoload 'yaml-mode "yaml-mode" "")
(autoload 'electric-spacing-mode "electric-spacing" "\
Insert operators with surrounding spaces smartly.

\(fn &optional ARG)" t nil)

(eval-after-load "highlight-indentation"
  '(progn
     (set-face-background 'highlight-indentation-face "grey30")
     (set-face-background 'highlight-indentation-current-column-face "grey50")
     ))


;; hl-line+ settings.
;; ------------------------------------------------------------------

(defface hl-line '((t (:background "SlateGray3"))) "\
Face to use for `hl-line-face'." :group (quote hl-line))

(defvar hl-line-flash-show-period 1 "\
Number of seconds for `hl-line-flash' to highlight the line.")

(custom-autoload 'hl-line-flash-show-period "hl-line+" t)

(defvar hl-line-inhibit-highlighting-for-modes nil "\
Modes where highlighting is inhibited for `hl-line-highlight-now'.
A list of `major-mode' values (symbols).")

(custom-autoload 'hl-line-inhibit-highlighting-for-modes "hl-line+" t)

(defalias 'toggle-hl-line-when-idle 'hl-line-toggle-when-idle)

(autoload 'hl-line-toggle-when-idle "hl-line+" "\
Turn on or off using `global-hl-line-mode' when Emacs is idle.
When on, use `global-hl-line-mode' whenever Emacs is idle.
With prefix argument, turn on if ARG > 0; else turn off.

\(fn &optional ARG)" t nil)

(autoload 'hl-line-when-idle-interval "hl-line+" "\
Set wait until using `global-hl-line-mode' when Emacs is idle.
Whenever Emacs is idle for this many seconds, `global-hl-line-mode'
will be turned on.

To turn on or off using `global-hl-line-mode' when idle,
use `\\[toggle-hl-line-when-idle].

\(fn SECS)" t nil)

(defalias 'flash-line-highlight 'hl-line-flash)

(autoload 'hl-line-flash "hl-line+" "\
Highlight the current line for `hl-line-flash-show-period' seconds.
With a prefix argument, highlight for that many seconds.

\(fn &optional ARG)" t nil)


;; highlight-symbol settings.
;; ------------------------------------------------------------------
(autoload 'global-auto-highlight-symbol-mode "auto-highlight-symbol" "" t)
(autoload 'auto-highlight-symbol-mode "auto-highlight-symbol" "" t)
(autoload 'highlight-symbol-at-point "highlight-symbol" "" t)
(defalias 'highlight-symbol 'highlight-symbol-at-point)


;; git (magit) settings here
;; ------------------------------------------------------------------
(add-to-list 'load-path (concat plugins-path-r "transient/lisp")) ;; required by magit
(add-to-list 'load-path (concat plugins-path-r "magit/lisp"))
(add-to-list 'load-path (concat plugins-path-r "magit/lisp/magit-autoloads"))
(add-to-list 'load-path (concat plugins-path-r "compat/"))  ;; required by with-editor
(add-to-list 'load-path (concat plugins-path-r "with-editor/lisp"))
(add-to-list 'load-path (concat plugins-path-r "git-modes"))

(use-package magit
  :bind (("C-x v z" . magit-status)))

(use-package magit
  :after (dired)
  :bind (:map dired-mode-map
              ("c" . magit-status)))



;; Projectile settings. more smarter than ftf
;; ------------------------------------------------------------------
(use-package projectile
  :defer t
  :commands   ; for autoload
  (projectile-project-p
   projectile-find-file
   projectile-project-vcs
   projectile-project-root
   projectile-project-name)
  :bind (("<f1>" . smart-find-file)
         ("<f2>" . smart-grep)
         ("<f4>" . projectile-invalidate-cache))

  :config   ; execute code after a package is loaded
  (defun smart-find-file ()
    (interactive)
    (if (projectile-project-p)
        (call-interactively 'projectile-find-file)
      (call-interactively 'ido-find-file)))

  (defun feeling-lucky-grep (pattern)
    (interactive
     (list (read-string
            "git grep: "
            (substring-no-properties (or (thing-at-point 'symbol) "")))))
    (require 'magit)
    (with-current-buffer (generate-new-buffer "*Magit Grep*")
      (setq default-directory (projectile-project-root))
      (insert magit-git-executable " "
              ;; FIXME: (mapconcat 'identity magit-git-standard-options " ")
              " grep -n "
              (shell-quote-argument pattern) "\n\n")
      (magit-git-insert "grep" "--line-number" "--color" pattern)
      (ansi-color-apply-on-region (point-min) (point-max))
      (pop-to-buffer (current-buffer))
      (grep-mode)))
  (defun smart-grep ()
    (interactive)
    (if (eq (projectile-project-vcs) 'git)
        (call-interactively 'feeling-lucky-grep)
      (call-interactively 'projectile-grep)))
  (use-package dired
    :bind (:map dired-mode-map
                ("<f1>" . smart-find-file)))

  ;; enable mode globally, brings caching param and enable
  ;; cache was written to:
  ;; (expand-file-name "projectile.cache" user-emacs-directory)
  (projectile-mode)
  (setq projectile-enable-caching t))


(use-package projectile
  :after
  (isearch)
  :defer t
  :config
  (defun searchp-open-multi-occur ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search)
          (search-string (if isearch-regexp
                             isearch-string
                           (regexp-quote isearch-string))))
      (if (projectile-project-p)
          (projectile-multi-occur search-string)
        (multi-occur-in-this-mode search-string)))))


;; parenthses settings
;; ------------------------------------------------------------------
(add-to-list 'load-path (concat plugins-path-r "rainbow-delimiters/"))
(autoload 'rainbow-delimiters-mode "rainbow-delimiters.el" "" t)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(autoload 'highlight-parentheses-mode "highlight-parentheses")

(setq hl-paren-colors '("red" "yellow" "cyan" "magenta" "green" "red"))

(setq paren-message-show-linenumber 'absolute)
(autoload 'paren-activate                         "mic-paren" "" t)
(autoload 'paren-deactivate                       "mic-paren" "" t)
(autoload 'paren-toggle-matching-paired-delimiter "mic-paren" "" t)
(autoload 'paren-toggle-matching-quoted-paren     "mic-paren" "" t)
(autoload 'paren-toggle-open-paren-context        "mic-paren" "" t)
(show-paren-mode t)

;; rainbow-mode
;; ------------------------------------------------------------------
(add-to-list 'load-path (concat plugins-path-r "rainbow-mode"))

(use-package rainbow-mode
  :commands (rainbow-mode))

(dolist (hook '(html-mode-hook
                css-mode-hook
                emacs-lisp-mode-hook))
  (add-hook hook #'rainbow-mode))



;;----------------------------------------------------------
;; Mode specific shortcut settings.
;;----------------------------------------------------------
(defun start-program-short-cut()
  "common program short-cut keys."
  ;; RET is reindent thisline and indent the new line.
  (local-set-key (kbd "RET")     'reindent-then-newline-and-indent)
  (local-set-key "\C-k"          'program-smart-kill)
  (local-set-key (kbd "C-c C-c") 'comment)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace)
  ;; (linum-mode t)
  ;; highlight settings by mode.
  (hl-line-mode t)
  (auto-highlight-symbol-mode)
  (highlight-parentheses-mode t)
  (highlight-indentation-mode t)

  (font-lock-add-keywords
   nil
   '(("\\<\\(FIX\\(ME\\)?\\|TODO\\|HACK\\|REFACTOR\\|NOCOMMIT\\|WARN\\(ING\\)?\\)"
      1 font-lock-warning-face t)))

  ;; use it only in specific mode.
  (ac-config-default))

;; lisp short cut Settings.
;; ==================================================================
(defun elisp-short-cut()
  "Lisp Specific mode short-cut key settings."
  (start-program-short-cut)

  (local-set-key (kbd "C-c C-k") 'kill-function)
  (local-set-key (kbd "C-M-h")   'mark-function)
  (local-set-key (kbd "C-c D")   'edebug-defun)
  (local-set-key (kbd "C-c C-d") 'eval-defun)
  (local-set-key (kbd "C-c B")   'eval-buffer)
  (local-set-key (kbd "C-c M-w") 'copy-function-whole)
  (local-set-key (kbd "C-c C-q") 'indent-function))


;; json short cut Settings.
;; ==================================================================
(defun json-short-cut()
  "json mode short-cut key settings."
  (start-program-short-cut)
  (setq json-reformat:indent-width 2)
  (defun json-smart-indent ()
    (interactive)
    (save-excursion
      (unless mark-active
        (call-interactively 'mark-whole-buffer))
      (call-interactively 'json-reformat-region)))
  (local-set-key (kbd "C-x TAB") 'json-smart-indent)
  )

;; clojure short cut Settings.
;; ==================================================================
(defun clojure-short-cut()
  "Clojure mode short-cut key settings."
  (start-program-short-cut))


;; c-common-mode short cut settings.
;; ==================================================================
(defun c-common-short-cut()
  "c common mode short-cut key settings."
  ;; make lsp completion-at-point work
  (local-unset-key (kbd "TAB"))
  ;; TODO: indent-for-tab-command and c-indent-line-or-region shortcuts

  (start-program-short-cut)
  (electric-spacing-mode)
  (setq c-basic-offset 2)
  (paren-toggle-open-paren-context 1))

;; Short cut Hooks here.
;; ==================================================================
(add-hook 'emacs-lisp-mode-hook 'elisp-short-cut)
(add-hook 'clojure-mode-hook    'clojure-short-cut)
(add-hook 'json-mode-hook       'json-short-cut)
(add-hook 'c-mode-common-hook   'c-common-short-cut)

(provide 'dev-settings)
;; dev-settings ends here.
;;;
