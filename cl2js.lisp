(load (merge-pathnames "cl-yautils.lisp" *load-pathname*))

; Due to name collision between :cl-yautils and :parenscript,
; we don't use :cl-yautils package.
(rename-package :cl-yautils :yau)

; Check whether ParenScript is available.
(handler-case (require "parenscript")
  (error ()
    (yau:perror "No Parenscript on the system")
    (yau:quit-with-status 1)))

; Due to name collision between :cl of ABCL and :parenscript,
; we use :parenscript.
(in-package :parenscript)

; Generate newer JavaScript code.
(setq *js-target-version* "1.8.5")

(defun main ()
  (prog* ((args (yau:argument))
          (path (first (rest args))))
    (when (null path)
      (yau:perror "No input file")
      (yau:quit-with-status 1))
    (princ (ps-compile-file path)))
  (finish-output)
  (yau:quit-with-status))

(main)
