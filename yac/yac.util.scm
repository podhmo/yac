(define-module yac.util
  (use srfi-1 :only (xcons))
  (export xcons xacons))

(define xcons xcons)
(define (xacons r x y)
  (cons (cons x y) r))