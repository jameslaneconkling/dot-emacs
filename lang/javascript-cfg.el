
;; ~/.emacs.d/personal/lang/javascript-cfg.el

;;;;;;;;;;;;;;;;
;; javascript ;;
;;;;;;;;;;;;;;;;

;; (use-package indium :ensure t)

;; tern
;; (use-package tern :ensure t)
;; (use-package tern-auto-complete :ensure t)
;; (use-package company-tern :ensure t)

;; (add-hook 'js-mode-hook (lambda () (tern-mode t)))
;; (add-hook 'web-mode-hook (lambda () (tern-mode t)))

;; (eval-after-load 'tern
;;   '(progn
;;      (require 'tern-auto-complete)
;;      (tern-ac-setup)))

;; (defun delete-tern-process ()
;;   (interactive)
;;   (delete-process "Tern"))
