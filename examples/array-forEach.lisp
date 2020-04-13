; var = ["foo", "bar", "baz", "qux"];
(defvar arr (array "foo" "bar" "baz" "qux"))

; arr.forEach(function (elem) {
;    console.log(elem);
; });
((getprop arr 'for-each)
   (lambda (elem) ((getprop console 'log) elem)))