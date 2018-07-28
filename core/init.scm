(require-extension stty srfi-1 srfi-13)
(require "core/keyboard.scm")

(define (read-key)
  (let [[key (read-char)]]
    (handle-kb key)))

(define (redraw-screen)
  (to<-tmpb (string-append hide-cursor clear-screen reset-cursor show-cursor)))

(define (post-draw-routine)
  (to<-tmpb (string-append hide-cursor reset-cursor show-cursor)))

(define (get-buffer-list)
  (filter (lambda (i) (eq? (car i) 'buffer-list)) global-map))

(define (generate-new-buffer)
  (let [[buff (new-buffer "New Buffer")][buff-lst (car (get-buffer-list))]]
    (set! (cdr buff-lst) (cons buff (cdr buff-lst)))))

(system "stty -ixon")
(redraw-screen)
(generate-new-buffer)
(post-draw-routine)
(reify-buffer tmp-buffer)
;; (pp global-map)
(with-stty '(not echo icanon isig icrnl opost) read-key)
