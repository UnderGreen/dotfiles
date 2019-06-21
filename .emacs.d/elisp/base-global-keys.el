;;; global-set-key.el --- Define global keybindings
;;; Commentary:
;;; Configuration of global keybindings

;;; Code:
;(global-set-key (kbd "[SHORTCUT]") '[FUNCTION])
(global-set-key (kbd "\M-*") 'pop-tag-mark) ; Pop back to where \[xref-find-definitions] was last invoked.

(provide 'base-global-keys)
;;; base-global-keys.el ends here
