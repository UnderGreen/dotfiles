;;; hooks.el --- Collection of hooks

;;; Commentary:
;;; Collection of hooks

;;; Code:

(defun hook-before-save ()
  "Hook before save."
  (time-stamp)
  (delete-trailing-whitespace)
  (whitespace-cleanup))
(add-hook 'before-save-hook #'hook-before-save)

(defun format-buffer-before-save-go ()
  "Format buffer before save file."
  (add-hook 'before-save-hook 'lsp-format-buffer nil t))

(add-hook 'go-mode-hook #'lsp)
(add-hook 'go-mode-hook 'format-buffer-before-save-go)

(defun hook-minibuffer-setup ()
  "Hook for Minibuffer setup."
  (setq show-trailing-whitespace nil))
(add-hook 'minibuffer-setup-hook #'hook-minibuffer-setup)

(defun hook-prog-mode ()
  "Hook for Prog mode."
  (rainbow-delimiters-mode t)
  (set-face-underline 'font-lock-warning-face "#dc322f")
  (font-lock-add-keywords nil '(("\\<\\(FIXME\\|TODO\\|BUG\\)" 1 font-lock-warning-face t))))
(add-hook 'prog-mode-hook #'hook-prog-mode)

(defun hook-text-mode ()
  "Hook  for Text mode."
  (electric-indent-local-mode -1))
(add-hook 'text-mode-hook #'hook-text-mode)

(provide 'hooks)
;;; hooks.el ends here
