(defun write-line (text)
  ((getprop console 'log) text))

(switch ((getprop (new (-Date)) 'get-day))
  (0 nil)  ; Fallthrough
  (6 (write-line "Weekend")
       break)
  (5 (write-line "Thank God. It's Friday!")
       break)
  (3 (write-line "Hump day")
       break)
  (default
     (write-line "Week")))