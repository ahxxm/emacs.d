;; -*- Emacs-Lisp -*-
(add-to-list 'load-path (concat plugins-path-r "irony-mode/"))

;; irony requires:
;; - dep: libclang
;; - first run: M-x irony-install-server
;; See: https://github.com/Sarcasm/irony-mode
(use-package
  irony
  :defer t
  :commands (irony-mode)
  :init
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  :config
  (defun my-irony-mode-hook ()
    (local-set-key (kbd "TAB") 'irony-completion-at-point-async))
  (add-hook 'irony-mode-hook 'my-irony-mode-hook)
  )


(provide 'irony-settings)
