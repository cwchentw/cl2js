(defun assert (condition &optional message)
  ((getprop console 'assert) condition message))

; Elementary arithmetic operations.
(assert (= 7 (+ 3 4)))
(assert (= -1 (- 3 4)))
(assert (= 12 (* 3 4)))
(assert (= 0.75 (/ 3 4)))

; Logic AND operations.
(assert (= true (and true true)))
(assert (= false (and true false)))
(assert (= false (and false true)))
(assert (= false (and false false)))