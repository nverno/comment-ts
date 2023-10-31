## Tree-sitter support for comments

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

This package is compatible with and was tested against the tree-sitter grammar
for comments found at [tree-sitter-comment](https://github.com/stsewd/tree-sitter-comment).

It provides font-locking support for comments.

## Installing

Emacs 29.1 or above with tree-sitter support is required. 

Tree-sitter starter guide: https://git.savannah.gnu.org/cgit/emacs.git/tree/admin/notes/tree-sitter/starter-guide?h=emacs-29

### Install tree-sitter comment parser

Add the source to `treesit-language-source-alist`. 

```elisp
(add-to-list
 'treesit-language-source-alist
 '(comment "https://github.com/tree-sitter/tree-sitter-comment"))
```

Then run `M-x treesit-install-language-grammar` and select `comment` to install.

### To install comment-ts.el from source

- Clone this repository
- Add the following to your emacs config

```elisp
(require "[cloned nverno/comment-ts]/comment-ts.el")
```

### Troubleshooting

If you get the following warning:

```
⛔ Warning (treesit): Cannot activate tree-sitter, because tree-sitter
library is not compiled with Emacs [2 times]
```

Then you do not have tree-sitter support for your emacs installation.

If you get the following warnings:
```
⛔ Warning (treesit): Cannot activate tree-sitter, because language grammar for comment is unavailable (not-found): (libtree-sitter-comment libtree-sitter-comment.so) No such file or directory
```

then the comment grammar files are not properly installed on your system.
