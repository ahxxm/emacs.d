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

## Modes

### Python-mode

To make most of python-mode, run:

```
pip install epc jedi pep8 pyflakes ipdb
```

in virtualenv.

### C++-mode

`irony-mode`(for completion) requires `libclang`, installation method varies among different systems.

irony server also requires cmake to compile.

`libclang.so` upgrade might require irony-server to be re-compiled, depends on your compile args.
