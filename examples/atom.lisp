;; Special characters.
; # is buggy in solo.
; ['bang', 'whathash', 'at', 'percent', 'slash', 'star', 'plus'];
'(! ?# @ % / * +)

;; Camel case word.
; 'fooBarBaz';
'foo-bar-baz

;; Pascal case word.
; 'FooBarBaz';
'*Foo-bar-baz
; 'FooBarBaz';
'-foo-bar-baz

;; All uppercase word.
; 'FOO_BAR_BAZ';
'*foo_bar_baz*

;; Word as-is.
; 'foo-bar';
:foo-bar

;; Number.
; 3.1415927
3.1415927
