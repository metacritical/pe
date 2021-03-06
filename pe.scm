#!/usr/local/bin/racket
#lang racket

(require racket/system)
(require charterm)

(define screen  (with-charterm (current-charterm)))
;; (define screen-size (charterm-screen-size screen))
(define clear-screen "\x1b[2J")
(define reset-cursor "\x1b[H")
(define get-cursor-position "\x1b[6n")
(define hide-cursor "\x1b[?25l")
(define show-cursor "\x1b[?25h")
(define (move-cursor-to x y) (format "\x1b[~S;~SH" y x))

;; (define (new-buffer name)
;;   (list (cons 'name name)
;; 	(cons 'path "")
;; 	(cons 'text "")
;; 	(cons 'changed #f)
;; 	(cons 'cursor '(0 . 0))
;; 	(cons 'permissions "rw")))

;; (define global-map
;;   (list (cons 'buffer-list (map new-buffer '("*scratch*" "*Messages*")))
;; 	(cons 'current-buffer "")
;; 	(cons 'frames '())
;; 	(cons 'windows '())
;; 	(cons 'mode-line '())
;; 	(cons 'echo-area "")))

;; (define (get-attr map-name attr)
;;   (filter (lambda (i) (eq? (car i) attr)) map-name))

;; (define (set-attr map-name key val)
;;   (let [[curr-buff (get-attr map-name key)]]
;;     (set! (cdar curr-buff) val)))

;; (define (current-buffer)
;;   (get-attr global-map 'current-buffer))

;; (define (update-global-map key val)
;;   (set-attr global-map key val))

;; (define (init-global-map)
;;   (set! global-map "Set buffer name etc..."))

;;Init
;; (include "core/init.scm")

(display screen)

 ;; (charterm-clear-screen)
