;; -*- Emacs-Lisp -*-
;; Last modified: <2017-02-18 11:40:49 Saturday by richard>

;; Copyright (C) 2012 Richard Wong

;; Author: Richard Wong
;; Email: chao787@gmail.com

;; Version: 0.8
;; PUBLIC LICENSE: GPLv3

(use-package edit-functions
  ;; :commands (def-position-command)
  :defer t
  :init
  ;;; ensure C-z unbinded
  (global-unset-key "\C-z")
  :config
  ;; other global keys.
  (when (string= system-type "windows-nt")
    (w32-register-hot-key (kbd "M-w")))
  (def-position-command goto-plugins
    (kbd "C-x g p") plugins-path-r)
  (def-position-command goto-settings
    (kbd "C-x g s") settings-path-r)
  (def-position-command goto-emacs-root
    (kbd "C-x g e") emacs-root-path)
  (def-position-command goto-tmp
    (kbd "C-x g t") "~/.tmp/")
  ;; Advice combinators:
  ;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Advice-combinators.html
  (advice-add #'kill-line :before-until
              #'kill-line--before-until-cua-and-region-handled)
  :bind (("C-x q" . switch-major-mode)
         ("C-x m" . get-mode-name)
         ("C-o" . open-line-if-active-delete-then-open-line)
         ("C-]" . goto-paren)
         ("C-M-]" . ywb-indent-accoding-to-paren)
         ("C-c M-c" . copy-file-name)
         ("C-x M-O" . open-current-file-with-app)
         ("C-x s"   . switch-to-scratch)
         ("C-x M-s" . switch-to-shell)
         ("C-x M-m" . switch-to-message)
         ("M-SPC"   . just-one-space)
         ("C-x j"   . jump-to-register)
         ("<M-mouse-4>" . previous-buffer)
         ("<M-mouse-5>" . next-buffer)
         ("<M-wheel-up>" . previous-buffer)
         ("<M-wheel-down>" . next-buffer)
         ("M-J" . join-line)
         ("M-C-k" . kill-whole-paragraph)
         ("M-w" . smart-copy)
         ("M-k" . kill-paragraph)
         ("M-C" . copy-whole-paragraph)
         ("C-M-w" . smart-insert-line)
         ("C-k" . program-smart-kill)
         ("C-a" . smart-move-beginning-of-line)
         ("C-\\" . delete-indentation)
         ("M-U" . del-to-begin)
         ("C-w" . backward-kill-word-or-kill-region)
         ("C-x S" . mark-whole-sexp)
         ("C-x C-k" . kill-whole-sexp)
         ("C-x M-w" . copy-sexp)
         ("C-x TAB" . smart-indent)
         ("C-h" . c-electric-backspace-kill)
         ("M-q" . fill-paragraph-justify)
         ("C-c C" . comment-function)

         ("C-z" . undo)
         ("M-Y" . redo)

         ;; Wheel settings
         ("<C-mouse-4>" . text-scale-increase)
         ("<C-mouse-5>" . text-scale-decrease)))

(use-package simple
  :if window-system
  :defer t
  :bind (("M-n" . next-error)
         ("M-p" . previous-error)))


(use-package menu-bar
  :defer t
  ;; Mac integration.
  :bind (("s-x" . clipboard-kill-region)
         ("s-c" . clipboard-kill-ring-save)
         ("s-v" . clipboard-yank)))

;; occur
;; -------------------------------------------------[ioccur]

;; using regular expression as default search

(use-package isearch
  :defer t  ; :commands, :bind*?, :bind-keymap*?, :mode, :interpreter implies
  :init
  (defun isearchp-open-occur()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string)))))
  (defun isearchp-kill-ring-save (&optional arg)
    "Copy the current search string to the kill ring.
For example, you can then use `C-s M-y' to search for the same thing
in another Emacs session.
    If ARG is "
    (interactive "P")
    (setq arg (or arg 0))
    (cond ((= (prefix-numeric-value arg) 0)
           (kill-new isearch-string))
          ((= (prefix-numeric-value arg) 4)
           (copy-region-as-kill isearch-other-end (point)))
          (t (copy-lines-matching-re isearch-string)
             ;; TODO: copy all match strings probably can reuse occur pkg.
             ))
    (let ((message-log-max nil))
      (message "%s copied" (current-kill 0))
      (sit-for 1)
      (isearch-update)))
  :bind (("C-s" . isearch-forward-regexp)
         ("\C-r" . isearch-backward-regexp)
         ("C-M-s" . isearch-forward)
         ("C-M-r" . isearch-backward)
         :map isearch-mode-map
         ("C-o" . isearchp-open-occur)
         ("M-w" . isearchp-kill-ring-save)))


;; pager: Fix windows lines bugs in scroll-up and down.
(use-package pager
  :defer t
  :bind (("C-v"	 . pager-page-down)
         ([next] . pager-page-down)
         ("M-v" . pager-page-up)
         ([prior] . pager-page-up)
         ([M-up] . pager-row-up)
         ([M-kp-8] . pager-row-up)
         ([M-down] . pager-row-down)
         ([M-kp-2] . pager-row-down)))

(use-package help
  :defer t
  :bind (("C-x /" . help-command)
         ("C-x ?" . help-command)))

(use-package files
  :defer t
  :bind (("C-x u" . revert-buffer)))

;; align settings.
(use-package align
  :defer t
  :bind (("C-x a" . align-current)
         ("C-x M-a" . align-regexp)))

(provide 'edit-settings)
;; edit-settings ends here.
;;;
