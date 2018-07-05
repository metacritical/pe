(require-extension stty srfi-14)

(define (read-text)
  (let loop []
    (let [[key-in (read-char)]]
     (display (format "~S " key-in))
     (if (not (eq? key-in #\q))
	 (loop)))))

(define (main)
  (with-stty '(not echo icanon isig ixon icrnl opost) read-text))

(main)
