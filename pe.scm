(require-extension stty srfi-14)

(define (read-text prompt)
    (display prompt)
    (let [[input (read-char)]]
     (format "+> ~S" input)))

(define (main-loop)
 (with-stty '(echo icanon) (read-text "=> ")))

(main-loop)
