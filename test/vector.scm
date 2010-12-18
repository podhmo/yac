(use gauche.experimental.lamb)
(add-load-path "../")
(use yac.vector :prefix v.)
(use yac.util :only (xcons))
(use gauche.test)

;; #?=(module-exports (find-module 'yac.vector))
(test-module (find-module 'yac.vector))

(test-start "vector.scm")
(test-section "create")

(test* "init" '#(0 1 2) (v.init 3 identity))
(test* "each" "01234" 
       (with-output-to-string (cute v.each display (v.init 5 identity))))
(test* "each" "00\n11\n22\n33\n44\n"
       (with-output-to-string (cute v.each print (v.init 5) (v.init 5))))
(test* "map/index" '#((0 0 0) (1 1 1) (2 2 2)) 
       (v.map/index list (v.init 3) (v.init 5)))
(test* "map" '#(0 1 4) (v.map (^x (* x x)) (v.init 3)))
(test* "map" '#((0 0) (1 1) (2 2)) (v.map list (v.init 3) (v.init 3)))
(test* "foldl" 6 (v.foldl + 0 (v.init 4)))
(test* "foldl" '(3 2 1 0) (v.foldl xcons '() (v.init 4)))
(test* "foldl" '((3 . 30) (2 . 20) (1 . 10) (0 . 0))
       (v.foldl (lambda (r x y) (acons x y r))
                '() (v.init 4) (v.init 4 (cut * <> 10))))

(test* "from-list" '#(1 2) (v.from-list '(1 2)))
(test* "list" '(1 2) (v.list #(1 2)))

(test-end)

(module-exports (find-module 'yac.vector))