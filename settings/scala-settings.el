;; -*- Emacs-Lisp -*-

(add-to-list 'load-path (concat plugins-path-r "emacs-sbt-mode"))
(add-to-list 'load-path (concat plugins-path-r "scala-mode"))


(use-package scala-mode
  :init
  (setq max-lisp-eval-depth 50000)
  (setq max-specpdl-size 50000))


(use-package sbt-mode
  ;; :commands sbt-start sbt-command
  ;;:mode "\\.scala\\'"
  :bind (("C-c M-j" . sbt-start))
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map))

(provide 'scala-settings)
;; scala-settings ends here.
;;;
