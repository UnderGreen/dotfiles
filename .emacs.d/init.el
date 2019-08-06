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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(git-gutter:added-sign "+")
 '(git-gutter:deleted-sign "-")
 '(git-gutter:modified-sign "~")
 '(package-selected-packages
   (quote
    (ztree dictionary yasnippet-snippets groovy-mode go-eldoc flymake-go company-go yasnippet yaml-mode undo-tree tabbar counsel rainbow-delimiters projectile magit lsp-ui flycheck-yamllint flycheck dockerfile-mode diminish go-mode git-gutter company-lsp company anzu ace-window solarized-theme use-package))))
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
