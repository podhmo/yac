yac = yet another collection
===========================

experiment

yac.list
--------

    (use yac.vector :prefix v.)

    ;;create    
    (v.init 3) ; => #(0 1 2)
    (v.init 3 (lambda (x) (* x x))) ; => #(0 1 4)

    ;;iteration
    (with-output-to-string (cute v.each print (v.init 3))) ; => "0\n1\n2\n"
    (v.map (cut * <> 10) (v.init 3)) ; => #(0 10 20)
    (v.foldl (lambda (r x) (cons x r)) '() (v.init 3)) ; => '(2 1 0)    
