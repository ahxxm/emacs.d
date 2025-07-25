;; -*- Emacs-Lisp -*-
(ido-mode t)

(setq ido-enable-flex-matching t) ;; enable fuzzy matching
(ido-everywhere t)

;; Global keybindings - set immediately  
(global-set-key (kbd "C-x C-f") 'ido-find-file)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(defun ido-my-keys()
  "ido completion map key settings"

  (define-key ido-completion-map (kbd "M-.")   'ido-next-match-dir)
  (define-key ido-completion-map (kbd "M-,")   'ido-prev-match-dir)
  (define-key ido-completion-map (kbd "C-h")   'ido-delete-backward-updir)
  (define-key ido-completion-map (kbd "M-h")   'ido-up-directory)
  (define-key ido-completion-map (kbd "M-H")   'ido-up-directory-clean-text)
  (define-key ido-completion-map (kbd "C-M-h") 'ido-goto-home)
  (define-key ido-completion-map (kbd "C-r")   'ido-goto-root)
  (define-key ido-completion-map (kbd "C-u")   'ido-clean-text)
  (define-key ido-completion-map (kbd "M-b")   'backward-word)
  (define-key ido-completion-map (kbd "C-w")   'ido-delete-backward-word-updir)
  (define-key ido-completion-map (kbd "C-v")   'ido-enter-svn-status-hide)
  (define-key ido-completion-map (kbd "C-n")   'ido-next-match)
  (define-key ido-completion-map (kbd "C-p")   'ido-prev-match)
  )

(add-hook 'ido-setup-hook 'ido-my-keys)
(eval-after-load "projectile"
  '(progn
     (defun smart-switch-buffer()
       (interactive)
       (if (projectile-project-p)
           (call-interactively 'projectile-switch-to-buffer)
       (call-interactively 'switch-to-buffer)))
     (global-set-key (kbd "C-x b") 'smart-switch-buffer)))


(provide 'ido-settings)
;; ido-settings ends here.
;;;
