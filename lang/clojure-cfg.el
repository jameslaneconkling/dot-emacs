;;; clojure-config.el --- clojure settings

;;; Commentary:

;; This file provides custom settings for working with clojure

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;
;; required packages ;;
;;;;;;;;;;;;;;;;;;;;;;;

(use-package aggressive-indent :ensure t) ;; indents as you type
(use-package clojure-mode :ensure t) ;; key bindings and code colorization for Clojure
(use-package clojure-mode-extra-font-locking :ensure t) ;; extra syntax highlighting for clojure
(use-package cider :ensure t) ;; integration with a Clojure REPL
(use-package paredit :ensure t) ;; for parens
(use-package rainbow-delimiters :ensure t)
(use-package smartparens :ensure t) ;; newer lib for parens

;;;;;;;;;;;;;
;; clojure ;;
;;;;;;;;;;;;;

;; handle parens nicely!
(add-hook 'clojure-mode-hook 'enable-paredit-mode)
(add-hook 'clojure-mode 'smartparens)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook 'aggressive-indent-mode)
(show-paren-mode 1)
(setq show-paren-delay 0)
(set-face-background 'show-paren-match "#402D2E")
(set-face-foreground 'show-paren-match "#CC6666")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)


;; This is useful for working with camel-case tokens, like names of
;; Java classes (e.g. JavaClassName)
;; (add-hook 'clojure-mode-hook 'subword-mode)

;; A little more syntax highlighting
(require 'clojure-mode-extra-font-locking)

;; syntax hilighting for midje
;; (add-hook 'clojure-mode-hook
;;           (lambda ()
;;             (setq inferior-lisp-program "lein repl")
;;             (font-lock-add-keywords
;;              nil
;;              '(("(\\(facts?\\)"
;;                 (1 font-lock-keyword-face))
;;                ("(\\(background?\\)"
;;                 (1 font-lock-keyword-face))))
;;             (define-clojure-indent (fact 1))
;;             (define-clojure-indent (facts 1))))

;;;;;;;;;;;
;; Cider ;;
;;;;;;;;;;;

;; provides minibuffer documentation for the code you're typing into the repl
(add-hook 'cider-mode-hook 'eldoc-mode)

;; go right to the REPL buffer when it's finished connecting
(setq cider-repl-pop-to-buffer-on-connect t)

;; When there's a cider error, show its buffer and switch to it
(setq cider-show-error-buffer t)
(setq cider-auto-select-error-buffer t)

;; Where to store the cider history.
(setq cider-repl-history-file "~/.emacs.d/cider-history")

;; Wrap when navigating history.
(setq cider-repl-wrap-history t)

;; enable paredit in your REPL
(add-hook 'cider-repl-mode-hook 'paredit-mode)

;; Use clojure mode for other extensions
(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojure-mode))
(add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))


(defun cider-start-http-server ()
  (interactive)
  (cider-load-current-buffer)
  (let ((ns (cider-current-ns)))
    (cider-repl-set-ns ns)
    (cider-interactive-eval (format "(println '(def server (%s/start))) (println 'server)" ns))
    (cider-interactive-eval (format "(def server (%s/start)) (println server)" ns))))


(defun cider-refresh ()
  (interactive)
  (cider-interactive-eval (format "(user/reset)")))

(defun cider-user-ns ()
  (interactive)
  (cider-repl-set-ns "user"))

(setq cider-repl-pop-to-buffer-on-connect nil)

 
(general-evil-setup)
;; TODO - this overwrites J (combine lines)
(general-nvmap
 :keymaps '(clojure-mode-map emacs-lisp-mode-map)
 "C-l" 'sp-forward-sexp
 "C-h" '(sp-backward-sexp :which-key "backward sexp")
 "C-k" '(sp-backward-up-sexp :which-key "up sexp")
 "C-j" '(sp-down-sexp :which-key "down sexp"))


;; TODO easy bindings for cider
;; * view docs for var: `, h h`
;; * jump to definition/in new window: `, gg`/`, gG`
;; * debug [instrument function]: `, d b`
;; * enlighten: `, T e`
;; * prev command: `M-p`
;; * keybindings: `C-h m`
;; * cider repl kill command: `C-c C-c`
;; * compile file: `C-c C-k`
(general-define-key
 :keymaps '(clojure-mode-map emacs-lisp-mode-map)
 :states '(normal visual insert emacs)
 :prefix ","
 :non-normal-prefix "M-,"
 ;; TODO - command for docs (aprops?)
 "d" '(kill-sexp :which-key "delete sexp")
 "y" '(sp-copy-sexp :which-key "yank sexp")

 ;; "l" '(sp-forward-sexp :which-key "forward sexp")
 ;; "h" '(sp-backward-sexp :which-key "backward sexp")
 ;; "k" '(sp-backward-up-sexp :which-key "up sexp")
 ;; "j" '(sp-down-sexp :which-key "down sexp")

 "s" '(paredit-forward-slurp-sexp :which-key "slurp")
 "S" '(paredit-backward-slurp-sexp :which-key "backward slurp")
 "b" '(paredit-forward-barf-sexp :which-key "barf")
 "B" '(paredit-backward-barf-sexp :which-key "backward barf")
 "w" '(paredit-wrap-sexp :which-key "wrap")

 "'" '(cider-jack-in :which-key "cider jack in")
 "e" '(:ignore t :which-key "eval")
 "e b" '(cider-eval-buffer :which-key "eval buffer")
 "e e" '(cider-eval-last-sexp :which-key "eval last sexp")
 "e c" '(cider-pprint-eval-last-sexp-to-comment :which-key "eval last sexp to comment")
 "e r" '(cider-eval-last-sexp-and-replace :which-key "eval last sexp and replace")
 "r" '(cider-restart :which-key "cider restart")
 "i" '(cider-inspect-last-result :which-key "cider inspect last result")
 ;; TODO - send current namespace to repl
 "u" '(cider-user-ns :which-key "cider user namespace")
 "v" '(cider-start-http-server :which-key "start cider server"))
