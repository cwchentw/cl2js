; Custom-made assertion.
(defun assert (condition &optional message)
  ((getprop console 'assert) condition message))

; Run an assertion at runtime.
(assert (= 4 (lisp (1+ 3))) "It should be 4")
