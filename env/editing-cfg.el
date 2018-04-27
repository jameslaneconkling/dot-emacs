
;;;;;;;;;;;;;
;; editing ;;
;;;;;;;;;;;;;

;; better commenting: https://stackoverflow.com/questions/9688748/emacs-comment-uncomment-current-line
(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
      (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)
    (next-line)))

;; save backup and autosave files to ~/.emacs-backups
(setq backup-directory-alist `(("." . "~/.emacs-backups")))
;; (setq auto-save-file-name-transforms `(("." . "~/.emacs-autosave")))

;; key bindings
(general-define-key
 :states '(normal visual insert emacs)
 :prefix "SPC"
 :non-normal-prefix "M-SPC"
 "/" '(comment-or-uncomment-region-or-line :which-key "comment")
 "=" '(er/expand-region :which-key "expand region")
 "e" '(:ignore t :which-key "errors")
 "e l" '(flycheck-list-errors :which-key "list errors")
 "e n" '(flycheck-next-error :which-key "next error")
 "e N" '(flycheck-previous-error :which-key "previous error")

 "y" '(helm-show-kill-ring :which-key "kill-ring"))

;; overwrite highlighted text
(delete-selection-mode 1)
(fset 'evil-visual-update-x-selection 'ignore)


;; expand region
(use-package expand-region :ensure t)

;; pair completion
(electric-pair-mode 1)
(setq electric-pair-pairs '((?\" . ?\")(?\{ . ?\}))) ;; include {} and "" as pairs

;; tabbing
(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(setq-default js-indent-level 2)

;; autocomplete
(use-package auto-complete :ensure t)
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.c/ac-dict")
(ac-config-default)

;; regexp-builder tweaks
(use-package re-builder :ensure t)
(require 're-builder)
(setq reb-re-syntax 'string)

;; rainbow-mode for highlighting hexidecimal/rgb color strings with their color.
(use-package rainbow-mode :ensure t)
(add-hook 'js-mode-hook (lambda () (rainbow-mode 1)))
(add-hook 'web-mode-hook (lambda () (rainbow-mode 1)))
(add-hook 'css-mode-hook (lambda () (rainbow-mode 1)))
