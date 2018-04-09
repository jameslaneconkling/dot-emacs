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

# System Requirements
* [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)
