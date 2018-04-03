;; ~/.emacs.d/personal/config.el

;;;;;;;;;
;; env ;;
;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/personal/env")
;; (load "kbd-cfg.el")
(load "package-cfg.el")
(load "editing-cfg.el")
;; (load "navigation-cfg.el")
(load "ui-cfg.el")
(load "on-start-cfg.el")


;;;;;;;;;;;
;; langs ;;
;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/personal/lang")
(load "clojure-cfg.el")
