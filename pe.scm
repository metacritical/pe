(require-extension stty srfi-14 ioctl)

;;(ioctl-winsize) for terminal size.

(define (read-text)
  (let loop []
    (let [[key-in (read-char)]]
     (write-string (format "~S " key-in))
     (if (not (eq? key-in #\q))
	 (loop)))))

(define (clear-screen) (write-string "\x1b[2J"))
(define (reposition-cursor) (write-string "\x1b[H"))

(define (init-screen)
  (clear-screen)
  (reposition-cursor))

(define (setup-exit-routines)
  (on-exit (lambda () (init-screen))))

(define (main)
  (init-screen)
  (setup-exit-routines)
  (with-stty '(not echo icanon isig ixon icrnl opost) read-text))

(main)
