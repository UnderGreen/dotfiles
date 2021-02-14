;; init.el --- Personal GNU Emacs configuration file.

;; Copyright (c) 2020 Sergei Antipov <greendayonfire@gmail.com>
;;
;; This file is free software: you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This file is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this file.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(require 'package)

(setq package-archives nil)
(package-initialize)
(require 'use-package)

;; Configure `use-package' prior to loading it.
(eval-and-compile
  (setq use-package-always-ensure nil)
  (setq use-package-always-defer nil)
  (setq use-package-always-demand nil)
  (setq use-package-expand-minimally t)
  (setq use-package-enable-imenu-support t)
  ;; The following is VERY IMPORTANT.  Write hooks using their real name
  ;; instead of a shorter version: after-init ==> `after-init-hook'.
  ;;
  ;; This is to empower help commands with their contextual awareness,
  ;; such as `describe-symbol'.
  (setq use-package-hook-name-suffix nil))

(setq vc-follow-symlinks 'ask)
(defconst *is-a-mac* (eq system-type 'darwin))

(defvar default-gc-cons-threshold (if (display-graphic-p) 16000000 1600000)
  "The default value to use for `gc-cons-threshold'.
If you experience freezing, decrease this.
If you experience stuttering, increase this.")

(defvar default-gc-cons-upper-limit (if (display-graphic-p) 400000000 100000000)
  "The temporary value for `gc-cons-threshold' to defer it.")

(use-package emacs
  :ensure nil
  :config
  (setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))
  (setq ring-bell-function 'ignore)
  (setq read-process-output-max (* 1024 1024))
  (setq gc-cons-threshold default-gc-cons-upper-limit
	gc-cons-percentage 0.5)
  (defalias 'yes-or-no-p 'y-or-n-p)
  (setq use-file-dialog nil)
  (setq use-dialog-box nil)
  (setq inhibit-startup-screen t)
  (setq auth-sources '("~/.authinfo.gpg"))
  (setq backup-directory-alist
        '(("." . "~/.emacs.d/backup/")))
  (setq backup-by-copying t)
  (setq version-control t)
  (setq delete-old-versions t)
  (setq kept-new-versions 6)
  (setq kept-old-versions 2)
  (setq create-lockfiles nil)
  (setq show-trailing-whitespace t)
  (setq visible-bell t)
  (delete-selection-mode 1)
  (column-number-mode t)
  (global-display-line-numbers-mode t)

  (when (fboundp 'electric-pair-mode)
    (add-hook 'after-init-hook 'electric-pair-mode))

  
  ;; Revert (update) buffers automatically when underlying files are changed externally.
  (global-auto-revert-mode t)
  (setq auto-revert-remote-files t)

  (setq confirm-kill-emacs 'y-or-n-p)      ; y and n instead of yes and no when quitting
  (setq read-process-output-max (* 1024 1024)) ; support larger blobs for LSP; 1mb
  
  ;; maximize emacs on Mac OS X
  (when *is-a-mac*
    (add-to-list 'default-frame-alist '(fullscreen . maximized)))

  (defun gd/disable-toolbars()
    (when (fboundp 'tool-bar-mode)
      (tool-bar-mode -1))
    (when (fboundp 'set-scroll-bar-mode)
      (set-scroll-bar-mode nil))
    (if *is-a-mac*
        (add-hook 'after-make-frame-functions
                  (lambda (frame)
                    (unless (display-graphic-p frame)
                      (set-frame-parameter frame 'menu-bar-lines 0))))
      (when (fboundp 'menu-bar-mode)
        (menu-bar-mode -1))))

  (defun gd/set-default-face()
      (interactive)
      (set-face-attribute 'default nil :font "Hack Nerd Font-12")
      (when *is-a-mac*
          (set-face-attribute 'default nil :font "Hack Nerd Font-18")))

  (if (daemonp)
    (add-hook 'after-make-frame-functions
                (lambda (frame)
                  (select-frame frame)
                  (gd/set-default-face))))

  (gd/set-default-face)
  (gd/disable-toolbars)

  (add-hook 'emacs-startup-hook
          (lambda ()
            "Restore default values after startup."
            (setq gc-cons-threshold default-gc-cons-threshold
                  gc-cons-percentage 0.1)

            ;; Avoid GCs while using `ivy'/`counsel'/`swiper' and `helm', etc.
            ;; @see http://bling.github.io/blog/2016/01/18/why-are-you-changing-gc-cons-threshold/
            (defun my-minibuffer-setup-hook ()
              (setq gc-cons-threshold default-gc-cons-upper-limit))

            (defun my-minibuffer-exit-hook ()
              (setq gc-cons-threshold default-gc-cons-threshold))

            (add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
            (add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)))

  ;; Disable line numbers for some modes
  (dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

  :hook (after-init-hook . electric-indent-mode)
  :bind (("<escape>" . keyboard-escape-quit)
	 ("C-c h b" . describe-personal-keybindings)))

(use-package cus-edit
  :config
  (setq custom-file "~/.emacs.d/custom.el")

  (unless (file-exists-p custom-file)
    (write-region "" nil custom-file))

  (load custom-file))

(use-package recentf
  :init
  (setq recentf-save-file "~/.emacs.d/recentf")
  (setq recentf-max-saved-items 200)
  (setq recentf-exclude '(".gz" ".xz" ".zip" "/elpa/" "/ssh:" "/sudo:"))

  :hook (after-init-hook . recentf-mode))

(use-package saveplace
  :config
  (setq save-place-file "~/.emacs.d/saveplace")
  (setq save-place-forget-unreadable-files t)
  (save-place-mode 1))

(use-package dracula-theme
  :ensure t
  :config
  :init
  (load-theme 'dracula))

(use-package all-the-icons)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package counsel
  :ensure t
  :diminish ivy-mode
  :config
  (setq ivy-use-virtual-buffers t)

  :bind (("M-x" . 'counsel-M-x)
         ("C-x C-f" . 'counsel-find-file)
         ("\C-s" . 'swiper)
         ("\C-r" . 'swiper)
	 :map ivy-minibuffer-map
         ("C-l" . ivy-alt-done)
	 :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :hook ((after-init-hook . ivy-mode)
         (ivy-occur-mode-hook . hl-line-mode)))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; projectile - project interaction library
(use-package projectile
  :ensure t
  :diminish projectile-mode
  :config
  (setq projectile-completion-system 'ivy)
  (setq projectile-track-known-projects-automatically nil)

  :hook (after-init-hook . projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package counsel-projectile
  :ensure t)

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode)
  (which-key-setup-minibuffer))

(use-package magit
  :ensure t
  :bind ("C-c g" . magit-status))

(use-package git-commit
  :after magit
  :config
  (setq git-commit-summary-max-length 50)
  (setq git-commit-known-pseudo-headers
        '("Signed-off-by"
          "Acked-by"
          "Modified-by"
          "Cc"
          "Suggested-by"
          "Reported-by"
          "Tested-by"
          "Reviewed-by"))
  (setq git-commit-style-convention-checks
        '(non-empty-second-line
          overlong-summary-line)))

(use-package forge
  :ensure t
  :after magit)

;; go-mode - mode for editing Go code
(use-package go-mode
  :ensure t
  :hook (go-mode-hook . lsp-go-install-save-hooks))

(use-package lsp-mode
  :ensure t
  :config
  (setq lsp-enable-indentation t)
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  (setq lsp-enable-snippet nil)
  (setq lsp-prefer-capf t)
  (setq lsp-enable-file-watchers nil)
  
  (lsp-register-client
    (make-lsp-client :new-connection (lsp-tramp-connection "gopls")
                     :major-modes '(go-mode)
                     :remote? t
                     :server-id 'gopls-remote))

  :hook ((go-mode-hook . lsp-deferred)
	 (lsp-mode-hook . (lambda ()
			    (let ((lsp-keymap-prefix "C-c l"))
                              (lsp-enable-which-key-integration)))))
  :commands lsp lsp-deferred)

(defun lsp-go-install-save-hooks ()
  "Run lsp functions after saving Go file."
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode-hook . rainbow-delimiters-mode))

;; Optional - provides fancier overlays.
(use-package lsp-ui
  :ensure t
  :requires lsp-mode flycheck
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-max-height 20)
  (setq lsp-ui-doc-position 'bottom))

;; Company mode is a standard completion package that works well with lsp-mode.
(use-package company
  :ensure t
  :diminish company-mode
  :config
  ;; Optionally enable completion-as-you-type behavior.
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)

  :hook (after-init-hook . global-company-mode))

;; flycheck configuration
(use-package flycheck
  :ensure t
  :config
  (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)
  :hook (prog-mode-hook . global-flycheck-mode))

(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package editorconfig
  :ensure t
  :diminish editorconfig-mode
  :config
  (editorconfig-mode 1))

;; interface to ripgrep utility
(use-package ripgrep
  :ensure t)

;; yaml-mode - Simple major mode to edit YAML file for emacs
(use-package yaml-mode
  :ensure t)

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package jenkinsfile-mode
  :ensure t)

(provide 'init)
;;; init.el ends here
