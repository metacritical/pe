(require-extension stty)

(define (read-text)
  (let [[key-in (read-char)]]
     (write-string (format "~S " key-in))
     (if (not (eq? key-in #\q))
	 (read-text))))

(define (editor-draw-rows)
  (let [[rows (car screen-size)]]
    (let loop [[step 0] [str ""]]
      (if (< step rows)
	  (loop (+ step 1) (to<-tmpb "~\r\n"))))))

(define (redraw-screen)
  (to<-tmpb (string-append hide-cursor clear-screen reset-cursor show-cursor)))

(define (post-draw-routine)
  (to<-tmpb (string-append hide-cursor reset-cursor show-cursor)))

(redraw-screen)
(editor-draw-rows)
(post-draw-routine)
(reify-buffer tmp-buffer)
(with-stty '(not echo icanon isig ixon icrnl opost) read-text)
