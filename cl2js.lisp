(load (merge-pathnames "cl-yautils.lisp" *load-pathname*))
(in-package :cl-yautils)

; Check whether ParenScript is available.
(handler-case (cl:require "parenscript")
  (error ()
    (perror "No Parenscript on the system")
    (quit-with-status 1)))

; (use-package :cl-yautils)
(use-package :parenscript)

; Generate newer JavaScript code.
(setq *js-target-version* "1.8.5")

(defun main ()
  (prog* ((args (argument))
          (path (first (rest args))))
    (when (null path)
      (perror "No input file")
      (quit-with-status 1))
    (princ (ps-compile-file path)))
  (quit-with-status))

(main)
