
;; ~/.emacs.d/personal/env/nvaigation-cfg.el

;;;;;;;;;;;;;;;;
;; navigation ;;
;;;;;;;;;;;;;;;;

(general-define-key
 :states '(normal visual insert emacs)
 :prefix "SPC"
 :keymaps '(global dired-mode-map)
 :non-normal-prefix "M-SPC"
 "p" '(:ignore t :which-key "projectile")
 "p p" '(helm-projectile-switch-project :which-key "switch project")
 "p f" '(helm-projectile :which-key "open file in project")
 "p F" '(helm-projectile-find-file-in-known-projects :which-key "open file in any project")
 "p d b" '(projectile-kill-buffers :which-key "delete project buffers")
 "w" '(:ignore t :which-key "windows")
 "w h" '(evil-window-left :which-key "window left")
 "w l" '(evil-window-right :which-key "window right")
 "w k" '(evil-window-up :which-key "window up")
 "w j" '(evil-window-down :which-key "window down")
 "w d" '(evil-window-delete :which-key "delete window")
 "w =" '(balance-windows :which-key "balance windows")
 "w /" '(evil-window-vnew :which-key "new vertical window")
 "w -" '(evil-window-new :which-key "new horizontal window")
 "f" '(:ignore t :which-key "files")
 "f f" '(ido-find-file :which-key "list files")
 "f e" '(dired :which-key "edit files")
 "f d" '(delete-file :which-key "delete file")
 "s" '(:ignore t :which-key "search")
 "s s" '(helm-do-ag-project-root :which-key "search project")
 "s b" '(helm-do-ag-buffers :which-key "search project")
 "b" '(:ignore t :which-key "buffers")
 "b b" '(helm-buffers-list :which-key "list buffers")
 "b e" '(list-buffers :which-key "edit buffers")
 "b d" '(kill-this-buffer :which-key "delete buffer")
 "SPC" '(helm-M-x :which-key "M-x")
 ;; "." '(avy-goto-word-or-subword-1  :which-key "go to word")
  )

(general-define-key
 :states '(motion normal visual emacs)
 :keymaps '(global dired-mode-map)
 "<tab>" 'previous-buffer
 "<S-tab>" 'next-buffer)


;; helm
(use-package helm :ensure t)
(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t)


;; helm-ag
(use-package helm-ag :ensure t) ;; must make sure `ag` is installed
(setq helm-ag-insert-at-point 'word)


;; projectile
(use-package projectile :ensure t)
(use-package helm-projectile :ensure t)
(setq projectile-enable-caching t)
(setq helm-projectile-fuzzy-match t)
(projectile-global-mode)


;; Ido

;; ido-mode allows you to more easily navigate choices. For example,
;; when you want to switch buffers, ido presents you with a list
;; of buffers in the the mini-buffer. As you start to type a buffer's
;; name, ido will narrow down the list of buffers to match the text
;; you've typed in
;; http://www.emacswiki.org/emacs/InteractivelyDoThings

(use-package ido-completing-read+ :ensure t)
(ido-mode t)

;; This allows partial matches, e.g. "tl" will match "Tyrion Lannister"
(setq ido-enable-flex-matching t)

;; Turn this behavior off because it's annoying
(setq ido-use-filename-at-point nil)

;; Don't try to match file across all "work" directories; only match files
;; in the current directory displayed in the minibuffer
(setq ido-auto-merge-work-directories-length -1)

;; Includes buffer names of recently open files, even if they're not
;; open now
(setq ido-use-virtual-buffers t)

;; This enables ido in all contexts where it could be useful, not just
;; for selecting buffer and file names
(ido-ubiquitous-mode 1)


; neotree
(use-package neotree :ensure t)
(global-set-key [f8] 'neotree-project-dir-toggle)
(setq neo-show-hidden-files t)
(setq neo-window-fixed-size nil)
(setq neo-theme 'arrow)

(defun neotree-project-dir-toggle ()
  "Open NeoTree using the project root, using find-file-in-project,
or the current buffer directory."
  (interactive)
  (let ((project-dir
         (ignore-errors
           ;;; Pick one: projectile or find-file-in-project
                                        ; (projectile-project-root)
           (ffip-project-root)
           ))
        (file-name (buffer-file-name))
        (neo-smart-open t))
    (if (and (fboundp 'neo-global--window-exists-p)
             (neo-global--window-exists-p))
        (neotree-hide)
      (progn
        (neotree-show)
        (if project-dir
            (neotree-dir project-dir))
        (if file-name
            (neotree-find file-name))))))
