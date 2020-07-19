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

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

;; Initialise the packages, avoiding a re-initialisation.
(unless (bound-and-true-p package--initialized)
  (setq package-enable-at-startup nil)
  (package-initialize))

;; Make sure `use-package' is available.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

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

(eval-when-compile
  (require 'use-package))

(setq vc-follow-symlinks 'ask)

(use-package emacs
  :config
  (setq frame-title-format '("%b"))
  (setq ring-bell-function 'ignore)
  (defalias 'yes-or-no-p 'y-or-n-p)

  (defun gd/setup-frame ()
    (interactive)
    (when (display-graphic-p) 
     (set-face-attribute 'default nil :font "Hack Nerd Font-14")))

  :hook ((kill-emacs-hook . package-quickstart-refresh)
	 (after-make-frame-functions . (lambda (frame)
					(select-frame frame)
					(gd/setup-frame)))))

(use-package diminish
  :ensure
  :after use-package)

(use-package cus-edit
  :config
  (setq custom-file "~/.emacs.d/custom.el")

  (unless (file-exists-p custom-file)
    (write-region "" nil custom-file))

  (load custom-file))

(use-package recentf
  :config
  (setq recentf-save-file "~/.emacs.d/recentf")
  (setq recentf-max-saved-items 200)
  (setq recentf-exclude '(".gz" ".xz" ".zip" "/elpa/" "/ssh:" "/sudo:"))

  :hook (after-init-hook . recentf-mode))

(use-package saveplace
  :config
  (setq save-place-file "~/.emacs.d/saveplace")
  (setq save-place-forget-unreadable-files t)
  (save-place-mode 1))

(use-package emacs
  :config
  (setq backup-directory-alist
        '(("." . "~/.emacs.d/backup/")))
  (setq backup-by-copying t)
  (setq version-control t)
  (setq delete-old-versions t)
  (setq kept-new-versions 6)
  (setq kept-old-versions 2)
  (setq create-lockfiles nil))

(use-package magit
  :ensure
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

;; go-mode - mode for editing Go code
(use-package go-mode
  :ensure t)

(use-package lsp-mode
  :ensure t
  :config
  (progn
    (setq lsp-prefer-flymake t) ;; t(flymake), nil(lsp-ui), or :none
    (setq lsp-enable-indentation t)
    (setq lsp-keymap-prefix "C-c l"))

  :hook ((go-mode-hook . 'lsp-deferred)
	 (before-save-hook . 'lsp-format-buffer))
  :commands lsp lsp-deferred)

;; projectile - project interaction library
(use-package projectile
  :ensure t
  :config
  (setq projectile-completion-system 'ivy)

  :bind-keymap
  ("C-c p" . projectile-command-map))

;; interface to ripgrep utility
(use-package ripgrep
  :ensure t)

;; yaml-mode - Simple major mode to edit YAML file for emacs
(use-package yaml-mode
  :ensure t)

(use-package counsel
  :ensure t
  :diminish
  :config
  (setq ivy-use-virtual-buffers t)

  :bind (("M-x" . 'counsel-M-x)
	 ("C-x C-f" . 'counsel-find-file)
	 ("\C-s" . 'swiper)
	 ("\C-r" . 'swiper))
  :hook ((after-init-hook . ivy-mode)
         (ivy-occur-mode-hook . hl-line-mode)))
;;; init.el ends here