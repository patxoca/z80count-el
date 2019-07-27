;;; z80count.el --- z80count integration for emacs -*- lexical-binding: t; -*-

;; $Id:$

;; Emacs List Archive Entry
;; Filename: z80count.el
;; Version: 0.1.0
;; Keywords:
;; Author: Alexis Roda <alexis.roda.villalonga@gmail.com>
;; Maintainer: Alexis Roda <alexis.roda.villalonga@gmail.com>
;; Created: 2019-04-06
;; Description: binding for the z80count external command
;; URL: https://github.com/patxoca/z80count
;; Compatibility: Emacs24
;; Package-Requires: ((emacs "24"))

;; COPYRIGHT NOTICE
;;
;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use, copy,
;; modify, merge, publish, distribute, sublicense, and/or sell copies
;; of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:
;;
;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
;; BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
;; ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

;;; Install:

;; Put this file on your Emacs-Lisp load path and add following into
;; emacs startup file.
;;
;;     (require 'z80count)
;;
;; or use autoload:
;;
;;      (autoload 'z80count "z80count" "" t)

;;; Commentary:
;;


;;; History:
;;
;; 2019-04-06: initial version

;;; Code:

(defgroup z80count nil
  "Run z80count from within emacs.")

(defcustom z80count-command "z80count"
  "z80count executable, full path."
  :group 'z80count
  :type  'string
  :safe  'stringp)

(defcustom z80count-command-options "-s -u"
  "z80count command line arguments."
  :group 'z80count
  :type  'string
  :safe  'stringp)

(defun z80count--make-command ()
  (format "%s %s" z80count-command z80count-command-options))

(defun z80count--normalize-region ()
  "Expand the region so that it selects whole lines."
  (let ((beg (region-beginning))
        (end (region-end)))
    (goto-char beg)
    (beginning-of-line)
    (push-mark (point) nil t)
    (goto-char end)
    (when (not (= (point) (line-beginning-position)))
      (end-of-line))))

;;;###autoload
(defun z80count (begin end)
  "Run z88count on region."
  (interactive "r")
  (save-mark-and-excursion
    (z80count--normalize-region)
    (setq begin (region-beginning))
    (setq end (region-end)))
  (shell-command-on-region begin end (z80count--make-command) t t))

(provide 'z80count)

;;; z80count.el ends here
