(define-module yac.list
  (use srfi-1)
  (export-all))

(select-module yac.list)

;;; create
(define init list-tabulate)
(define make make-list)

;;; iterate
(define each for-each)
;; (define map map)
;; (define fold fold)
;; (define fold-right fold-right)

