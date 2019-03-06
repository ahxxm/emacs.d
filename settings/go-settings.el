;; -*- Emacs-Lisp -*-
;; Last modified: <2017-01-20 14:51:52 Friday by richard>

;; Copyright (C) 2016 Richard Wong

;; Author: Richard Wong
;; Email: chao787@gmail.com

;; Version: 0.1
;; PUBLIC LICENSE: GPLv3

(add-to-list 'load-path (concat plugins-path-r "go-mode"))
(add-to-list 'load-path (concat plugins-path-r "go-eldoc"))

(use-package go-mode
  :defer t
  :commands (gofmt gofmt-before-save)
  :mode "\\.go\\'"
  :bind (:map go-mode-map
              ("C-c g" . godef-jump))
  :config
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'go-mode-hook 'company-mode))

(use-package go-eldoc
  :after go-mode
  :defer t
  :commands (go-eldoc-setup)
  :init
  (add-hook 'go-mode-hook 'go-eldoc-setup))

(use-package company-go
  :after go-mode
  :config
  (add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode))))

(provide 'go-settings)
;; go-settings ends here.
;;;
