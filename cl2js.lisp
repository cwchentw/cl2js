(load (merge-pathnames "cl-yautils.lisp" *load-pathname*))
(in-package :cl-yautils)

; Check whether ParenScript is available.
(handler-case (cl:require "parenscript")
  (error ()
    (perror "No Parenscript on the system")
    (quit-with-status 1)))

; (use-package :cl-yautils)
(use-package :parenscript)

(defun main ()
  (prog* ((args (argument-vector))
          #+sbcl (args (rest args))
          #+ccl  (args (rest (rest (rest (rest args)))))
          ; In ABCL, no loading script in arguments.
          (path (first args)))
    (when (null path)
      (perror "No input file")
      (quit-with-status 1))
    (princ (ps-compile-file path))
    (quit-with-status)))

(main)
