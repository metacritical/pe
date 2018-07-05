(require-extension stty srfi-14)

(define (read-text)
  (let loop []
    (let [[key-in (read-char)]]
     (write-string (format "~S " key-in))
     (if (not (eq? key-in #\q))
	 (loop)))))

(define clear-screen "\x1b[2J")

(define reposition-cursor "\x1b[H")

(define (init-screen)
  (write-string clear-screen)
  (write-string reposition-cursor))

(define (main)
  (init-screen)
  (with-stty '(not echo icanon isig ixon icrnl opost) read-text))

(main)
