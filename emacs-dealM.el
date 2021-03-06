;; -*- Emacs-Lisp -*-
;; configure path depend on system.

;; SPEEDY startup
(setq gc-cons-threshold 80000000)

(defconst emacs-root-path
  (file-name-directory (or load-file-name buffer-file-name)) "Emacs root settings path (in linux)")
(defconst plugins-path-r
  (concat emacs-root-path "plugins/") "Reference path of emacs lisp package")
(defconst themes-path-r
  (concat emacs-root-path "themes/") "Reference path of emacs theme")
(defconst settings-path-r
  (concat emacs-root-path "settings/") "Personel prefer setting of lisp package")

(defcustom default-theme-r 'monokai
  "Default theme for dealM"
  :type 'symbol
  :group 'dealM)

;; Font settings works for window mode
;; emacs -nw will inherit terminal's
(defcustom default-source-font-r "Courier-14"
  "Default font for dealM"
  :type 'string
  :group 'dealM)

(set-face-attribute 'default nil :font default-source-font-r)

;; add load path
(add-to-list 'load-path settings-path-r)
(add-to-list 'load-path plugins-path-r)
(add-to-list 'load-path (concat plugins-path-r "dash/"))
(add-to-list 'load-path (concat plugins-path-r "use-package/"))

;; BENCHMARK
;;(add-to-list 'load-path (concat plugins-path-r "benchmark-init-el/"))
;;(require 'benchmark-init-loaddefs)
;;(benchmark-init/activate)


;; tools
;; ------------------------------------------------------------------
(require 'use-package)
(require 'flycheck-settings)
(require 'auto-complete-setting)


;; Theme, color and fonts, encoding settings.
;; ------------------------------------------------------------------
(require 'theme-settings)
(require 'modeline-settings)


;; default emacs behavior settings(keys and common settings)
;; ------------------------------------------------------------------
(require 'default-behavior-settings)
(require 'window-buffer-settings)
(require 'edit-settings)
(require 'ido-settings)
(require 'dired-settings)


;; Programming settings
;; ------------------------------------------------------------------
(require 'dev-settings)
(require 'lisp-settings)
(require 'go-settings)
(require 'lsp-settings)


;; registers.
;; ------------------------------------------------------------------
(set-register ?e '(file . "~/.emacs"))               ;; C-x r j e: register jump to the .emacs(home).

(provide 'emacs-dealM)
;; emacs-dealM ends here.
;;;
