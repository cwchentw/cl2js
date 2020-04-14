(load (merge-pathnames "cl-yautils.lisp" *load-pathname*))

; Due to name collision between :cl-yautils and :parenscript,
; we don't use :cl-yautils package.
(rename-package :cl-yautils :yau)

; Load Parenscript if it exists.
(handler-case (require "parenscript")
  (error ()
    (yau:perror "No Parenscript on the system")
    (yau:quit-with-status 1)))

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
  (prog* ((args (yau:argument-vector))
          #+(or sbcl ccl) (path (first (rest args)))
          #+abcl (path (first args))
         )
    (when (null path)
      (yau:perror "No input file")
      (yau:quit-with-status 1))
    (with-open-file (f path)
      (handler-bind
        ((error
           (lambda (e) 
             (format *error-output* "~A~%" e)
             (yau:quit-with-status 1))))
           (ps2js f))))
  (finish-output)
  (yau:quit-with-status))

#+(or sbcl ccl) (defvar +program+ 
#+(or sbcl ccl)   (if (equal :windows (yau:platform)) "cl2js.exe" "cl2js"))
#+(or sbcl ccl) (yau:compile-program +program+ (lambda () (main)))

#+abcl (main)