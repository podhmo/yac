(define-module yac.alias
  (export-all))

(select-module yac.alias)
;;;alias
(define %length (with-module scheme length))
(define %map (with-module scheme map))
(define %fold (with-module gauche fold))
(define %values (with-module scheme values))
(define %update! (with-module gauche update!))
(define %ref (with-module gauche ref))
(define %set! (with-module null set!))
