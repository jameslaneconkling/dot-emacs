
;; ~/.emacs.d/personal/lang/javascript-cfg.el

;;;;;;;;;;;;;;;;
;; javascript ;;
;;;;;;;;;;;;;;;;

(general-evil-setup)
(general-define-key
 :keymaps '(js-mode-map web-mode-map)
 :states '(normal visual insert emacs)
 :prefix ","
 :non-normal-prefix "M-,"
 "d" '(kill-sexp :which-key "delete sexp")
 "y" '(sp-copy-sexp :which-key "yank sexp")

 "s" '(paredit-forward-slurp-sexp :which-key "slurp")
 "S" '(paredit-backward-slurp-sexp :which-key "backward slurp")
 "b" '(paredit-forward-barf-sexp :which-key "barf")
 "B" '(paredit-backward-barf-sexp :which-key "backward barf")
 "w" '(paredit-wrap-sexp :which-key "wrap")
 "t" '(sp-transpose-sexp :which-key "transpose")

 "'" '(indium-run-node :which-key "jack in")
 "r" '(indium-restart-node :which-key "repl")
 "e" '(:ignore t :which-key "eval")
 "e b" '(indium-eval-buffer :which-key "eval buffer")
 "e r" '(indium-eval-region :which-key "eval region")
 "e e" '(indium-eval-last-node :which-key "eval prev exp")
 "e d" '(indium-eval-defun :which-key "eval definition")

 ;; TODO - only bind for json-mode
 "f" '(:ignore t :which-key "format json")
 "f r" '(json-pretty-print :which-key "format region")
 "f b" '(json-pretty-print-buffer :which-key "format buffer") "m" '(:ignore t :which-key "html markup")

 "m r" '(web-mode-element-rename :which-key "rename")
 "m d" '(web-mode-element-kill :which-key "delete")
 "m w" '(web-mode-element-wrap :which-key "wrap")
 "m l" '(web-mode-element-sibling-next :which-key "next element")
 "m h" '(web-mode-element-sibling-previous :which-key "previous element")
 "m k" '(web-mode-element-parent :which-key "parent element")
 "m j" '(web-mode-element-child :which-key "child element")
 )

(use-package js2-mode
  :ensure t
  :mode ("\\.[j|t]s$" . js2-mode)
  :config
  (setq js-indent-level 2
	js2-basic-offset 2
	js2-bounce-indent-p t
        js2-mode-show-parse-errors nil
        js2-mode-show-strict-warnings nil)
  (add-hook 'js2-mode-hook #'js2-imenu-extras-mode)
  (add-hook 'js2-mode-hook #'company-mode)
  (define-key js-mode-map (kbd "M-.") nil))


(use-package web-mode
  :ensure t
  :mode ("\\.[j|t]sx$" . web-mode)
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-enable-auto-quoting nil
        web-mode-enable-auto-indentation t)
  (add-to-list 'web-mode-indentation-params '("lineup-ternary" . nil))
  ;; (add-to-list 'auto-mode-alist '("\\.jsx$\\'" . web-mode))
  )


(use-package json-mode
  :ensure t
  :mode ("\\.json$" . json-mode))
(use-package json-reformat :ensure t)
(setq json-reformat:indent-width 2)


(setq web-mode-enable-current-element-highlight t)
(setq web-mode-enable-current-column-highlight t)
(eval-after-load "web-mode"
  '(set-face-background 'web-mode-current-element-highlight-face "#402D2E"))
(eval-after-load "web-mode"
  '(set-face-foreground 'web-mode-current-element-highlight-face "#CC6666"))


(use-package xref-js2
  :ensure t
  :init
  (add-hook 'js2-mode-hook (lambda ()
                             (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))
  :config
  (define-key js2-mode-map (kbd "M-.") nil))


(setq css-indent-offset 2)

;; skewer repl
;; (use-package skewer-mode :ensure t)
;; (add-hook 'js2-mode-hook 'skewer-mode)
;; (add-hook 'css-mode-hook 'skewer-css-mode)
;; (add-hook 'html-mode-hook 'skewer-html-mode)


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


(use-package indium
  :ensure t
  :config
  (add-hook 'js-mode-hook #'indium-interaction-mode))

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
