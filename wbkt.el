;;; wbkt.el --- Configure xwidget -*- lexical-binding: t -*-

;; Copyright © 2020-2022 Karim Aziiev <karim.aziiev@gmail.com>

;; Author: Karim Aziiev <karim.aziiev@gmail.com>
;; URL: https://github.com/KarimAziev/wbkt
;; Version: 0.1.0
;; Keywords: tools
;; Package-Requires: ((emacs "27.1"))

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This file configures operations with xwidget

;;; Code:

(eval-and-compile
  (require 'cc-mode))
(require 'xwidget)

(declare-function auth-source-pass-parse-entry "auth-source-pass")
(declare-function xwidget-webkit-current-session "xwidget")

(defconst wbkt-dir (file-name-directory
                    (or load-file-name buffer-file-name))
  "Directory with `wbkt'.")


(defcustom wbkt-xwidget-autofill-fields nil
  "Alists of DOM selectors to perform actions with `wbkt-xwidget-autofill'."
  :group 'xwidget
  :type '(repeat
          (alist
           :key-type (string :tag "DOM Selector" "input")
           :value-type
           (alist :options
                  ((:type (radio (const "fill" "fill")
                                 (const "click" "click"))
                          "fill")
                   (:payload
                    (choice
                     (cons :format "%v"
                           (const :format "Secret " secret)
                           (string :format "Entry %v"))
                     (string :tag "String")))
                   (:innerHTML (string :tag "Value")))))))

(defcustom wbkt-xwidget-inactive-style '(("html"
                                          ("opacity" . "0.8")))
  "Alist of html selectors and css values."
  :group 'xwidget
  :type `(alist
          :key-type (string :tag "HTML selector" "html")
          :value-type (alist
                       :key-type
                       (choice :tag "Property"
                               (const "azimuth")
                               (const "background")
                               (const "background-attachment")
                               (const "background-color")
                               (const "background-image")
                               (const "background-position")
                               (const "background-repeat")
                               (const "border")
                               (const "border-bottom")
                               (const "border-bottom-color")
                               (const "border-bottom-style")
                               (const "border-bottom-width")
                               (const "border-collapse")
                               (const "border-color")
                               (const "border-left")
                               (const "border-left-color")
                               (const "border-left-style")
                               (const "border-left-width")
                               (const "border-right")
                               (const "border-right-color")
                               (const "border-right-style")
                               (const "border-right-width")
                               (const "border-spacing")
                               (const "border-style")
                               (const "border-top")
                               (const "border-top-color")
                               (const "border-top-style")
                               (const "border-top-width")
                               (const "border-width")
                               (const "bottom")
                               (const "caption-side")
                               (const "clear")
                               (const "clip")
                               (const "color")
                               (const "content")
                               (const "counter-increment")
                               (const "counter-reset")
                               (const "cue")
                               (const "cue-after")
                               (const "cue-before")
                               (const "cursor")
                               (const "direction")
                               (const "display")
                               (const "elevation")
                               (const "empty-cells")
                               (const "float")
                               (const "font")
                               (const "font-family")
                               (const "font-size")
                               (const "font-style")
                               (const "font-weight")
                               (const "height")
                               (const "left")
                               (const "letter-spacing")
                               (const "line-height")
                               (const "list-style")
                               (const "list-style-image")
                               (const "list-style-position")
                               (const "list-style-type")
                               (const "margin")
                               (const "margin-bottom")
                               (const "margin-left")
                               (const "margin-right")
                               (const "margin-top")
                               (const "max-height")
                               (const "max-width")
                               (const "min-height")
                               (const "min-width")
                               (const "orphans")
                               (const "outline")
                               (const "outline-color")
                               (const "outline-style")
                               (const "outline-width")
                               (const "overflow")
                               (const "padding")
                               (const "padding-bottom")
                               (const "padding-left")
                               (const "padding-right")
                               (const "padding-top")
                               (const "page-break-after")
                               (const "page-break-before")
                               (const "page-break-inside")
                               (const "pause")
                               (const "pause-after")
                               (const "pause-before")
                               (const "pitch")
                               (const "pitch-range")
                               (const "play-during")
                               (const "position")
                               (const "quotes")
                               (const "richness")
                               (const "right")
                               (const "speak")
                               (const "speak-header")
                               (const "speak-numeral")
                               (const "speak-punctuation")
                               (const "speech-rate")
                               (const "stress")
                               (const "table-layout")
                               (const "text-align")
                               (const "text-indent")
                               (const "text-transform")
                               (const "top")
                               (const "unicode-bidi")
                               (const "vertical-align")
                               (const "visibility")
                               (const "voice-family")
                               (const "volume")
                               (const "white-space")
                               (const "widows")
                               (const "width")
                               (const "word-spacing")
                               (const "z-index")
                               (const "align-content")
                               (const "align-items")
                               (const "align-self")
                               (const "animation")
                               (const "animation-delay")
                               (const "animation-direction")
                               (const "animation-duration")
                               (const "animation-fill-mode")
                               (const "animation-iteration-count")
                               (const "animation-name")
                               (const "animation-play-state")
                               (const "animation-timing-function")
                               (const "backface-visibility")
                               (const "background-clip")
                               (const "background-origin")
                               (const "background-size")
                               (const "border-image")
                               (const "border-image-outset")
                               (const "border-image-repeat")
                               (const "border-image-source")
                               (const "border-image-slice")
                               (const "border-image-width")
                               (const "border-radius")
                               (const "border-top-left-radius")
                               (const "border-top-right-radius")
                               (const "border-bottom-left-radius")
                               (const "border-bottom-right-radius")
                               (const "box-decoration-break")
                               (const "box-shadow")
                               (const "box-sizing")
                               (const "break-after")
                               (const "break-before")
                               (const "break-inside")
                               (const "columns")
                               (const "column-count")
                               (const "column-fill")
                               (const "column-gap")
                               (const "column-rule")
                               (const "column-rule-color")
                               (const "column-rule-style")
                               (const "column-rule-width")
                               (const "column-span")
                               (const "column-width")
                               (const "filter")
                               (const "flex")
                               (const "flex-basis")
                               (const "flex-direction")
                               (const "flex-flow")
                               (const "flex-grow")
                               (const "flex-shrink")
                               (const "flex-wrap")
                               (const "font-feature-setting")
                               (const "font-kerning")
                               (const "font-language-override")
                               (const "font-size-adjust")
                               (const "font-stretch")
                               (const "font-synthesis")
                               (const "font-variant")
                               (const "font-variant-alternates")
                               (const "font-variant-caps")
                               (const "font-variant-east-asian")
                               (const "font-variant-ligatures")
                               (const "font-variant-numeric")
                               (const "font-variant-position")
                               (const "hyphens")
                               (const "justify-content")
                               (const "line-break")
                               (const "marquee-direction")
                               (const "marquee-play-count")
                               (const "marquee-speed")
                               (const "marquee-style")
                               (const "opacity")
                               (const "order")
                               (const "outline-offset")
                               (const "overflow-x")
                               (const "overflow-y")
                               (const "overflow-style")
                               (const "overflow-wrap")
                               (const "perspective")
                               (const "perspective-origin")
                               (const "resize")
                               (const "tab-size")
                               (const "text-align-last")
                               (const "text-decoration")
                               (const "text-decoration-color")
                               (const "text-decoration-line")
                               (const "text-decoration-style")
                               (const "text-overflow")
                               (const "text-shadow")
                               (const "text-underline-position")
                               (const "transform")
                               (const "transform-origin")
                               (const "transform-style")
                               (const "transition")
                               (const "transition-delay")
                               (const "transition-duration")
                               (const "transition-timing-function")
                               (const "transition-property")
                               (const "word-wrap")
                               (const "word-break"))
                       :value-type
                       (string :tag "Value"))))

(defvar wbkt-js-syntax-table
  (let ((table (make-syntax-table)))
    (c-populate-syntax-table table)
    (modify-syntax-entry ?$ "_" table)
    (modify-syntax-entry ?`"\"" table)
    table)
  "Syntax table for command `wbkt-js-mode'.")

(defun wbkt-js-syntax-propertize-regexp (end)
  "Propertize regexp syntax and goto END position."
  (let ((ppss (syntax-ppss)))
    (when (eq (nth 3 ppss) ?/)
      (goto-char (nth 8 ppss))
      (when (looking-at
             "/\\(?:[^/[\\]\\|\\\\.\\|\\[\\(?:[^]\\]\\|\\\\.\\)*]\\)*\\(/?\\)")
        (when (> end (match-end 1))
          (setq end (match-end 1)))
        (put-text-property (match-beginning 1) end
                           'syntax-table (string-to-syntax "\"/"))
        (goto-char end)))))

(defun wbkt-js-syntax-propertize (start end)
  "Propertize text between START and END with JavaScript syntax rules."
  (goto-char start)
  (wbkt-js-syntax-propertize-regexp end)
  (funcall
   (syntax-propertize-rules
    ("\\(?:^\\|[=([{,:;|&!]\\|\\_<return\\_>\\)\\(?:[ \t]\\)*\\(/\\)[^/*]"
     (1 (ignore
         (forward-char -1)
         (when (or (not (memq (char-after (match-beginning 0)) '(?\s ?\t)))
                   (save-excursion
                     (goto-char (match-beginning 0))
                     (forward-comment (- (point)))
                     (memq (char-before)
                           (eval-when-compile (append "=({[,:;" '(nil))))))
           (put-text-property (match-beginning 1) (match-end 1)
                              'syntax-table (string-to-syntax "\"/"))
           (wbkt-js-syntax-propertize-regexp end)))))
    ("\\`\\(#\\)!" (1 "< b")))
   (point) end))

(defmacro wbkt-js-with-temp-buffer (&rest body)
  "Evaluate BODY in temporarily buffer with JavaScript syntax."
  `(with-temp-buffer
     (erase-buffer)
     (progn
       (set-syntax-table wbkt-js-syntax-table)
       (setq-local open-paren-in-column-0-is-defun-start nil)
       (setq-local syntax-propertize-function #'wbkt-js-syntax-propertize)
       (setq-local parse-sexp-ignore-comments t)
       (setq-local comment-start "// ")
       (setq-local comment-start-skip "\\(//+\\|/\\*+\\)\\s *")
       (setq-local comment-end "")
       (syntax-ppss-flush-cache (point-min))
       (wbkt-js-syntax-propertize (point-min)
                                  (point-max))
       ,@body)))

(defun wbkt-enlist (exp)
  "Return EXP wrapped in a list, or as-is if already a list."
  (declare (pure t)
           (side-effect-free t))
  (if (proper-list-p exp) exp (list exp)))

(defun wbkt-buffers-in-mode (modes &optional buffer-list derived-p)
  "Return a list of BUFFER-LIST whose `major-mode' is `eq' to MODES.

If DERIVED-P, test with `derived-mode-p', otherwise use `eq'."
  (let ((modes (wbkt-enlist modes)))
    (cl-remove-if-not (if derived-p
                          (lambda (buf)
                            (apply #'provided-mode-derived-p
                                   (buffer-local-value 'major-mode buf)
                                   modes))
                        (lambda (buf)
                          (memq (buffer-local-value 'major-mode buf) modes)))
                      (or buffer-list (buffer-list)))))


(defun wbkt-xwidget-pass-args (js-file &rest args)
  "Return content of JS-FILE and replace comments /*%s*/ with ARGS."
  (let ((args-str (string-join args ", ")))
    (wbkt-js-with-temp-buffer
     (insert-file-contents js-file)
     (goto-char (point-max))
     (skip-chars-backward "\s\t\n;")
     (when (looking-back "[)]" 0)
       (forward-char -1)
       (insert args-str))
     (buffer-string))))



(defun wbkt-xwidget-get-autofix-fields ()
  "Return `wbkt-xwidget-autofill-fields'."
  (require 'auth-source-pass)
  (mapcar
   (lambda (item)
     (mapcar
      (lambda (a)
        (if-let ((entry
                  (and (alist-get :payload a)
                       (listp (alist-get :payload a))
                       (alist-get 'secret (alist-get :payload a)))))
            (cons (car a)
                  (mapcar (lambda (cell)
                            (cons
                             (car cell)
                             (if (eq (car cell)
                                     :payload)
                                 (alist-get
                                  'secret
                                  (auth-source-pass-parse-entry
                                   entry))
                               (cdr cell))))
                          (cdr a)))
          a))
      item))
   wbkt-xwidget-autofill-fields))

(defun wbkt-get-autofill-script ()
  "Execute js actions defined in `wbkt-xwidget-autofill-fields'."
  (require 'json)
  (let ((encoded (when (fboundp 'json-encode)
                   (json-encode (wbkt-xwidget-get-autofix-fields)))))
    (wbkt-xwidget-pass-args (expand-file-name
                             "js/autofill.js"
                             wbkt-dir)
                            encoded)))

(defun wbkt-get-dark-theme-script ()
  "Execute js actions defined in `wbkt-xwidget-autofill-fields'."
  (wbkt-xwidget-pass-args (expand-file-name
                           "js/injectcss.js"
                           wbkt-dir)
                          "`html {
  -webkit-filter: hue-rotate(180deg) invert(90%) !important;
}
iframe,img,video {
  -webkit-filter: brightness(90%) invert(100%) hue-rotate(180deg) !important;
}`"))

(defun wbkt-get-dark-theme-unset-script ()
  "Execute js actions defined in `wbkt-xwidget-autofill-fields'."
  (wbkt-xwidget-pass-args (expand-file-name
                           "js/injectcss.js"
                           wbkt-dir)
                          "`html {
  -webkit-filter: unset !important;
}
iframe,img,video {
  -webkit-filter: unset !important;
}`"))

(defun wbkt-get-flash-script ()
  "Return script which inject `wbkt-xwidget-inactive-style'."
  (wbkt-xwidget-pass-args (expand-file-name
                           "js/injectcss.js"
                           wbkt-dir)
                          (format "`%s`"
                                  (wbkt-xwidget-alist-style-to-string
                                   wbkt-xwidget-inactive-style))
                          "500"))
(defun wbkt-current-session ()
  "Return first found webkit session."
  (or (xwidget-webkit-current-session)
      (car xwidget-list)))

(defun wbkt-xwidget--inject-navigator (&rest _)
  "Inject clipboard polyfill."
  (when-let ((active-session (wbkt-current-session)))
    (xwidget-webkit-execute-script active-session
                                   (with-temp-buffer
                                     (insert-file-contents
                                      (expand-file-name
                                       "js/navigator.js"
                                       wbkt-dir))
                                     (buffer-string)))))

(defun wbkt-xwidget-inject-navigator (&rest _)
  "Inject clipboard polyfill."
  (run-with-timer 1 nil 'wbkt-xwidget--inject-navigator))

(defvar wbkt-xwidget-dark-theme nil)

;;;###autoload
(defun wbkt-xwidget-toggle-theme ()
  "Toggle theme."
  (interactive)
  (when-let ((active-session (wbkt-current-session)))
    (setq wbkt-xwidget-dark-theme (not wbkt-xwidget-dark-theme))
    (xwidget-webkit-execute-script active-session
                                   (if wbkt-xwidget-dark-theme
                                       (wbkt-get-dark-theme-script)
                                     (wbkt-get-dark-theme-unset-script)))))

;;;###autoload
(defun wbkt-xwidget-set-dark-theme ()
  "Set dark theme."
  (interactive)
  (setq wbkt-xwidget-dark-theme nil)
  (wbkt-xwidget-toggle-theme))

;;;###autoload
(defun wbkt-xwidget-unset-dark-theme ()
  "Set dark theme."
  (interactive)
  (setq wbkt-xwidget-dark-theme t)
  (wbkt-xwidget-toggle-theme))

(defun wbkt-xwidget-alist-style-to-string (alist)
    "Return string from ALIST of html selectors and css styles."
    (mapconcat (lambda (css)
                 (format "%s {\n%s\n}" (car css)
                         (mapconcat
                          (lambda (value)
                            (format "%s: %s;" (car value)
                                    (cdr value)))
                          (cdr css) "\n")))
               alist
               "\n"))

(defun wbkt-highlight-window ()
  "Temporarly add styles from `wbkt-xwidget-inactive-style' to xwidget page."
  (when-let ((session (wbkt-current-session)))
    (unless (bound-and-true-p xwidget-webkit--loading-p)
      (xwidget-webkit-execute-script
       session
       (wbkt-get-flash-script)))))

(defmacro wbkt-xwidget-define-event-command (name from-key key)
  "Define interactive function NAME that pass KEY to to WebKit widget.
Bind FROM-KEY to `xwidget-webkit-edit-mode-map'."
  `(progn
     (defun ,name ()
       ,(format "Set `last-command-event' to `%s' and pass it WebKit widget."
                key)
       (interactive)
       (setq last-command-event (car
                                 (listify-key-sequence
                                  ,(if (stringp key)
                                       `(kbd ,key)
                                     `,(car (list key))))))
       (xwidget-webkit-pass-command-event))
     (define-key xwidget-webkit-edit-mode-map
                 ,(if (stringp from-key)
                      `(kbd ,from-key)
                    `,(car (list from-key)))
                 ',name)))

(defmacro wbkt-xwidget-define-event-commands (&rest alist)
  "Define interactive functions from ALIST of from-key to to-key.
See `wbkt-xwidget-define-event-command'."
  `(progn ,@(mapcar (lambda (cell)
                      `(wbkt-xwidget-define-event-command
                        ,(intern
                          (replace-regexp-in-string "[\s\t]" ""
                                                    (format
                                                     "wbkt-xwidget-simulate-key-%s-%s"
                                                     (car
                                                      cell)
                                                     (cdr
                                                      cell))))
                        ,(car cell)
                        ,(cdr cell)))
                    alist)))

;;;###autoload
(defun wbkt-xwidget-autofill ()
  "Execute js actions defined in `wbkt-xwidget-autofill-fields'."
  (interactive)
  (require 'json)
  (when-let* ((session (wbkt-current-session))
              (encoded (wbkt-get-autofill-script)))
    (xwidget-webkit-execute-script session encoded)))


;;;###autoload
(defun wbkt-xwidget-remove-cache ()
  "Remove WebKitCache directories and kill all xwidget buffers."
  (interactive)
  (let ((dirs (seq-filter #'file-exists-p
                          '("~/.cache/emacs/WebKitCache/"
                            "~/.cache/emacs/CacheStorage/"))))
    (when dirs
      (dolist (buff (wbkt-buffers-in-mode 'xwidget-webkit-mode))
        (kill-buffer buff))
      (dolist (dir dirs)
        (delete-directory dir t)
        (message "Deleted %s" (abbreviate-file-name dir))))))

(wbkt-xwidget-define-event-commands
 ("C-a" . "C-<left>")
 ("C-e" . "C-<right>")
 ("M-b" . "C-<left>")
 ("M-f" . "C-<right>")
 ("C-f" . "<right>")
 ("C-b" . "<left>")
 ("C-M-f" . "S-<right>")
 ("C-M-e" . "S-<right>")
 ("C-M-b" . "S-<left>")
 ("C-M-a" . "S-<left>"))

(provide 'wbkt)
;;; wbkt.el ends here