
;; ~/.emacs.d/personal/program/magit-cfg.el

;;;;;;;;;;;
;; magit ;;
;;;;;;;;;;;

(use-package magit :ensure t)
(use-package magit-gh-pulls :ensure t)
(require 'magit-gh-pulls)
(add-hook 'magit-mode-hook 'turn-on-magit-gh-pulls)


(use-package git-gutter-fringe
  :ensure t)
(use-package git-gutter
  :ensure t
  :config
  (require 'git-gutter-fringe)
  (global-git-gutter-mode +1)
  ;; places the git gutter outside the margins.
    (setq-default fringes-outside-margins t)
    ;; thin fringe bitmaps
    (fringe-helper-define 'git-gutter-fr:added '(center repeated)
      "XXX.....")
    (fringe-helper-define 'git-gutter-fr:modified '(center repeated)
      "XXX.....")
    (fringe-helper-define 'git-gutter-fr:deleted 'bottom
      "X......."
      "XX......"
      "XXX....."
      "XXXX....")

  (add-hook 'focus-in-hook 'git-gutter:update-all-windows))


(setq auto-mode-alist (delete '("git-rebase-todo" . rebase-mode)
                              auto-mode-alist))
