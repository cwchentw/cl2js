; Custom-made assertion.
(defun assert (condition &optional message)
  ((getprop console 'assert) condition message))

; Create an object literal.
(defvar de2en (create :eins :one
                      :zwei :two
                      :drei :three))

; Validate data at runtime.
(assert (equal :one (getprop de2en :eins)))
(assert (equal :two (getprop de2en :zwei)))
(assert (equal :three (getprop de2en :drei)))
(assert (not (defined (getprop de2en :vier))))
