(define key-map
  '(["ESC" #\escape]
    ["TAB" #\tab]
    ["DEL" #\delete]
    ["BKSPC" #\backspace]
    ["RET" #\return]
    ["C-a" #\x1]
    ["C-b" #\x2]
    ["C-c" #\x3]
    ["C-d" #\x4]
    ["C-e" #\x5]
    ["C-f" #\x6]
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

(define (kbd str)
   (filter (lambda (kmap) (equal? str (car kmap))) key-map))

(define (kbd-seq code)
  (filter (lambda (kmap) (eq? code (cadr kmap))) key-map))

(define (handle-kb key)
  (if (not (eq? key #\q))
      (let [[code (kbd-seq key)]]
	(if (null? code)(display key) (display (caar code)))
	(read-text))))
