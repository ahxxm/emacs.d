;; -*- Emacs-Lisp -*-
;; Emacs default behavoir settings

;; use newer el file other than byte-compiled old ones
(setq load-prefer-newer t)

;; enable jit
(setq package-native-compile t)

(setq-default default-directory "~"
              indicate-buffer-boundaries 'left)

(setq line-move-visual nil
      visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))


(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta))

;; hide menu-bar and tool-bar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'blink-cursor-mode) (blink-cursor-mode -1))

;; speed up keystroke
(setq echo-keystrokes 0.1
      font-lock-maximum-decoration t
      system-time-locale "C")

(global-font-lock-mode t)

;; disable scroll bar
(customize-set-variable 'scroll-bar-mode nil)

(use-package files
  :init
  ;; Diable backup
  (setq-default make-backup-files nil
                auto-save-default nil))

(use-package tramp-sh
  :defer t
  :config
  (add-to-list 'tramp-remote-process-environment "LC_ALL=zh_CN.utf8" 'append)
  (add-to-list 'tramp-remote-process-environment "LANG=zh_CN.utf8" 'append))

(use-package tramp
  :defer t
  :commands (tramp-mode)
  :init
  (setq tramp-default-method "ssh"
        ido-enable-tramp-completion t
        ;; workaround for tramp, see: http://goo.gl/DUKMC8
        tramp-ssh-controlmaster-options "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no"
        tramp-verbose 4                 ; 1 - 10
        tramp-persistency-file-name
        (concat emacs-root-path ".auto-save-list-tramp")))

(add-hook 'text-mode-hook 'text-mode-hook-identify)
(add-hook 'text-mode-hook 'turn-off-auto-fill)

;; insert two spaces after two colon:
(setq colon-double-space t
      column-number-mode t)

;; emacs lock
(autoload 'toggle-emacs-lock "emacs-lock" "Emacs lock" t)

;; 启用以下功能
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
;; disable cursor blinking
(blink-cursor-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)

;; disable emacs start screen
(setq inhibit-startup-message t
      initial-scratch-message "")



;; 简写模式
(setq-default abbrev-mode t)
(setq save-abbrevs nil)

;; 防止页面滚动时跳动,scroll-margin 3可以在靠近屏幕边沿3行时就开始滚动,可以很好的看到上下文
(setq scroll-margin 3
      scroll-conservatively 10000
      ;; enable-recursive-minibuffers t
      ring-bell-function 'ignore
      ;; Automatically add newlines in last of file. (Enhancing C-n)
      next-line-add-newlines t
      require-final-newline t)

;; 当你在shell、telnet、w3m等模式下时，必然碰到过要输入密码的情况,此时加密显出你的密码
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

;; 可以保存你上次光标所在的位置
(save-place-mode t)

;; 光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线。
(mouse-avoidance-mode 'animate)

;; kill ring settings
(setq kill-do-not-save-duplicates t
      kill-ring-max 200
      ;; format then auto complete
      tab-always-indent 'complete)


;; 缩进设置
;; 不用TAB字符来indent
;; TAB 宽度设置为4
(setq-default indent-tabs-mode nil)
(setq tab-width 4
      js-indent-level 2
      tab-stop-list nil)

(cl-loop for x downfrom 40 to 1 do
      (setq tab-stop-list (cons (* x tab-width) tab-stop-list)))

;; More generic highlight settings.
(require 'generic-x)

;; set basic cua-mode.
(setq cua-remap-control-z nil
      cua-remap-control-v nil)

;; Encoding settings
(when (not window-system)
  (set-language-environment "UTF-8"))

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq buffer-file-coding-system 'utf-8)

(autoload 'dockerfile-mode "dockerfile-mode" "" t)
(autoload 'json-mode "json-mode" "" t)
(autoload 'cmake-mode "cmake-mode" "" t)
(autoload 'adoc-mode "adoc-mode" "" t)

(add-to-list 'load-path (concat plugins-path-r "go-mode"))
(autoload 'go-mode "go-mode" "" t)
(add-to-list 'load-path (concat plugins-path-r "lua-mode"))
(autoload 'lua-mode "lua-mode" "" t)
(add-to-list 'load-path (concat plugins-path-r "typescript-mode"))
(autoload 'typescript-mode "typescript-mode" "" t)

(add-to-list 'load-path (concat plugins-path-r "csharp-mode"))
(autoload 'csharp-mode "csharp-mode" "" t)

;; modes definition.
(setq auto-mode-alist
      (append
       ;; programming language
       '(("\\.[Cc][Xx][Xx]$"  . c++-mode)
         ("\\.[Cc][Pp][Pp]$"  . c++-mode)
         ("\\.[Hh][Xx][Xx]$"  . c++-mode)
         ("\\.[Tt][Cc][Cc]$"  . c++-mode)
         ("\\.h$"             . c++-mode)
         ("\\.i$"             . c++-mode)    ; SWIG
         ("\\.cs$"            . csharp-mode)
         ("\\.el\\.gz$"       . emacs-lisp-mode)
         ("\\.go\\'"          . go-mode)
         ("_emacs"            . lisp-mode)
         ("\\.lua$"           . lua-mode)
         ("\\.m$"             . objc-mode)
         ("\\.mm$"            . objc-mode)
         ("\\.scons$"         . python-mode)
         ("\\.gclient$"       . python-mode)
         ("Podfile\\'"        . ruby-mode)
         ("\\.podspec\\'"     . ruby-mode)
         ("\\.rb$"            . ruby-mode)
         ("\\.ts$"            . typescript-mode)

         ;; config
         ("CMakeLists\\.txt\\'"    . cmake-mode)
         ("\\.cmake\\'"            . cmake-mode)
         ("\\.conf$"               . conf-mode)
         ("Dockerfile\\'"          . dockerfile-mode)
         ("\\.mak$"                . makefile-mode)
         ("Doxyfile.tmpl$"         . makefile-mode)
         ("Doxyfile$"              . makefile-mode)
         ("\\.[Yy][Aa]?[Mm][Ll]$"  . yaml-mode)

         ;; text
         ("\\.asciidoc$"      . adoc-mode)
         ("\\.txt$"           . adoc-mode)
         ("\\.uncompressed$"  . hexl-mode)
         ("\\.json$"          . json-mode)
         ("\\.org$"           . org-mode)
         ("\\.\\(todo\\|do\\|plan\\)$". org-mode)
         ("\\.cml$"           . xml-mode)
         ) auto-mode-alist))

;; markdown-settings
(use-package markdown-mode
  :mode
  ("\\.markdown\\'"  . markdown-mode)
  ("\\.md\\'"        . markdown-mode)
  ("\\.text\\'"      . markdown-mode))

;; learning from dadams
(eval-after-load "ring"
  '(progn (require 'ring+)))

(when (string= system-type "darwin")
;;; ENV path correction for (Mac os x)
  (dolist (ensure-path '("/usr/bin"
                         "/bin"
                         "/usr/sbin"
                         "/sbin"
                         "/usr/local/share/python"
                         "/usr/local/bin"))
    (unless (member ensure-path exec-path)
      (add-to-list 'exec-path ensure-path)))
  (setenv "PATH" (mapconcat 'identity exec-path ":"))
  (setenv "LC_ALL" "en_US.UTF-8")
  (setenv "LC_CTYPE" "en_US.UTF-8"))


(provide 'default-behavior-settings)
;; default-behavior-settings ends here.
;;;
