(require-library extras utils posix)
(require-extension srfi-14 ioctl extras utils)
(use posix)

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
(define (move-cursor-to x y) (format "\x1b[~S;~SH" y x))

(define (exit-routines)
  (to<-tmpb clear-screen)
  (to<-tmpb reset-cursor)
  (reify-buffer tmp-buffer))

(define (reify-buffer buff)
  (write-string buff)
  (clear-buffer buff))

(define global-map
  (list (cons 'buffer-list '())
	(cons 'frames '())
	(cons 'windows '())
	(cons 'mode-line '())
	(cons 'echo-area "")))

;;Init Exit Routines
(on-exit exit-routines)

;;Init
(require "core/init.scm")
