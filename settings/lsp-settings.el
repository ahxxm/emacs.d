;; -*- Emacs-Lisp -*-

(add-to-list 'load-path (concat plugins-path-r "flycheck"))
(add-to-list 'load-path (concat plugins-path-r "lsp-ui"))
(add-to-list 'load-path (concat plugins-path-r "lsp-mode"))
(add-to-list 'load-path (concat plugins-path-r "lsp-java"))
(add-to-list 'load-path (concat plugins-path-r "hydra"))
(add-to-list 'load-path (concat plugins-path-r "emacs-ccls"))
(add-to-list 'load-path (concat plugins-path-r "company-mode"))
(add-to-list 'load-path (concat plugins-path-r "emacs-request"))


(use-package lsp-mode
  :defer t
  :diminish lsp-mode
  :hook ((java-mode go-mode python-mode typescript-mode c++-mode) . lsp)
  :config
  (require 'pkg-info)
  (require 'lsp-ui-flycheck)
  (use-package lsp-completion) ;; IMPORTANT, to "lsp-configure-hook"
  (use-package lsp-ui
    :bind
    (:map lsp-mode-map
          ;; shows current file's overview, like generated godoc
          ("C-c m" . lsp-ui-imenu)
          ;; sideline peeks many information...
          ("C-c g" . lsp-find-definition)
          ("<f3>"  . lsp-find-references)
          ("<f5>"  . lsp-java-organize-imports)  ;; automatically import class
          ("<tab>" . completion-at-point)
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

    ; FIXME: "is not configured to run for major mode `go-mode'"
    (lsp-register-client
     (make-lsp-client :new-connection (lsp-stdio-connection "gopls")
                      :major-modes '(go-mode)
                      :server-id 'gopls))
    (add-to-list 'flycheck-checkers 'lsp-ui))

  :init
  (setq lsp-modeline-code-actions-enable nil
        lsp-modeline-diagnostics-enable nil
        lsp-modeline-workspace-status-enable nil
        ;; FIXME: suppose to be helpful diagnostics but says "void function"
   ; Detect project root
   lsp-auto-guess-root t
   ;; performance: https://github.com/emacs-lsp/lsp-mode/blob/master/docs/page/performance.md
   lsp-completion-provider :capf
   gc-cons-threshold 100000000
   read-process-output-max (* 1024 1024 3)))


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
  ;; FIXME: work but not the right way to hook?
  :hook (prog-mode . company-mode)
  :init
  (setq company-minimum-prefix-length 2
        company-selection-wrap-around t
        company-tooltip-align-annotations t))

(provide 'lsp-settings)
;; lsp-settings ends here.
;;;
