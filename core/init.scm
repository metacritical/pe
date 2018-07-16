(require-extension stty)

(define (read-text)
  (let [[key-in (read-char)]]
    (cond [(eq? key-in #\x01) (print "Ctrl-a")]
	  (else (read-text)))))

(define (editor-draw-rows)
  (let loop [[step 0] [str ""] [rows (car screen-size)]]
    (if (< step rows)
	(loop (+ step 1) (to<-tmpb "~\r\n") rows))))

(define (redraw-screen)
  (to<-tmpb (string-append hide-cursor clear-screen reset-cursor show-cursor)))

(define (post-draw-routine)
  (to<-tmpb (string-append hide-cursor reset-cursor show-cursor)))

(redraw-screen)
(editor-draw-rows)
(post-draw-routine)
(reify-buffer tmp-buffer)
(with-stty '(not echo icanon isig ixon icrnl opost) read-text)


;; (write-string (format "~S " key-in))
;; (if (not (eq? key-in #\q))
	 ;; (read-text))
