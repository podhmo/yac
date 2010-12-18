(use srfi-1)
(use gauche.experimental.lamb)
(add-load-path "../")
(use yac.hash-table :prefix ht.)
(use gauche.test)

;; #?=(module-exports (find-module 'yac.hash-table))
(test-module (find-module 'yac.hash-table))

(test-start "hash-table.scm")
(test-section "create")

(define sa (compose (cut sort-by <> car) ht.alist))

(test* "init" '((0 . 0) (1 . 1) (2 . 2)) (sa (ht.init 3 identity)))

(test* "each" "11\n00\n44\n33\n22\n"
       (with-output-to-string (cute ht.each print (ht.init 5))))
(test* "each"  "\n00\n11\n22\n33\n44"
       ((compose (cut string-join <> "\n") sort (cut string-split <> "\n"))
        (with-output-to-string (cute ht.each print (ht.init 5)))))

(test* "map" '((0 . 0) (1 . 1) (2 . 4)) 
       ((cut sort-by <> car)
        (ht.map (^ (k x) (cons k (* x x))) (ht.init 3))))

(test* "foldl" 6 (ht.foldl (lambda (n _ v) (+ n v)) 0 (ht.init 4)))
(test* "foldl" '(0 1 2 3) (sort (ht.foldl (lambda (r k v) (cons k r)) '() (ht.init 4))))

(test* "keys" '(1 3) (ht.keys (ht.from-alist '((1 . 2) (3 . 4)))))
(test* "values" '(2 4) (ht.values (ht.from-alist '((1 . 2) (3 . 4)))))

(test* "set!" '(2 4 100) 
       (let1 table (ht.from-alist '((1 . 2) (3 . 4)))
         (ht.set! table 10 100)
         (sort (ht.values table))))

(test* "update!" '(2 104) 
       (let1 table (ht.from-alist '((1 . 2) (3 . 4)))
         (ht.update! table 3 (cut + <> 100))
         (sort (ht.values table))))

(test* "complex expr" '((1 . 2) (3 . 40) (100 . 100))
       (let* ((alist '((1 . 2) (3 . 4) (5 . 6)))
              (ht (ht.from-alist alist 'eqv?)))
         (ht.set! ht 100 100)
         (ht.update! ht 3 (cut * 10 <>))
         (ht.delete! ht 5)
         (sort-by (ht.alist ht) car)))

(test* "length,make" '(("foo") ("bar") 1)
       (let1 table (ht.make 'string=?)
         (ht.set! table "foo" "bar")
         (list (ht.keys table) (ht.values table) (ht.length table))))
(test-end)

