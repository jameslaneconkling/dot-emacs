```bash
cd ~/.emacs.d
git clone <repo>
touch ./init.el
```
```lisp
;; ~/.emacs.d/init.el
(load "~/.emacs.d/personal/config.el")
(setq custom-file "~/.emacs.d/personal/custom.el")
(load custom-file)
```
