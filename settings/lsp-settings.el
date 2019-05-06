;; -*- Emacs-Lisp -*-

(add-to-list 'load-path (concat plugins-path-r "dap-mode"))
(add-to-list 'load-path (concat plugins-path-r "lsp-ui"))
(add-to-list 'load-path (concat plugins-path-r "lsp-mode"))
(add-to-list 'load-path (concat plugins-path-r "lsp-java"))
(add-to-list 'load-path (concat plugins-path-r "emacs-ccls"))
(add-to-list 'load-path (concat plugins-path-r "company-mode"))
(add-to-list 'load-path (concat plugins-path-r "company-lsp"))
(add-to-list 'load-path (concat plugins-path-r "emacs-request"))


(use-package lsp-mode
  :diminish lsp-mode
  :hook ((java-mode go-mode python-mode typescript-mode c++-mode) . lsp)
  :config
  (require 'lsp-clients)
  (use-package lsp-ui
    :custom-face
    (lsp-ui-doc-background ((t `(:background nil))))
    :bind
    (:map lsp-mode-map
          ;; shows current file's overview, like generated godoc
          ("C-c m" . lsp-ui-imenu)
          ;; sideline peeks many information...
          ("C-c g" . lsp-find-definition)
          ("<f3>"  . lsp-find-references)
          ("C-c i" . lsp-ui-peek-find-implementation)
          ("C-c s" . lsp-ui-sideline-mode))
    :hook (lsp-mode . lsp-ui-mode)
    :init
    (setq
     lsp-enable-snippet nil ;; yasnippet not used here
     lsp-ui-doc-enable nil
     lsp-ui-doc-include-signature nil
     lsp-ui-doc-header nil
     lsp-ui-doc-position 'at-point
     lsp-ui-doc-use-webkit t
     lsp-ui-doc-border (face-foreground 'default)
     lsp-ui-sideline-enable nil
     lsp-ui-sideline-ignore-duplicate t))

  :init
  (setq lsp-document-sync-method 'incremental)
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


(use-package lsp-java
  :after lsp
  :hook (java-mode . (lambda ()
                       (require 'lsp-java)
                       (lsp))))

(use-package ccls
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp))))

(use-package company
  :diminish company-mode
  :init
  (setq company-minimum-prefix-length 2
        company-selection-wrap-around t
        company-tooltip-align-annotations t)
  :config
  (add-hook 'after-init-hook 'global-company-mode))


(use-package company-lsp
  :commands company-lsp
  :after company lsp-mode
  :bind (("<tab>"   . 'company-complete-selection))
  :init
  (push 'company-lsp company-backends)
  :custom
  (company-lsp-async t)
  (company-lsp-enable-snippet t))

(provide 'lsp-settings)
;; lsp-settings ends here.
;;;
