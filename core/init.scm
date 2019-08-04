(require-extension stty srfi-1 srfi-13)
(include "keyboard.scm")

(define tmp-buffer "")

(define (to<-tmpb str)
  (set! tmp-buffer (string-append tmp-buffer str)))

(define (clear-buffer buff)
  (set! buff ""))

(define (exit-routines)
  (to<-tmpb clear-screen)
  (to<-tmpb reset-cursor)
  (reify-buffer tmp-buffer))

(define (reify-buffer buff)
  (write-string buff)
  (clear-buffer buff))

(define (redraw-screen)
  (to<-tmpb (string-append hide-cursor clear-screen reset-cursor show-cursor)))

(define (post-draw-routine)
  (to<-tmpb (string-append hide-cursor reset-cursor show-cursor)))

(define (get-buffer-list)
  (filter (lambda (i) (eq? (car i) 'buffer-list)) global-map))

(define (set-current-buffer buff)
  (let [[name (get-attr buff 'name)]]
    (update-global-map 'current-buffer (cdar name))))

(define (generate-new-buffer)
  (let [[buff (new-buffer "New Buffer")][buff-lst (car (get-buffer-list))]]
    (set! (cdr buff-lst) (cons buff (cdr buff-lst)))
    (set-current-buffer buff)))

(define (read-key)
  (let [[key (read-char)]]
    (handle-kb key)))

;;Init Exit Routines
(on-exit exit-routines)

;;Disable suspend and quit.
(system "stty -ixon")

(redraw-screen)
(generate-new-buffer)
(post-draw-routine)
(reify-buffer tmp-buffer)
(pp global-map)
(with-stty '(not echo icanon isig icrnl opost) read-key)
