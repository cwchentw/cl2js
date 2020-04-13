; switch ((new Date()).getDay()) {
; case 0:
; case 6:
;     console.log("Weekend");
;     break;
; case 5:
;     console.log("Thank God. It's Friday!");
;     break;
; case 3:
;     console.log("Hump day");
;     break;
; default:
;     console.log("Week");
; }
(switch ((getprop (new (-Date)) 'get-day))
  (0 nil)
  (6 ((getprop console 'log) "Weekend")
       break)
  (5 ((getprop console 'log) "Thank God. It's Friday!")
       break)
  (3 ((getprop console 'log) "Hump day")
       break)
  (default
     ((getprop console 'log) "Week")))