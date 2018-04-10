
;; ~/.emacs.d/personal/lang/javascript-cfg.el

;;;;;;;;;;;;;;;;
;; javascript ;;
;;;;;;;;;;;;;;;;

(general-evil-setup)
(general-define-key
 :keymaps 'js-mode-map
 :states '(normal visual insert emacs)
 :prefix ","
 :non-normal-prefix "M-,"
 "d" '(js2r-kill :which-key "delete")
 "s" '(js2r-forward-slurp :which-key "slurp")
 "b" '(js2r-forward-barf :which-key "barf")
 "w" '(paredit-wrap-sexp :which-key "wrap")
 "f" '(:ignore t :which-key "format")
 "f j" '(:ignore t :which-key "format json")
 "f j r" '(json-pretty-print :which-key "format region")
 "f j b" '(json-pretty-print-buffer :which-key "format buffer")

 "'" '(run-skewer :which-key "jack in")
 "r" '(skewer-repl :which-key "repl")
 "e" '(:ignore t :which-key "eval")
 "e b" '(skewer-load-buffer :which-key "eval buffer")
 "e e" '(skewer-eval-last-expression :which-key "eval last exp")
 "e d" '(skewer-eval-defun :which-key "eval last definition")
 "e p" '(skewer-eval-print-last-expression :which-key "eval last exp and print")
 )


(use-package js2-mode
  :ensure t
  :mode ("\\.js$" . js2-mode)
  :config
  (setq js-indent-level 2
	js2-basic-offset 2
	js2-bounce-indent-p t
        js2-mode-show-parse-errors nil
        js2-mode-show-strict-warnings nil)
  (add-hook 'js2-mode-hook #'js2-imenu-extras-mode)
  (add-hook 'js2-mode-hook #'company-mode)
  (define-key js-mode-map (kbd "M-.") nil))

(use-package rjsx-mode
  :ensure t
  :mode ("\\.jsx$\\'" . rjsx-mode))

(use-package xref-js2
  :ensure t
  :init
  (add-hook 'js2-mode-hook (lambda ()
                             (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))
  :config
  (define-key js2-mode-map (kbd "M-.") nil))

(use-package json-reformat :ensure t)
(setq json-reformat:indent-width 2)

;; fix jsx indentation
(defun js-jsx-indent-line-align-closing-bracket ()
  "Workaround 'sgml-mode' and align closing bracket with opening bracket."
  (save-excursion
    (beginning-of-line)
    (when (looking-at-p "^ +\/?> *$")
      (delete-char sgml-basic-offset))))
(advice-add #'js-jsx-indent-line :after #'js-jsx-indent-line-align-closing-bracket)

(setq css-indent-offset 2)

;; skewer repl
(use-package skewer-mode :ensure t)
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)


;; (use-package tern
;;   :ensure t
;;   :init (add-hook 'js2-mode-hook #'tern-mode)
;;   :config
;;   (advice-add #'tern-project-dir :override #'core*project-root))

;; (use-package company-tern
;;   :ensure t
;;   :config
;;   (defun activate-tern-hook ()
;;     "Hook for `js-mode'."
;;     (set (make-local-variable 'company-backends)
;; 	 '((company-tern company-files))))
;;   (add-hook 'js2-mode-hook 'activate-tern-hook))

;; Turn off js2 mode errors & warnings
(setq js2-mode-show-parse-errors nil)
(setq js2-mode-show-strict-warnings nil)


(use-package js2-refactor
  :ensure t
  :config
  (add-hook 'js2-mode-hook #'js2-refactor-mode)
  (js2r-add-keybindings-with-prefix "C-c C-r")
  ;; js-mode (which js2 is based on) binds "M-." which conflicts with xref, so
  ;; unbind it.
  (define-key js-mode-map (kbd "M-.") nil)
  (define-key js2-mode-map (kbd "C-k") #'js2r-kill))


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
