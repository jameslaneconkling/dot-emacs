
;; ~/.emacs.d/personal/program/magit-cfg.el

;;;;;;;;;;;
;; magit ;;
;;;;;;;;;;;

(use-package magit :ensure t)
(use-package magit-gh-pulls :ensure t)
(require 'magit-gh-pulls)
(add-hook 'magit-mode-hook 'turn-on-magit-gh-pulls)
(general-define-key
 :states '(normal visual insert emacs)
 :prefix "SPC"
 :non-normal-prefix "M-SPC"
 "g" '(:ignore t :which-key "git")
 "g s" '(magit-status :which-key "status")
 "g a" '(magit-stage :which-key "add")
 "g d" '(magit-diff :which-key "diff")
 "g c" '(magit-commit :which-key "commit")
 "g o" '(magit-checkout :which-key "checkout")
 "g l" '(magit-reflog-head :which-key "log")
 "g /" '(:ignore t :which-key "stash")
 "g / /" '(magit-stash :which-key "stash")
 "g / p" '(magit-stash-pop :which-key "pop")
 "g p" '(:ignore t :which-key "push/pull")
 "g p s" '(magit-push :which-key "push")
 "g p l" '(magit-pull :which-key "pull"))

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
