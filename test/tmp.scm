(add-load-path "../")
(use yac.list :prefix L.)
(use gauche.test)

;; #?=(module-exports (find-module 'yac.list))
(test-module (find-module 'yac.list))

(test-start "list.scm")
(test-section "create")

(test* "init" '(0 1 2) (L.init 3 identity))
(test* "each" "01234" (with-output-to-string (cute L.each display (L.init 5 identity))))

(test-end)