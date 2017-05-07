;; -*- Emacs-Lisp -*-
(add-to-list 'load-path (concat plugins-path-r "company-mode/"))
(add-to-list 'load-path (concat plugins-path-r "irony-mode/"))
(add-to-list 'load-path (concat plugins-path-r "company-irony/"))

(autoload 'company-irony "company-irony" nil t)
(autoload 'company-complete "company-mode" nil t)
(autoload 'company-irony-setup-begin-commands "company-irony")

;; irony requires:
;; - dep: libclang
;; - first run: M-x irony-install-server
;; See: https://github.com/Sarcasm/irony-mode
(use-package irony
  :defer t
  :commands (irony-mode)
  :init
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  :config

  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-irony))
  (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)

  ;;(defun my-irony-mode-hook ()
;;    (local-set-key (kbd "TAB") company-complete))
;;  (add-hook 'irony-mode-hook 'my-irony-mode-hook)
  )



(provide 'irony-settings)
