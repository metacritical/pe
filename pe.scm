(require-extension stty srfi-14 ioctl)

(define (read-text)
  (let [[key-in (read-char)]]
     (write-string (format "~S " key-in))
     (if (not (eq? key-in #\q))
	 (read-text))))

(define tmp-buffer "")
(define (to<-tmpb str)
  (set! tmp-buffer (string-append tmp-buffer str)))

(define (clear-buffer buff)
  (set! buff ""))

(define screen-size (ioctl-winsize))
(define clear-screen "\x1b[2J")
(define reset-cursor "\x1b[H")
(define get-cursor-position "\x1b[6n")
(define hide-cursor "\x1b[?25l")
(define show-cursor "\x1b[?25h")

(define (editor-draw-rows)
  (let [[rows (car screen-size)]]
    (let loop [[step 0] [str ""]]
      (if (< step rows)
	  (loop (+ step 1) (to<-tmpb "~\r\n"))))))

(define (redraw-screen)
  (to<-tmpb (string-append hide-cursor clear-screen reset-cursor show-cursor)))

(define (post-draw-routine)
  (to<-tmpb (string-append hide-cursor reset-cursor show-cursor)))

(define (exit-routines)
  (to<-tmpb clear-screen)
  (reify-buffer tmp-buffer))

(define (reify-buffer buff)
  (write-string buff)
  (clear-buffer buff))

;;Init Exit Routines
(on-exit exit-routines)

((lambda []
   (redraw-screen)
   (editor-draw-rows)
   (post-draw-routine)
   (reify-buffer tmp-buffer)
   (with-stty '(not echo icanon isig ixon icrnl opost) read-text)))
