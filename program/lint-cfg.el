
;; ~/.emacs.d/personal/program/lint-cfg.el

;;;;;;;;;;
;; lint ;;
;;;;;;;;;;

(use-package flycheck
  :ensure t
  :config
  (setq flycheck-indication-mode 'right-fringe
      ;; Removed checks on idle/change for snappiness
      flycheck-check-syntax-automatically '(save mode-enabled)
      flycheck-highlighting-mode 'symbols
      flycheck-disabled-checkers '(emacs-lisp emacs-lisp-checkdoc make)
      ;; `flycheck-pos-tip'
      flycheck-pos-tip-timeout 10
      flycheck-display-errors-delay 0.5)
  (when (eq window-system 'mac)
    (require 'flycheck-pos-tip)
    (flycheck-pos-tip-mode +1))

  (defun me/flycheck ()
    "Configurate flycheck."
    (add-to-list 'display-buffer-alist
                 `(,(rx bos "*Flycheck errors*" eos)
                   (display-buffer-reuse-window
                    display-buffer-in-side-window)
                   (side            . bottom)
                   (reusable-frames . visible)
                   (window-height   . 0.23)))
    (setq flycheck-display-errors-function
          #'flycheck-display-error-messages-unless-error-list))
  ;; Enable flycheck
  (add-hook 'prog-mode-hook 'me/flycheck)
  ;; (add-hook 'after-init-hook #'my/use-eslint-from-node-modules)
  (add-hook 'after-init-hook #'global-flycheck-mode))


;; allow flycheck to use locally installed eslint
(flycheck-add-mode 'javascript-eslint 'web-mode)

(use-package add-node-modules-path
  :ensure t
  :config
  (add-hook 'js-mode-hook #'add-node-modules-path)
  (add-hook 'js2-mode-hook #'add-node-modules-path)
  (add-hook 'web-mode-hook #'add-node-modules-path)
  (add-hook 'rjsx-mode-hook #'add-node-modules-path))
