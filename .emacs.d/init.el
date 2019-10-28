;;; init --- Main init file
;;; Commentary:
;;; This is my init file

;;; Code:
(setq gc-cons-threshold (* 50 1024 1024))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path (concat user-emacs-directory "elisp"))

(require 'package-init)
(require 'base)
(require 'base-theme)
(require 'base-extensions)
(require 'base-functions)
(require 'base-global-keys)
(require 'hooks)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#002b36" :foreground "#839496" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "SRC" :family "Hack"))))
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 2.0)))))

(setq gc-cons-threshold (* 2 1024 1024))
(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (wgrep clojure-mode-extra-font-locking clojure-mode yasnippet-snippets yaml-mode use-package undo-tree tabbar solarized-theme rainbow-delimiters projectile pdf-tools lsp-ui groovy-mode go-mode git-gutter forge flycheck-yamllint dockerfile-mode diminish counsel company-lsp anzu ace-window))))
