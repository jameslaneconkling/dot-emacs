
;; ~/.emacs.d/personal/program/evil-cfg.el

;;;;;;;;;;
;; evil ;;
;;;;;;;;;;

;; enter evil mode on start up
(require 'evil)
(evil-mode t)

;; don't override neotree keys
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
