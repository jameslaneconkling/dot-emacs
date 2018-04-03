
;; ~/.emacs.d/personal/env/nvaigation-cfg.el

;;;;;;;;;;;;;;;;
;; navigation ;;
;;;;;;;;;;;;;;;;

;; helm
(use-package helm :ensure t)
(global-set-key (kbd "M-x") 'helm-M-x)
;; (global-set-key (kbd "C-x C-b") 'helm-buffers-list)

;; helm-ag
(use-package helm-ag :ensure t) ;; must make sure `ag` is installed
(global-set-key (kbd "C-c C-f") 'helm-do-ag-project-root) ;; ag text search current project


;; set pageup/pagedown to goto next buffers
(global-set-key (kbd "<next>") 'next-buffer)
(global-set-key (kbd "<prior>") 'previous-buffer)


;; projectile
(use-package projectile :ensure t)
(use-package helm-projectile :ensure t)
;; why can't the below overwrite the defaults: "C-c p f/F/p"?
(global-set-key (kbd "C-x p f") 'helm-projectile) ;; find files in projectile project
(global-set-key (kbd "C-x p F") 'helm-projectile-find-file-in-known-projects) ;; find files across all projects
(global-set-key (kbd "C-x p p") 'helm-projectile-switch-project) ;; switch projectile projects
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
