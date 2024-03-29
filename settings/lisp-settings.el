;; -*- Emacs-Lisp -*-
;; Settings for clojure
;; -----------------------------------[Settings for clojure]
(add-to-list 'load-path (concat plugins-path-r "sesman")) ;; required by cider
(add-to-list 'load-path (concat plugins-path-r "parseclj"))  ;; along with a.el, required by cider
(add-to-list 'load-path (concat plugins-path-r "clojure-mode"))
(add-to-list 'load-path (concat plugins-path-r "cider"))
(add-to-list 'load-path (concat plugins-path-r "ac-cider"))

(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))

(use-package
  ac-cider
  :defer t
  :commands (ac-cider-setup ac-flyspell-workaround))

(use-package
  cider-macroexpansion
  :defer t
  :commands (cider-macroexpansion-mode cider-macroexpand-1 cider-macroexpand-all))

(use-package
  cider-find
  :defer t
  :commands (cider-find-var))

(use-package
  cider
  :defer t
  :commands (cider-mode)
  :init
  (setq nrepl-hide-special-buffers t
        nrepl-buffer-name-show-port t
        cider-prefer-local-resources t
        cider-repl-buffer-size-limit 1024 ;; '321 enter' triggers auto-erase when size exceeds
        cider-print-limit 1024 ;; try limit to 1kb but
        cider-print-fn 'fipp ;; faster than default pprint
        cider-repl-display-in-current-window t
        cider-repl-history-size 10000
        cider-repl-result-prefix ";; => "
        cider-repl-history-file (concat emacs-root-path "cider-repl.history")
        cider-stacktrace-fill-column 80)
  :bind (:map cider-mode-map            ; bind keys in specific map
              ("C-c M-c" . copy-file-name) ; originally cider-connect
              ("C-c g"   . cider-find-var))
  :config
  (add-hook 'nrepl-mode-hook 'ac-cider-setup)
  (add-hook 'nrepl-interaction-mode-hook 'ac-cider-setup)
  (add-hook 'nrepl-interaction-mode-hook 'eldoc-mode)
  (add-hook 'cider-mode-hook 'ac-flyspell-workaround)
  (add-hook 'cider-mode-hook 'ac-cider-setup)
  (add-hook 'cider-mode-hook 'eldoc-mode)
  (add-hook 'cider-repl-mode-hook 'subword-mode))

(use-package
  clojure-mode
  :bind (:map clojure-mode-map             ; bind keys in specific map
              ("M-SPC" . fixup-whitespace) ; from simple.el
              ("C-c g" . cider-find-var))
  :config
  (add-hook 'clojure-mode-hook
            (lambda ()
              (cider-mode +1)))
  :mode
  ("\\.clj[csx]?\\'" . clojure-mode)
  ("\\.boot\\'"      . clojure-mode)
  ("\\.edn\\'"       . clojure-mode))

(eval-after-load "ob"
  ;; clojure integration for emacs
  '(progn
     (defun clojure-for-org-mode()
       (defvar org-babel-default-header-args:clojure
         '((:results . "silent") (:tangle . "yes")))
       (defun org-babel-execute:clojure (body params)
         "Evaluate a block of Clojure code with Babel."
         (lisp-eval-string body)
         "Done!"))
     (clojure-for-org-mode)))


(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'nrepl-mode)))

(dolist (hook '(emacs-lisp-mode-hook
                lisp-mode-hook
                lisp-interaction-mode-hook)))

;; Settings for elisp
;; -------------------------------------[Settings for elisp]
;; 1. Add eldoc for emacs
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(provide 'lisp-settings)
;; lisp-settings ends here.
;;;
