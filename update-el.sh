#!/bin/sh

set -ex

wget -O plugins/a.el https://raw.githubusercontent.com/plexus/a.el/master/a.el
wget -O plugins/f.el https://raw.githubusercontent.com/rejeep/f.el/master/f.el
# required by f.el when emacs <= 28.1
wget -O plugins/f-shortdoc.el https://raw.githubusercontent.com/rejeep/f.el/master/f-shortdoc.el
wget -O plugins/dockerfile-mode.el https://raw.githubusercontent.com/spotify/dockerfile-mode/master/dockerfile-mode.el
wget -O plugins/highlight-indentation.el https://raw.githubusercontent.com/antonj/Highlight-Indentation-for-Emacs/master/highlight-indentation.el
wget -O plugins/highlight-parentheses.el https://git.sr.ht/~tsdh/highlight-parentheses.el/blob/main/highlight-parentheses.el
wget -O plugins/highlight-symbol.el https://raw.githubusercontent.com/nschum/highlight-symbol.el/master/highlight-symbol.el
wget -O plugins/markdown-mode.el https://raw.githubusercontent.com/jrblevin/markdown-mode/master/markdown-mode.el
wget -O plugins/json-mode.el https://raw.githubusercontent.com/joshwnj/json-mode/master/json-mode.el
wget -O plugins/parseedn.el https://raw.githubusercontent.com/clojure-emacs/parseedn/master/parseedn.el # parseclj module as well
wget -O plugins/projectile.el https://raw.githubusercontent.com/bbatsov/projectile/master/projectile.el
wget -O plugins/ring+.el https://www.emacswiki.org/emacs/download/ring%2b.el
wget -O plugins/s.el https://raw.githubusercontent.com/magnars/s.el/master/s.el
wget -O plugins/spinner.el https://raw.githubusercontent.com/Malabarba/spinner.el/master/spinner.el
wget -O plugins/yaml-mode.el https://raw.githubusercontent.com/yoshiki/yaml-mode/master/yaml-mode.el
wget -O plugins/auto-highlight-symbol.el https://raw.githubusercontent.com/elp-revive/auto-highlight-symbol/master/auto-highlight-symbol.el
wget -O plugins/adoc-mode.el https://raw.githubusercontent.com/jmakovicka/adoc-mode/master/adoc-mode.el
