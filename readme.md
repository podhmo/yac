yac = yet another collection (interface for scheme)

===========================

experiment

yac.vector
--------

    (use yac.vector :prefix v.)
    (use yac.util :only (xcons))

    ;;create    
    (v.init 3) ; => #(0 1 2)
    (v.init 3 (lambda (x) (* x x))) ; => #(0 1 4)
    (v.range 8 10))  ; => #(8 9)
    (v.range 1 10 3) ; => #(1 4 7)

    ;;iteration
    (with-output-to-string (cute v.each print (v.init 3))) ; => "0\n1\n2\n"
    (v.map (cut * <> 10) (v.init 3)) ; => #(0 10 20)
    (v.foldl (lambda (r x) (cons x r)) '() (v.init 3)) ; => '(2 1 0)    
    (v.foldl xcons '() (v.init 3)) ; => '(2 1 0)

    ;;convert
    (v.list #(1 2)) ; => (1 2)
    (v.from-list '(1 2)) ; => #(1 2)

yac.hash-table
--------------

    (use yac.hashtable :prefix ht.)

    (let* ((alist '((1 . 2) (3 . 4) (5 . 6)))
           (ht (ht.from-alist alist 'eqv?)))
      (ht.set! ht 100 100)
      (ht.update! ht 3 (cut * 10 <>))
      (ht.delete! ht 5)
      (sort-by (ht.alist ht) car))
     ; => ((1 . 2) (3 . 40) (100 . 100))
     
    (let1 table (ht.make 'string=?)
      (ht.set! table "foo" "bar")
      (list (ht.keys table) (ht.values table) (ht.length table)))
     ; => (("foo") ("bar") 1)
