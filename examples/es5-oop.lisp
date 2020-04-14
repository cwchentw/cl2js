; ES5-style class.
(defvar *Point 
  (lambda (x y)
   (let ((_x 0.0)
         (_y 0.0))
     ; Getter and setter of `x`
     ((getprop *Object 'define-property) this 'x 
        (create :get (lambda () _x)
                :set (lambda (v) (setq _x v))))
     ; Getter and setter of `y`
     ((getprop *Object 'define-property) this 'y
        (create :get (lambda () _y)
                :set (lambda (v) (setq _y v))))
     (setq _x x)
     (setq _y y)
     this)))

; Function binding to `Point` class.
(setf (getprop *Point 'prototype 'distance-to)
      (lambda (p) 
        (sqrt (+ (expt (- (getprop this 'x) (getprop p 'x)) 2)
                 (expt (- (getprop this 'y) (getprop p 'y)) 2)))))

; Custom-made assertion.
(defun assert (condition &optional message)
  ((getprop console 'assert) condition message))

; Main function.
(let ((p (new (*Point 0.0 0.0)))
      (q (new (*Point 3.0 4.0))))
  (assert (= 5.0 ((getprop p 'distance-to) q)))
  
  ; Mutate `q`
  (setf (getprop q 'x) 5.0)
  (setf (getprop q 'y) 12.0)

  (assert (= 13.0 ((getprop p 'distance-to) q))))
