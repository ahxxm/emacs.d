;; -*- Emacs-Lisp -*-
;; Last modified: <2017-02-21 16:05:07 Tuesday by ahxxm>

;; Copyright (C) 2016 Richard Wong

;; Author: Richard Wong
;; Email: github@cccc.im

;; Version: 0.1
;; PUBLIC LICENSE: GPLv3

;;; code:
(add-to-list 'load-path (concat plugins-path-r "flycheck/"))
(add-to-list 'load-path (concat plugins-path-r "seq.el"))

(use-package
  flycheck
  :defer t
  :commands (flycheck-mode)
  :init
  (setq flycheck-mode-line-prefix "F"
        flycheck-clang-language-standard "c++14")

  (when (memq system-type '(darwin gnu gnu/linux gnu/kfreebsd))
        (add-hook 'c++-mode-hook
              #'(lambda ()
                  (setq flycheck-clang-include-path
                        (list "/usr/local/include")
                        ))))
  (dolist (hook '(python-mode-hook
                  clojure-mode-hook
                  c++-mode-hook
                  go-mode-hook))
    (add-hook hook #'flycheck-mode))
  )

(provide 'flycheck-settings)
;; flycheck-settings ends here.
;;;
