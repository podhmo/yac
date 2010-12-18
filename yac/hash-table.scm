(define-module yac.hash-table
  (use gauche.hashutil)
  (use util.list :only (hash-table->alist alist->hash-table))
  (use yac.alias)
  (export-all))
(select-module yac.hash-table)

;;; create
(define (init n :optional (fn identity) (eq 'eq?))
  (rlet1 ht (make-hash-table eq)
    (dotimes (i n) (hash-table-put! ht i (fn i)))))

(define make make-hash-table)

;;; access
(define ref hash-table-get)
(define set! hash-table-put!)
(define push! hash-table-push!)
(define pop! hash-table-pop!)
(define update! hash-table-update!)
(define type hash-table-type)
(define keys hash-table-keys)
(define values hash-table-values)

;;; convert
(define alist hash-table->alist)
;; (define (alist ht) (hash-table-map ht cons))

(define from-alist alist->hash-table)
;; (define (from-alist alist :optional (eq 'eq?))
;;   (rlet1 ht (make-hash-table eq)
;;     (dolist (pair alist)
;;       (hash-table-put! ht (car pair) (cdr pair)))))

(define copy hash-table-copy)

;;; iterate

(define (each fn ht) (hash-table-for-each ht fn))
(define (map fn ht) (hash-table-map ht fn))
(define (foldl kons knil ht)
  (hash-table-fold ht 
                   (lambda (k v r) (kons r k v))
                   knil))

;;; predicate
(define exists? hash-table-exists?)

;;; transform
(define delete! hash-table-delete!)
(define clear! hash-table-clear!)
