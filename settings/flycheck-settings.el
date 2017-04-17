;; -*- Emacs-Lisp -*-
;;; code:
(add-to-list 'load-path (concat plugins-path-r "flycheck/"))
(add-to-list 'load-path (concat plugins-path-r "seq.el"))

(use-package
  flycheck
  :defer t
  :commands (flycheck-mode)
  :init
  (setq flycheck-mode-line-prefix "F")

  (when (memq system-type '(darwin gnu gnu/linux gnu/kfreebsd))
        (add-hook 'c++-mode-hook
              #'(lambda ()
                  (setq flycheck-clang-include-path
                        (list "/usr/local/include")
                        ))))

  ;; language standard for c/c++ files
  (add-hook 'c++-mode-hook
            (lambda ()
              (setq flycheck-clang-language-standard "c++14")))

  (dolist (hook '(python-mode-hook
                  clojure-mode-hook
                  c-mode-hook
                  c++-mode-hook))
    (add-hook hook #'flycheck-mode))
  )

(provide 'flycheck-settings)
;; flycheck-settings ends here.
;;;
