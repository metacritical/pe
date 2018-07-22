(require-extension stty srfi-1)
(require "core/keyboard.scm")

(define (read-text)
  (let [[key (read-char)]]
    (handle-kb key)))

(define (editor-draw-rows)
  (let loop [[step 0] [str ""] [rows (car screen-size)]]
    (if (< step rows)
	(loop (+ step 1) (to<-tmpb "\r\n") rows))))

(define (redraw-screen)
  (to<-tmpb (string-append hide-cursor clear-screen reset-cursor show-cursor)))

(define (post-draw-routine)
  (to<-tmpb (string-append hide-cursor reset-cursor show-cursor)))

(define (generate-new-buffer)
  '((cons 'name "(New file)")
    (cons 'cursor (cons 0 0))))

(system "stty -ixon")
(redraw-screen)
(editor-draw-rows)
(post-draw-routine)
(reify-buffer tmp-buffer)
(with-stty '(not echo icanon isig icrnl opost) read-text)
