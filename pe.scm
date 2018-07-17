(require-library extras utils posix)
(require-extension stty srfi-14 ioctl extras utils)
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

(define-record editor-config x y)

(define (exit-routines)
  (to<-tmpb clear-screen)
  (reify-buffer tmp-buffer))

(define (reify-buffer buff)
  (write-string buff)
  (clear-buffer buff))

;;Init Exit Routines
(on-exit exit-routines)

;;Init
(apply require '("core/init.scm"))
