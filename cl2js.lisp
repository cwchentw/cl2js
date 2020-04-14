(load (merge-pathnames "cl-yautils.lisp" *load-pathname*))

(use-package :cl-yautils)

; Load Parenscript if it exists.
(handler-case (require "parenscript")
  (error ()
    (perror "No Parenscript on the system")
    (quit-with-status 1)))

; Due to name collision between :cl of ABCL and :parenscript,
; we set current package :parenscript.
;(in-package :parenscript)

(defun ps2js (f &key (comment nil))
  (in-package :ps)
  (do
   ((form (read f nil) (read f nil)))
   ((not form))
    (when comment
      (format t  "/* ~A */~%" form))
    (format t "~A~%" (ps:ps* form))))

; Generate newer JavaScript code.
(setq parenscript:*js-target-version* "1.8.5")

(defun main ()
  (prog* ((args (argument-vector))
          #+(or sbcl ccl) (path (first (rest args)))
          #+abcl          (path (first args))
         )
    (when (null path)
      (perror "No input file")
      (quit-with-status 1))
    (with-open-file (f path)
      (handler-bind
        ((error
           (lambda (e) 
             (format *error-output* "~A~%" e)
             (quit-with-status 1))))
           (ps2js f))))
  (finish-output)
  (quit-with-status))

#+abcl (main)