## Tree-sitter support for comments

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

This package is compatible with and was tested against the tree-sitter grammar
for comments found at [tree-sitter-comment](https://github.com/stsewd/tree-sitter-comment).

It provides font-locking support for comments that is intended to be used as an
embedded parser with other languages.

## Installing

Emacs 29.1 or above with tree-sitter support is required. 

Tree-sitter starter guide: https://git.savannah.gnu.org/cgit/emacs.git/tree/admin/notes/tree-sitter/starter-guide?h=emacs-29

### Install tree-sitter parser

Add the source to `treesit-language-source-alist` and call 
`treesit-install-language-grammar` to install.

```elisp
(let ((treesit-language-source-alist
       '((comment "https://github.com/tree-sitter/tree-sitter-comment"))))
  (treesit-install-language-grammar 'comment))
```
