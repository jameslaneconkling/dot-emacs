
;; ~/.emacs.d/personal/env/ui-cfg.el

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
