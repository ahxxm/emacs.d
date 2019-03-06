# emacs.d

## Usage

Add following to `~/.emacs`:

```
;; added by package.el
(package-initialize)

;; your path
(add-to-list 'load-path "/home/ahxxm/dev/emacs.d")
(require 'emacs-dealM)
```

## Development

All packages will be put inside *plugins* folder, git submodule is used for version control.

`emacs-dealM.el` is an entrypoint for modifying.

## Shortcuts

### Edit

- `C-]`: jump to matching paren
- `F1`: find file by name
- `F2`: full-text grep
- `C-x v z`: magit-status
- `C-c C-c`: comment current line
- `C-x u`: revert buffer, the same as `k` in magit status
- `C-z`: undo

### Buffer

- `C-x 1`: delete-other-windows
- `C-x 2`: split-window-vertically
- `C-x 3`: split-window-horizontally
- `C-x o`: switch to another-window

### Other

- `F4`: projectile-invalidate-cache, in case project file changes

## Modes

### Python-mode

To make most of python-mode, run following in virtualenv:

```
pip install epc jedi pep8 flake8 ipdb
```

Mode specific shortcuts:

- `C-c g`: goto definition
- `C-c d`: show doc

### C++-mode

`irony-mode`(for completion) requires `libclang`, installation method [varies](https://github.com/Sarcasm/irony-mode/issues/167) among different systems.

irony server also requires cmake to compile.

`libclang.so` upgrade might require irony-server to be re-compiled, depends on your compile args.

### Clojure-mode

`C-c M-j` for cider-repl.

[Add](https://github.com/clojure-emacs/cider-nrepl) following to `~/.lein/profiles.clj`:

```
{:user {:middleware [cider-nrepl.plugin/middleware] :plugins [[cider/cider-nrepl "0.21.1" :exclusions [org.clojure/tools.namespace]]]}}
```

### Go-mode

Install:

- gocode: `go get -u -v github.com/mdempsky/gocode`
- godef: `go get -u -v github.com/rogpeppe/godef`

Remove nsf/gocode and kill process first if anything wrong.

### Magit

To update:

```bash
cd plugins/magit
git pull && make clean && make
cd ../plugins/transient
git pull && make clean && make
cd ../../
```

## TODO

- [ ] versatile c/c++ mode: flycheck, jump to definition, completion on tab
- [ ] clojurescript-mode
- [ ] java-mode: jdee, eclim, lsp, meghanada?
