(in-package :cl-user)

(defpackage :cl-yautils
  (:use :cl)
  (:documentation
    "Yet another utilities for Common Lisp")
  (:export :*safe-mode*
           :defined
           :nullable
           :average
           :random-integer
           :puts
           :perror
           :quit-with-status
           :compile-program
           :argument-vector
           :argument
           :platform))

(in-package :cl-yautils)

(defvar *safe-mode* nil
  "Validate data at runtime")

(defmacro defined (obj)
  "Check whether obj is defined."
  `(and (ignore-errors ,obj) t))

(deftype nullable (type)
  "Define nullable type"
  `(or null ,type))

(defun average (lst)
  (declare (ftype (function (list) number) average))
  "Get the average of a number list."
  (when *safe-mode*
    (check-type lst list)
    (assert (every #'numberp lst)))
  (/ (apply #'+ lst) (length lst)))

(defun random-integer (small large &optional seed)
  (declare
    (ftype (function
             (integer integer &optional random-state)
             integer)
           random-integer))
  "Get a random integer between small and large."
  (when *safe-mode*
    (check-type small integer)
    (check-type large integer)
    (assert (< small large)))
  (+ small
     (random (1+ (- large small))
             (or seed (make-random-state t)))))

(defun puts (obj)
  "Print obj to standard output with trailing newline."
  (if (stringp obj)
      (write-line obj)
      (write-line (princ-to-string obj))))

(defun perror (obj)
  "Print obj to standard error with trailing newline."
  (if (stringp obj)
      (write-line obj *error-output*)
      (write-line (princ-to-string obj) *error-output*)))

(defun quit-with-status (&optional status)
  (declare ((nullable integer) status))
  "Quit a program with exit status"
  (when (null status)  ; Fallback to default status
    (setq status 0))   ;  when no status is assigned.
  (when *safe-mode*
    (check-type status integer))
  #+sbcl   (sb-ext:quit :unix-status status)
  #+ccl    (if (string= "Microsoft Windows" (software-type))
               (ccl:external-call "exit" :int status)
               (ccl:quit status))
  #+clisp  (ext:quit status)
  #+ecl    (ext:quit status)
  #+abcl   (ext:quit :status status)
  ; Fallback for uncommon CL implementation
  #-(or sbcl ccl clisp ecl abcl)
    (cl-user::quit status))

(defun compile-program (program main)
  (declare (string program) (function main))
  "Compile a program to an executable"
  (when *safe-mode*
    (check-type program string)
    (check-type main function))
  #+sbcl  (sb-ext:save-lisp-and-die program
                                    :toplevel main
                                    :executable t)
  #+ccl   (ccl:save-application program
                                :toplevel-function main
                                :prepend-kernel t)
  #+clisp (ext:saveinitmem program
                           :init-function main
                           :executable t
                           :quiet t
                           :script nil)
  #-(or sbcl ccl clisp)
    (error "Unsupported Common Lisp implementation"))

(defun argument-vector ()
  (declare (ftype (function () list) argument-vector))
  "Unprocessed argv (argument vector)"
  #+sbcl   sb-ext:*posix-argv*
  #+ccl    ccl:*command-line-argument-list*
  #+clisp  ext:*args*
  #+abcl   ext:*command-line-argument-list*
  #+ecl    (ext:command-args)
  #-(or sbcl ccl clisp abcl ecl)
    (error "Unsupported Common Lisp implementation"))

(defun argument ()
  (declare (ftype (function () list) argument))
  "Processed command-line argument(s)"
  (let* ((args (argument-vector))
         #+sbcl   (args (rest args))
         #+ccl    (args (rest (rest (rest (rest args)))))
         #+ecl    (args (rest (rest (rest args))))
         ; In ABCL and CLISP, no loading script in argument(s).
        )
    (cons *load-truename* args)))

(defun platform ()
  (declare (ftype (function () symbol) platform))
  "Detect platform type"
  #+sbcl   (cond ((string= "Win32" (software-type)) :windows)
                 ((string= "Darwin" (software-type)) :macos)
                 ((string= "Linux" (software-type)) :linux)
                 ((not (not (find :unix *features*))) :unix)
                 (t (error "Unknown platform")))
  #+ccl    (cond ((string= "Microsoft Windows" (software-type)) :windows)
                 ((string= "Darwin" (software-type)) :macos)
                 ((string= "Linux" (software-type)) :linux)
                 ((not (not (find :unix *features*))) :unix)
                 (t (error "Unknown platform")))
  #+clisp  (cond ((not (not (find :win32 *features*))) :windows)
                 ((not (not (find :macos *features*))) :macos)
                 ((string= "Linux"
                           (let ((s (ext:run-program "uname"
                                                     :output :stream)))
                             (read-line s)))
                   :linux)
                 ((not (not (find :unix *features*))) :unix)
                 (t (error "Unknown platform")))
  #+ecl    (cond ((string= "NT" (software-type)) :windows)
                 ((string= "Darwin" (software-type)) :macos)
                 ((string= "Linux" (software-type)) :linux)
                 ((not (not (find :unix *features*))) :unix)
                 (t (error "Unknown platform")))
  #+abcl   (cond ((not (not (find :windows *features*))) :windows)
                 ((string= "Mac OS X" (software-type)) :macos)
                 ((string= "Linux" (software-type)) :linux)
                 ((not (not (find :unix *features*))) :unix)
                 (t (error "Unknown platform")))
  #-(or sbcl ccl clisp ecl abcl)
    (error "Unsupported Common Lisp implementation"))
