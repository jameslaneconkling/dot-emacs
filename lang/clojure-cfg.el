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


;; key bindings
;; these help me out with the way I usually develop web apps
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

(eval-after-load 'cider
  '(progn
     (define-key clojure-mode-map (kbd "C-c C-v") 'cider-start-http-server)
     (define-key clojure-mode-map (kbd "C-M-r") 'cider-refresh)
     (define-key clojure-mode-map (kbd "C-c u") 'cider-user-ns)
     (define-key cider-mode-map (kbd "C-c u") 'cider-user-ns)

     (define-key cider-mode-map (kbd "C-, '") 'cider-jack-in)
     (define-key cider-mode-map (kbd "C-, e e") 'cider-eval-last-sexp)
     (define-key cider-mode-map (kbd "C-, e b") 'cider-eval-buffer)
     (define-key cider-mode-map (kbd "C-, e c") 'cider-pprint-eval-last-sexp-to-comment)
     (define-key cider-mode-map (kbd "C-, e r") 'cider-eval-last-sexp-and-replace)
     ;; TODO - send current namespace to repl
     (define-key cider-mode-map (kbd "C-, i") 'cider-inspect-last-result)))

;; TODO easy bindings for cider
;; * view docs for var: `, h h`
;; * jump to definition/in new window: `, gg`/`, gG`
;; * debug [instrument function]: `, d b`
;; * enlighten: `, T e`
;; * prev command: `M-p`
;; * keybindings: `C-h m`
;; * cider repl kill command: `C-c C-c`
;; * compile file: `C-c C-k`
