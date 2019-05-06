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

### Clojure-mode

`C-c M-j` for cider-repl.

[Add](https://github.com/clojure-emacs/cider-nrepl) following to `~/.lein/profiles.clj`:

```
{:user {:middleware [cider-nrepl.plugin/middleware] :plugins [[cider/cider-nrepl "0.21.1" :exclusions [org.clojure/tools.namespace]]]}}
```

### Go-mode

Install LSP go-langserver: `github.com/sourcegraph/go-langserver`

### TypeScript Mode

Install [language server](https://github.com/emacs-lsp/lsp-mode):

```
npm i -g typescript-language-server; npm i -g typescript
```

### Java Mode

LSP Java works out of box: install server once, wait maven import after open project(check lsp-log buffer for progress).

### Python-mode

Install language server in virtualenv: `pip install 'python-language-server[all]'`

Mode shortcut:

- `f3`: lsp-find-references
- `C-c g`: goto definition
- `tab`: show completion list(slow)

Shell shortcuts:

```bash
alias ss='source ../.env/"${PWD##*/}"/bin/activate'
alias pss='python3 -m venv ../.env/"${PWD##*/}"'
alias pss2='virtualenv ../.env/"${PWD##*/}"'
alias rmss='rm -rf ../.env/"${PWD##*/}"'
```

### C++-mode

Install ccls, generate `compile_commands.json` in [project root](https://github.com/MaskRay/ccls/wiki/Project-Setup).

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

- [ ] clojurescript-mode
