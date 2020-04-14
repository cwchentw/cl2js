(defmacro nullable (type-string obj)
  `(or (= null ,obj) (= ,type-string (typeof ,obj))))

(defun assert (condition &optional message)
  ((@ console 'assert) condition message))

(assert (nullable 'number 3))
(assert (nullable 'number nil))
(assert (not (nullable 'number "3")))
