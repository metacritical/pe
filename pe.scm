(require-extension stty srfi-14)

(define (read-text)
  (display "=> ")
  (let loop []
    (let [[key-in (read-char)]]
     (display (format "~S " key-in))
     (if (not (eq? key-in #\q))
	 (loop)))))

(define (main-loop)
 (with-stty '(not echo icanon) read-text))

(main-loop)
