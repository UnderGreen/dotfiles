;;; base.el --- Basic configuration

;;; Commentary:
;;; Configuration of common options

;;; Code:

;;; Locale config
(defun pl-set-locale (locale)
  "Set locale to LOCALE."
  (interactive)
  (set-charset-priority 'unicode)
  (setq locale-coding-system locale)
  (set-language-environment locale)
  (set-terminal-coding-system locale)
  (set-default-coding-systems locale)
  (set-selection-coding-system locale)
  (prefer-coding-system locale))

(pl-set-locale 'utf-8)

;;; Disable toolbar, tooltips and menubar
(mapc (lambda (mode) (funcall mode -1))
      '(menu-bar-mode
        scroll-bar-mode
        tool-bar-mode
        tooltip-mode))


;;; Useful defaults
(setq confirm-kill-emacs 'y-or-n-p) ; Confirm to close emacs
(setq-default cursor-type 'box)   ; Line-style cursor similar to other text editors
(setq inhibit-startup-screen t)   ; Disable startup screen
(setq initial-scratch-message (format ";; Scratch - Started on %s\n\n" (current-time-string))) ; Make scratch screen show when emacs started
(setq-default frame-title-format '("Emacs - %b")) ; Make window title the buffer name
(setq ring-bell-function 'ignore) ; Disable bell sound
(fset 'yes-or-no-p 'y-or-n-p)     ; y-or-n-p makes answering questions faster
(setq select-enable-clipboard t)  ; Allow usage of system clipboard
(setq visible-bell t)             ; Blink screen instead of audio bell
(setq debug-on-error t)           ; Show debug output on error
(setq load-prefer-newer t)        ; Load whichever version of the file is newest(.el or .elc)
(setq user-full-name "Sergei Antipov")
(setq user-mail-address "greendayonfire@gmail.com")
(setq case-fold-search t)         ; Case insensitive search
(setq kill-whole-line t)          ; C-k at the beginning of a line kills the entire line including the following newline
(setq require-final-newline t)    ; Put a newline at the end if there isn’t already one there
(setq backup-inhibited t
      make-backup-files nil)      ; Disable backups
(setq auto-save-default nil
      auto-save-list-file-prefix nil) ; Disable autosaving
(setq vc-follow-symlinks t)       ; Automatically follow symlinks in VCS
(setq-default show-trailing-whitespace t) ; Show trailing whitespaces
(setq-default whitespace-line-column 120) ; Whitespace lines longer than 120 columns
(setq-default whitespace-style '(tabs tab-mark face lines-tail)) ; Sets what to whitespace
(setq-default electric-pair-preserve-balance 1) ; Enable autopairing delimeters
(setq uniquify-buffer-name-style 'forward uniquify-separator "/") ; Style for multiple buffers with the same name
(setq-default tab-width 4
              indent-tabs-mode nil) ; Tabs configuration

(defalias 'list-buffers 'ibuffer) ; make ibuffer default

(mapc (lambda (mode) (funcall mode 1))
      '(auto-compression-mode     ; Automatically uncompresses compressed files when you visit them
        column-number-mode        ; Current column number of point appears in the mode line
        global-auto-revert-mode   ; Reverts the current buffer when its visited file changes on disk
        line-number-mode          ; Current line number of point appears in the mode line
        show-paren-mode           ; Show matching delimeter
        subword-mode              ; Recognize upper case letters in 'CamelCase' as word boundaries
        which-function-mode       ; Display the current function name in the mode line
        electric-pair-mode        ; Enable autopairing delimeters
        delete-selection-mode     ; Delete selected text while typing
        global-font-lock-mode     ; Enable pretty syntax highlighting everywhere
        auto-fill-mode            ; Wrap lines automatically
        transient-mark-mode       ; Enable transient mark mode
      ))

;;; Update exec-path and PATH variables
(add-to-list 'exec-path "/usr/local/go/bin")
(add-to-list 'exec-path "/home/greenday/go/bin")

(setenv "GOPATH" "/home/greenday/go")
(setenv "PATH" (concat "/usr/local/go/bin:" "/home/greenday/go/bin:" (getenv "PATH")))

;;; Recent files configuration
(require 'recentf)
(recentf-mode t)
(setq recentf-auto-cleanup 'never
      recentf-max-menu-items 50
      ;; recentf-keep '(file-remote-p file-readable-p)
      )

;;; TRAMP related configuration
(require 'tramp)
(setq password-cache-expiry nil)  ; Disable expiration of passwords
(setq tramp-default-method "ssh") ; Set default connection method to ssh
(tramp-set-completion-function "ssh"
                               '((tramp-parse-sconfig "/etc/ssh_config")
                                 (tramp-parse-sconfig "~/.ssh/config")))

;;; Filetypes match table
(add-to-list 'auto-mode-alist '("\\.scss]\\'"       . css-mode))
(add-to-list 'auto-mode-alist '("\\.js[on]\\'"      . js2-mode))
(add-to-list 'auto-mode-alist '("\\.asd\\'"         . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.cl\\'"          . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.lisp\\'"        . lisp-mode))
(add-to-list 'auto-mode-alist '("Dockerfile"        . dockerfile-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile"       . ruby-mode))
(add-to-list 'auto-mode-alist '(".bashrc"           . shell-script-mode))
(add-to-list 'auto-mode-alist '(".zshrc"            . shell-script-mode))
(add-to-list 'auto-mode-alist '(".gnus"             . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.ya?ml\\'"       . yaml-mode))
(add-to-list 'auto-mode-alist '(".yamllint\\'"      . yaml-mode))

(provide 'base)
;;; base.el ends here
