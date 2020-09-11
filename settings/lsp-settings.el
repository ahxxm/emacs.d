;; -*- Emacs-Lisp -*-

(add-to-list 'load-path (concat plugins-path-r "flycheck"))
(add-to-list 'load-path (concat plugins-path-r "lsp-ui"))
(add-to-list 'load-path (concat plugins-path-r "lsp-mode"))
(add-to-list 'load-path (concat plugins-path-r "lsp-java"))
(add-to-list 'load-path (concat plugins-path-r "hydra"))
(add-to-list 'load-path (concat plugins-path-r "emacs-ccls"))
(add-to-list 'load-path (concat plugins-path-r "company-mode"))
(add-to-list 'load-path (concat plugins-path-r "company-lsp"))
(add-to-list 'load-path (concat plugins-path-r "emacs-request"))


(use-package lsp-mode
  :defer t
  :diminish lsp-mode
  :hook ((java-mode go-mode python-mode typescript-mode c++-mode) . lsp)
  :config
  (require 'pkg-info)
  (require 'lsp-ui-flycheck)
  (use-package lsp-ui
    :bind
    (:map lsp-mode-map
          ;; shows current file's overview, like generated godoc
          ("C-c m" . lsp-ui-imenu)
          ;; sideline peeks many information...
          ("C-c g" . lsp-find-definition)
          ("<f3>"  . lsp-find-references)
          ("<f5>"  . lsp-java-organize-imports)  ;; automatically import class
          ("C-c i" . lsp-ui-peek-find-implementation)
          ("C-c s" . lsp-ui-sideline-mode))
    :init
    (setq lsp-enable-snippet nil ;; yasnippet not used here
          lsp-ui-doc-enable nil
          lsp-ui-sideline-enable t
          lsp-ui-sideline-ignore-duplicate t

     ; Use lsp-ui and flycheck
     lsp-prefer-flymake :none
     lsp-ui-flycheck-enable t)
    (add-to-list 'flycheck-checkers 'lsp-ui))

  :init
  (setq lsp-modeline-code-actions-enable nil ;; FIXME: 7.0.1 lsp
        lsp-modeline-diagnostics-enable nil  ;; FIXME: 7.0.1 lsp
        ; Detect project root
        lsp-auto-guess-root t))


(use-package lsp-java
  ;; ref: https://blog.jmibanez.com/2019/03/31/emacs-as-java-ide-revisited.html
  :after lsp
  :config
  (setq lombok-jar-path
      (expand-file-name
        "~/.m2/repository/org/projectlombok/lombok/1.18.8/lombok-1.18.8.jar"))
  (setq lsp-java-vmargs
        (list "-noverify"
              "-Xmx2G"
              "-XX:+UseG1GC"
              "-XX:+UseStringDeduplication"
              (concat "-javaagent:" lombok-jar-path)
              (concat "-Xbootclasspath/a:" lombok-jar-path))
        lsp-file-watch-ignored
        '(".idea" ".ensime_cache" ".eunit" "node_modules"
          ".git" ".hg" ".fslckout" "_FOSSIL_"
          ".bzr" "_darcs" ".tox" ".svn" ".stack-work"
          "build")

        lsp-java-import-order '["" "java" "javax" "#"]
        ;; Don't organize imports on save
        lsp-java-save-action-organize-imports nil)
  :hook (java-mode . (lambda ()
                       (setq-local tab-width 4)
                       (require 'lsp-java)
                       (lsp))))

(use-package ccls
  :defer t
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp))))

(use-package company
  :defer t
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
