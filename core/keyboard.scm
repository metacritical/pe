(define key-map
  '(["ESC" #\escape]
    ["TAB" #\tab]
    ["DEL" #\delete]
    ["BKSPC" #\backspace]
    ["RET" #\return]
    ["C-a" #\x01]
    ["C-b" #\x02]
    ["C-c" #\x03]
    ["C-d" #\x04]
    ["C-e" #\x05]
    ["C-f" #\x06]
    ["C-g" #\alarm]
    ["C-h" #\backspace]
    ["C-i" #\tab]
    ["C-j" #\newline]
    ["C-k" #\vtab]
    ["C-l" #\page]
    ["C-m" #\return]
    ["C-n" #\xe]
    ["C-o" #\xf]
    ["C-p" #\x10]
    ["C-q" #\x11]
    ["C-r" #\x12]
    ["C-s" #\x13]
    ["C-t" #\x14]
    ["C-u" #\x15]
    ["C-v" #\x16]
    ["C-w" #\x17]
    ["C-x" #\x18]
    ["C-y" #\x19]
    ["C-z" #\x1a]))

(define (get-keycode str)
  (find (lambda (kmap) (eq? (car kmap) str)) key-map))

(define (kbd key-seq)
  "Returns key code for string")



(define (handle-kb key)
  (if (not (eq? key #\q))
      (begin
	(cond [(eq? key #\x03) (display (format "~S" key))]
	      [(eq? key #\x11) (display "Ctrl-q")]
	      [(eq? key #\escape) (display (format "~S" key))]
	      [(eq? key #\[) (display "Bracket \n")]
	      [(eq? key #\A) (display "UP \n")]
	      (else (display (format "~S" key))))
	(read-text))))
