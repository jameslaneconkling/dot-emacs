
;; ~/.emacs.d/personal/env/ui-cfg.el

;;;;;;;;
;; ui ;;
;;;;;;;;

(setq inhibit-startup-screen t
 ;; makes killing/yanking interact with the clipboard
      x-select-enable-clipboard t

      ;; I'm actually not sure what this does but it's recommended?
      x-select-enable-primary t

      ;; Save clipboard strings into kill ring before replacing them.
      ;; When one selects something in another program to paste it into Emacs,
      ;; but kills something in Emacs before actually pasting it,
      ;; this selection is gone unless this variable is non-nil
      save-interprogram-paste-before-kill t

      ;; Shows all options when running apropos. For more info,
      ;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Apropos.html
      ;; apropos-do-all t

      ;; Mouse yank commands yank at point instead of at click.
      mouse-yank-at-point t
      ;; no bell
      ring-bell-function 'ignore)

;; (set-face-attribute 'default nil :font "M+ 1mn")
(set-frame-font "M+ 1mn 11" nil t)


;; powerline
(use-package powerline :ensure t)
(powerline-default-theme)


;; transpose-windows
;; (use-package transpose-frame :ensure t)
;; (require 'transpose-frame)

;; turn off line wrapping
;; (set-default 'truncate-lines t)

;; turn on line numbers
;; (global-linum-mode)

;; ;; Don't show native OS scroll bars for buffers because they're redundant
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; (if (fboundp 'fringe-mode)
;;     (fringe-mode '(10 . 0)))
(when (display-graphic-p)
  ;; standardize fringe width
  (push (cons 'left-fringe  '10) default-frame-alist)
  (push (cons 'right-fringe '0) default-frame-alist)
  ;; no fringe in the minibuffer
  (set-window-fringes (minibuffer-window) 0 0 nil))

(setq-default fringes-outside-margins t)

;; `window-divider-mode' gives us finer control over the border between windows.
;; The native border "consumes" a pixel of the fringe on righter-most splits (in
;; Yamamoto's emacs-mac at least), window-divider does not. You can also control
;; vertical borders between windows (introduced in Emacs 25.1+)
(when (boundp 'window-divider-mode)
  (setq window-divider-default-places t
        window-divider-default-bottom-width 1
        window-divider-default-right-width 1)
  (window-divider-mode +1))



;; THEMES
(use-package doom-themes :ensure t)
;; (load-theme 'zenburn t)
;; (load-theme 'doom-one t)
(load-theme 'doom-tomorrow-night t)
;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled
;; ;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)
;; ;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

(use-package solaire-mode
  :ensure t
  :config
  ;; brighten buffers (that represent real files)
  (add-hook 'after-change-major-mode-hook #'turn-on-solaire-mode)
  ;; To enable solaire-mode unconditionally for certain modes:
  (add-hook 'ediff-prepare-buffer-hook #'solaire-mode)

  ;; ...if you use auto-revert-mode:
  (add-hook 'after-revert-hook #'turn-on-solaire-mode)

  ;; highlight the minibuffer when it is activated:
  (add-hook 'minibuffer-setup-hook #'solaire-mode-in-minibuffer)

  ;; if the bright and dark background colors are the wrong way around, use this
  ;; to switch the backgrounds of the `default` and `solaire-default-face` faces.
  ;; This should be used *after* you load the active theme!
  ;;
  ;; NOTE: This is necessary for themes in the doom-themes package!
  (solaire-mode-swap-bg))
