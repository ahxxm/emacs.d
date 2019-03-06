;; -*- Emacs-Lisp -*-

(add-to-list 'load-path (concat plugins-path-r "dap-mode"))
(add-to-list 'load-path (concat plugins-path-r "lsp-ui"))
(add-to-list 'load-path (concat plugins-path-r "lsp-mode"))
(add-to-list 'load-path (concat plugins-path-r "lsp-java"))
(add-to-list 'load-path (concat plugins-path-r "company-mode/"))
(add-to-list 'load-path (concat plugins-path-r "company-lsp"))
(add-to-list 'load-path (concat plugins-path-r "emacs-request"))


;; FIXME: void function company-mode

(use-package lsp-mode
  :diminish lsp-mode
  :bind (("C-c g" . lsp-find-definition)
         ("<f3>"  . lsp-find-references))
  :hook (prog-mode . lsp)
  :config
  (require 'lsp-clients)
  :init
  (setq lsp-auto-guess-root t)       ; Detect project root
  (setq lsp-prefer-flymake nil)      ; Use lsp-ui and flycheck
  )

(use-package dap-mode
  :after lsp-mode
  :init
  (require 'cl)
  (require 'cl-lib)
  ;; TODO: (dap-ui-mode t) in config
  :config
  (dap-mode t))

(use-package lsp-ui
  :custom-face
  (lsp-ui-doc-background ((t `(:background nil))))
  :bind (:map lsp-ui-mode-map
              ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
              ([remap xref-find-references] . lsp-ui-peek-find-references)
              ("C-c u" . lsp-ui-imenu))
  :init
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-include-signature t
        lsp-ui-doc-position 'at-point
        lsp-ui-doc-use-webkit t
        lsp-ui-doc-border (face-foreground 'default)

        lsp-ui-sideline-enable nil
        lsp-ui-sideline-ignore-duplicate t)
  :config
  ;; WORKAROUND Hide mode-line of the lsp-ui-imenu buffer
  ;; https://github.com/emacs-lsp/lsp-ui/issues/243
  (defadvice lsp-ui-imenu (after hide-lsp-ui-imenu-mode-line activate)
    (setq mode-line-format nil)))

(use-package lsp-java
  :after lsp
  :hook (java-mode . (lambda ()
                       (require 'lsp-java)
                       (lsp))))

(require 'lsp-clients)
(use-package company-lsp
  :commands company-lsp
  :config
  (add-to-list 'company-backends 'company-lsp)
  :custom
  (company-lsp-async t)
  (company-lsp-enable-snippet t))

(provide 'lsp-settings)
;; lsp-settings ends here.
;;;
