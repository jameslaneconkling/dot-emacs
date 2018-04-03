;;;;;;;;;;;;;;
;; packages ;;
;;;;;;;;;;;;;;

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives 
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))



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



;;;;;;;;
;; ui ;;
;;;;;;;;
(setq inhibit-startup-screen t)

;; (set-face-attribute 'default nil :font "M+ 1mn")
;; (set-frame-font "M+ 1mn" nil t)
(set-frame-font "M+ 1mn 12" nil t)

;; transpose-windows
;; (use-package transpose-frame :ensure t)
;; (require 'transpose-frame)

;; turn off line wrapping
;; (set-default 'truncate-lines t)

;; line numbering
(global-linum-mode)
(column-number-mode)
(if (fboundp 'fringe-mode)
    (fringe-mode 4))

;; Don't show native OS scroll bars for buffers because they're redundant
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(load-theme 'zenburn t)



;; packages loaded on start
(require 'evil)
(evil-mode t)
