;;;;;;;;;;;;;
;; editing ;;
;;;;;;;;;;;;;

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

;; syntax-checking
;; (require 'flycheck)
;; (add-hook 'after-init-hook #'global-flycheck-mode)
;; set warning color
;; (cw|2.5.2017) actually this is p distracting, maybe softer
;; colors in the future...
;; (set-face-attribute 'flycheck-warning nil
;;                     :foreground "yellow"
;;                     :background "red")

;; regexp-builder tweaks
(use-package re-builder :ensure t)
(require 're-builder)
(setq reb-re-syntax 'string)

;; rainbow-mode for highlighting hexidecimal/rgb color strings with their color.
(use-package rainbow-mode :ensure t)
(add-hook 'js-mode-hook (lambda () (rainbow-mode 1)))
(add-hook 'web-mode-hook (lambda () (rainbow-mode 1)))
(add-hook 'css-mode-hook (lambda () (rainbow-mode 1)))

;; tern
;; for javascript development (move to javascript-cfg.el?)
(use-package tern :ensure t)
(use-package tern-auto-complete :ensure t)
(use-package company-tern :ensure t)

(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(add-hook 'web-mode-hook (lambda () (tern-mode t)))

(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))

(defun delete-tern-process ()
  (interactive)
  (delete-process "Tern"))
