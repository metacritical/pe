(require-extension stty srfi-14 ioctl)

(define (read-text)
  (let [[key-in (read-char)]]
     (write-string (format "~S " key-in))
     (if (not (eq? key-in #\q))
	 (read-text))))

(define text-buffer "")
(define screen-size (ioctl-winsize))
(define clear-screen "\x1b[2J")
(define reposition-cursor "\x1b[H")
(define get-cursor-position "\x1b[6n")
(define (editor-draw-rows)
  (let [[rows (car screen-size)]]
    (let loop [[step 0] [str ""]]
      (if (= step rows)
	  (write-string str)
	  (loop (+ step 1) (string-append str "~\r\n"))))))

(define (redraw-screen)
  (write-string (string-append clear-screen reposition-cursor)))

(define (setup-exit-routines) (on-exit redraw-screen))

((lambda []
   (redraw-screen)
   (setup-exit-routines)
   (editor-draw-rows)
   (write-string get-cursor-position)
   (write-string reposition-cursor)
   (with-stty '(not echo icanon isig ixon icrnl opost) read-text)))
