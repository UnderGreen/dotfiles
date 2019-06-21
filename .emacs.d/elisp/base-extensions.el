;;; base-extensions.el --- Extensions configuration

;;; Commentary:
;;; Collection of packages

;;; Code:

;; ace-window -- GNU Emacs package for selecting a window to switch to
(use-package ace-window
  :ensure t
  :init (progn
	  (global-set-key (kbd "M-o") 'ace-window)
          (global-set-key [remap other-window] 'ace-window)
          (custom-set-faces
           '(aw-leading-char-face
             ((t (:inherit ace-jump-face-foreground :height 2.0)))))))

;; anzu - displays current match and total matches information in the mode-line in various search modes
(use-package anzu
  :ensure t
  :config (progn
            (global-anzu-mode +1)
	    (global-set-key [remap query-replace] 'anzu-query-replace)
	    (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp))
  :diminish anzu-mode)

;; autoinsert - insert text after creating new buffer
(require 'autoinsert)
(auto-insert-mode t)
(auto-insert)

(setq auto-insert-alist
      '(((sh-mode . "Shell script") nil
         "#!/usr/bin/env bash\n"
         "# -*- mode: sh; -*-\n\n"
         "# File: " (file-name-nondirectory buffer-file-name) "\n"
         "# Copyright (C) " (substring (current-time-string) -4) " " (user-full-name) "\n"
         "# Description: " _ "\n\n"
         "# set -o xtrace\n"
         "set -o nounset\n"
         "set -o errexit\n"
         "set -o pipefail\n\n")
         ((org-mode . "Org mode") nil
         "#+AUTHOR: " (user-full-name) "\n"
         "#+DATE: " (current-time-string) "\n"
         "#+STARTUP: showall\n\n")
         ((go-mode . "Golang mode") nil
         "/*\n"
         "Copyright (C) " (substring (current-time-string) -4) " Gravitational, Inc.\n"
         "\n"
         "Licensed under the Apache License, Version 2.0 (the \"License\");\n"
         "you may not use this file except in compliance with the License.\n"
         "You may obtain a copy of the License at\n"
         "\n"
         "http://www.apache.org/licenses/LICENSE-2.0\n"
         "\n"
         "Unless required by applicable law or agreed to in writing, software\n"
         "distributed under the License is distributed on an \"AS IS\" BASIS,\n"
         "WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.\n"
         "See the License for the specific language governing permissions and\n"
         "limitations under the License.\n"
         "*/\n"
         "\n"
         "package ")))

;; avy - jumping to visible text using a char-based decision tree
(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char)
  :diminish ivy-mode)

;; company - Modular in-buffer completion framework
(use-package company
  :ensure t
  :init (setq company-minimum-prefix-length 2
	      company-idle-delay 0.5
	      company-tooltip-limit 10
	      company-tooltip-flip-when-above t)
  :diminish company-mode)

;; company-lsp - Company completion backend for lsp-mode
(use-package company-lsp
  :ensure t
  :commands company-lsp)

;; git-gutter - port of GitGutter which is a plugin of Sublime Text.
(use-package git-gutter
  :ensure t
  :config
  (progn
    (custom-set-variables
     '(git-gutter:modified-sign "~")
     '(git-gutter:added-sign "+")
     '(git-gutter:deleted-sign "-")))
  :diminish git-gutter-mode)

;; go-mode - mode for editing Go code
(use-package go-mode
  :ensure t)

;; diminish - hiding or abbreviation of the mode line displays (lighters) of minor-modes
(use-package diminish
  :ensure t)

;; dockerfile-mode - Major mode for editing Docker's Dockerfiles
(use-package dockerfile-mode
  :ensure t)

;; flycheck - moder on-the-fly syntax checker
(use-package flycheck
  :ensure t
  :config (global-flycheck-mode t)
  :diminish flycheck-mode)

;; flycheck-yamllint - Flycheck integration for YAMLLint
(use-package flycheck-yamllint
  :ensure t
  :defer t
  :init
  (progn
    (eval-after-load 'flycheck
      '(add-hook 'flycheck-mode-hook 'flycheck-yamllint-setup))))

;; lsp-mode - Language Server Protocol Support for Emacs
(use-package lsp-mode
  :ensure t
  :config
  (progn
    (setq lsp-prefer-flymake nil) ;; t(flymake), nil(lsp-ui), or :none
    (setq lsp-enable-indentation t))
  :commands lsp)

;; lsp-ui - contains all the higher level UI modules of lsp-mode, like flycheck support and code lenses
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

;; magit - interface to the version control system Git
(use-package magit
  :ensure t
  :bind ("C-c m" . magit-status))

;; markdown-mode - major mode for editing Markdown-formatted text
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; org - for keeping notes, maintaining TODO lists, planning projects, and authoring documents with a fast and effective plain-text system
(use-package org
  :ensure t)

;; projectile - project interaction library
(use-package projectile
  :ensure t
  :config
  (progn
    (projectile-mode 1)
    (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
    (setq projectile-completion-system 'ivy)))

;; rainbow-delimiters - highlights delimiters such as parentheses, brackets or braces according to their depth
(use-package rainbow-delimiters
  :ensure t)

;; swiper - Isearch with an overview. Oh, man!
(use-package counsel
  :ensure t)

(use-package swiper
  :ensure t
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (global-set-key "\C-s" 'swiper)
    (global-set-key "\C-r" 'swiper)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "<f6>") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> l") 'counsel-load-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)))

;; tabbar - minor mode that displays a tab bar at the top, similar to the idea of web browser’s tab
(use-package tabbar
  :ensure t
  :init (progn
          (tabbar-mode t)
          (setq tabbar-scroll-left-help-function nil
                tabbar-scroll-right-help-function nil
                tabbar-scroll-left-button (quote (("") ""))
                tabbar-scroll-right-button (quote (("") ""))
		tabbar-background-color "#073642")
	  (set-face-attribute 'tabbar-default nil
			      :background "#073642"
                              :foreground "#b58900"
                              :box '(:line-width 6 :color "#073642"))
          (set-face-attribute 'tabbar-unselected nil
                              :background "#073642"
                              :foreground "#b58900"
                              :box '(:line-width 6 :color "#073642"))
          (set-face-attribute 'tabbar-selected nil
                              :background "#002b36"
                              :box '(:line-width 6 :color "#002b36"))
          (set-face-attribute 'tabbar-modified nil
                              :background "#073642"
                              :foreground "#268bd2"
                              :box '(:line-width 6 :color "#073642"))
          (set-face-attribute 'tabbar-selected-modified nil
                              :background "#002b36"
                              :foreground "#268bd2"
                              :box '(:line-width 6 :color "#002b36"))
          (set-face-attribute 'tabbar-button nil
                              :box nil)
          (set-face-attribute 'tabbar-separator nil
			      :background "#657b83"
                              :box nil)))

;; undo-tree - Treat undo history as a tree
(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode
  :bind ("C-x u" . undo-tree-visualize)
  :config
  (global-undo-tree-mode t))

;; yaml-mode - Simple major mode to edit YAML file for emacs
(use-package yaml-mode
  :ensure t)

;; yasnippet - template system for Emacs
(use-package yasnippet
  :ensure t
  :config
  (progn
    (yas-global-mode 1))
  :diminish yas-minor-mode)

(provide 'base-extensions)
;;; base-extensions.el ends here
