(load (merge-pathnames "cl-yautils.lisp" *load-pathname*))

(use-package :cl-yautils)

; Load Parenscript if it exists.
(handler-case (require "parenscript")
  (error ()
    (perror "No Parenscript on the system")
    (quit-with-status 1)))

(defun ps2js (f &key (comment nil))
  (in-package :ps)
  (do
   ((form (read f nil) (read f nil)))
   ((not form))
    (when comment
      (format t  "/* ~(~a~) */~%" form))
    (format t "~A~%" (ps:ps* form))))

(defun ps2js-read (in &optional verbose)
  (if (null in)
        (with-open-stream (s *standard-input*)
          (if (not (interactive-stream-p s))
              (handler-bind
                ((error
                   (lambda (e)
                     (format *error-output* "~A~%" e)
                     (quit-with-status 1))))
                (ps2js s :comment verbose))
              (progn
                (perror "No input file")
                (quit-with-status 1))))
        (with-open-file (f in)
          (handler-bind
            ((error
               (lambda (e)
                 (format *error-output* "~A~%" e)
                 (quit-with-status 1))))
            (ps2js f :comment verbose)))))

;; Generate newer JavaScript code.
(setq parenscript:*js-target-version* "1.8.5")

;; Flag for verbose mode.
(defvar *verbose-mode* nil)

(defun main ()
  (prog* ((args (argument-vector))
          #+(or sbcl ccl) (args (rest args))
         )
    (loop
            ;; Extract an argument.
      (let ((arg (pop args)))
                 ;; Enable verbose mode.
           (cond ((or (string= arg "-v")
                      (string= arg "--verbose"))
                  (setq *verbose-mode* t))
                 ;; Compile Parenscript into JavaScript.
                 (t (ps2js-read arg *verbose-mode*)
                    (return))))))
  (finish-output)
  (quit-with-status))

#+abcl (main)