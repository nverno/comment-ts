;;; comment-ts.el --- Tree-sitter support for comments -*- lexical-binding: t; -*-

;; Author: Noah Peart <noah.v.peart@gmail.com>
;; URL: https://github.com/nverno/comment-ts-mode
;; Version: 0.0.1
;; Package-Requires: ((emacs "29.1"))
;; Created:  31 October 2023
;; Keywords: languages tree-sitter comment

;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; Tree-sitter font-lock support for comments.
;;
;; This mode is compatible with the tree-sitter parser found at
;; https://github.com/stsewd/tree-sitter-comment.
;;
;;; Code:

(eval-when-compile (require 'cl-lib))
(require 'treesit)

(defface comment-ts-todo-face
  '((t (:inherit font-lock-warning-face)))
  "Face to highlight comment todo keywords."
  :group 'comment-ts)

(defface comment-ts-note-face
  '((t :foreground "SteelBlue"))
  "Face to highlight comment note keywords."
  :group 'comment-ts)

(defface comment-ts-warning-face
  '((t (:inherit font-lock-warning-face)))
  "Face to highlight comment warning keywords."
  :group 'comment-ts)

(defface comment-ts-danger-face
  '((t (:inherit error)))
  "Face to highlight comment error keywords."
  :group 'comment-ts)

(defvar comment-ts--feature-list
  '(() (keyword url) (number) ())
  "`treesit-font-lock-feature-list' for `comment-ts-mode'.")

(defvar comment-ts--font-lock-settings
  (treesit-font-lock-rules
   :language 'comment
   :feature 'keyword
   `(;; Todos
     ((tag
       (name) @comment-ts-todo-face
       ("(" @font-lock-bracket-face
        (user) @font-lock-constant-face
        ")" @font-lock-bracket-face) :?
       ":" @font-lock-delimiter-face)
      (:match ,(rx-to-string '(or "TODO" "WIP")) @comment-ts-todo-face))

     (("text" @comment-ts-todo-face)
      (:match ,(rx-to-string '(or "TODO" "WIP")) @comment-ts-todo-face))

     ;; Notes
     ((tag
       (name) @comment-ts-note-face
       ("(" @font-lock-bracket-face
        (user) @font-lock-constant-face
        ")" @font-lock-bracket-face) :?
       ":" @font-lock-delimiter-face)
      (:match ,(rx-to-string '(or "NOTE" "XXX" "INFO" "DOCS" "PERF" "TEST"))
              @comment-ts-note-face))
     (("text" @comment-ts-note-face)
      (:match ,(rx-to-string '(or "NOTE" "XXX" "INFO" "DOCS" "PERF" "TEST"))
              @comment-ts-note-face))

     ;; Warnings
     ((tag
       (name) @comment-ts-warning-face
       ("(" @font-lock-bracket-face
        (user) @font-lock-constant-face
        ")" @font-lock-bracket-face) :?
        ":" @font-lock-delimiter-face)
      (:match ,(rx-to-string '(or "HACK" "WARNING" "WARN" "FIX"))
              @comment-ts-warning-face))
     (("text" @comment-ts-warning-face)
      (:match ,(rx-to-string '(or "HACK" "WARNING" "WARN" "FIX"))
              @comment-ts-warning-face))

     ;; Danger
     ((tag
       (name) @comment-ts-danger-face
       ("(" @font-lock-bracket-face
        (user) @font-lock-constant-face
        ")" @font-lock-bracket-face) :?
       ":" @punctuation.delimiter)
      (:match ,(rx-to-string '(or "FIXME" "BUG" "ERROR"))
              @comment-ts-danger-face))

     (("text" @comment-ts-danger-face)
      (:match ,(rx-to-string '(or "FIXME" "BUG" "ERROR"))
              @comment-ts-danger-face)))

   ;; Issue number (#123)
   :language 'comment
   :feature 'number
   '((("text" @font-lock-number-face)
      (:match "^#[0-9]+$" @font-lock-number-face))))
  "Tree-sitter font-lock settings for comments.")

;;; Major mode

;;;###autoload
(define-derived-mode comment-ts-mode prog-mode "Regex"
  "Major mode for comments."
  :group 'comment
  ;; :syntax-table comment-ts-mode--syntax-table
  (when (treesit-ready-p 'comment)
    (treesit-parser-create 'comment)
    (setq-local treesit-font-lock-settings comment-ts--font-lock-settings)
    (setq-local treesit-font-lock-feature-list comment-ts--feature-list)
    (treesit-major-mode-setup)))

(when (treesit-ready-p 'comment)
  (add-to-list 'auto-mode-alist '("\\.comment\\'" . comment-ts-mode)))

(provide 'comment-ts)
;; Local Variables:
;; coding: utf-8
;; indent-tabs-mode: nil
;; End:
;;; comment-ts.el ends here
