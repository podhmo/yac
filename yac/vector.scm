(define-module yac.vector
  (use srfi-43)
  (use yac.alias)
  (export fill! rcopy! copy! swap! reverse!
          every any 
          skipr skip indexr index 
          binary-search
          map!
          count length
          foldr/index foldl foldl/index map/index map each/index each
          empty?
          concat append
          copy rcopy
          from-rlist from-list rlist list 
          set! ref 
          unfoldr unfold 
          make init range))
(select-module yac.vector)

;;; create
(define (range from to :optional (d 1))
  (let* ((n (if (= d 1) (- to from) (ceiling->exact (/. (- to from) d))))
         (v (make-vector n)))
    (let loop ((i 0) (val from))
      (unless (>= i n)
        (vector-set! v i val)
        (loop (+ i 1) (+ val d))))
    v))

(define (init n :optional (fn identity))
  (rlet1 v (make-vector n)
    (dotimes (i n) (vector-set! v i (fn i)))))

(define make make-vector)
(define unfold vector-unfold)
(define unfoldr vector-unfold-right)

;;; access
(define ref vector-ref)
(define set! vector-set!)

;;; convert
(define list vector->list)
(define rlist reverse-vector->list)
(define from-rlist reverse-list->vector)
(define from-list list->vector)
(define rcopy vector-reverse-copy)
(define copy vector-copy)

;;; succ
(define append vector-append)
(define concat vector-concatenate) ;; quicker than apply append


;;; iterate

(define (each fn . vs)
  (define (%each1 fn v)
    (dotimes (i (vector-length v))
      (fn (vector-ref v i))))
  (define (%eachn fn vs)
    (let1 n (apply min (%map vector-length vs))
      (dotimes (i n)
        (apply fn (%map (cut vector-ref <> i) vs)))))
  (cond ((= 1 (%length vs)) (%each1 fn (car vs)))
        (else (%eachn fn vs))))

(define each/index vector-for-each)

(define (map fn . vs)
  (define (%map1 fn v)
    (let* ((len (vector-length v))
           (v* (make-vector len)))
      (dotimes (i len)
        (vector-set! v* i (fn (vector-ref v i))))
      v*))
  (define (%mapn fn vs)
    (let* ((len (apply min (%map vector-length vs)))
           (v* (make-vector len)))
      (dotimes (i len)
        (let1 item (apply fn (%map (cut vector-ref <> i) vs))
          (vector-set! v* i item)))
      v*))
  (cond ((= 1 (%length vs)) (%map1 fn (car vs)))
        (else (%mapn fn vs))))
               
(define map/index vector-map) 

(define (foldl/index kons knil . vs)
  (define (%fold1 kons knil v)
    (let1 len (vector-length v)
      (let loop ((knil knil) (i 0))
        (cond ((<= len i) knil)
              (else (loop (kons knil i (vector-ref v i)) (+ i 1)))))))
  (define (%foldn kons knil vs)
    (let1 len (apply min (%map vector-length vs))
      (let loop ((knil knil) (i 0))
        (cond ((<= len i) knil)
              (else 
               (let1 cars (%map (cut vector-ref <> i) vs)
                 (loop (apply kons knil i cars) (+ i 1))))))))
  (cond ((= 1 (%length vs)) (%fold1 kons knil (car vs)))
        (else (%foldn kons knil vs))))

(define (foldl kons knil . vs)
  (define (%fold1 kons knil v)
    (let1 len (vector-length v)
      (let loop ((knil knil) (i 0))
        (cond ((<= len i) knil)
              (else (loop (kons knil (vector-ref v i)) (+ i 1)))))))
  (define (%foldn kons knil vs)
    (let1 len (apply min (%map vector-length vs))
      (let loop ((knil knil) (i 0))
        (cond ((<= len i) knil)
              (else 
               (let1 cars (%map (cut vector-ref <> i) vs)
                 (loop (apply kons knil cars) (+ i 1))))))))
  (cond ((= 1 (%length vs)) (%fold1 kons knil (car vs)))
        (else (%foldn kons knil vs))))

(define foldr/index vector-fold-right)

;;; counting
(define length vector-length)
(define count vector-count)

;;; mutable-iterate
(define map! vector-map!)

;;; search
(define binary-search vector-binary-search)
(define index vector-index) ;; badname?
(define indexr vector-index-right) ;;
(define skip vector-skip) ;; badname?
(define skipr vector-skip-right) ;;

;;; predicate
(define empty? vector-empty?)
;; (define = vector=) ;;dangerours!!
(define any vector-any)
(define every vector-every)

;;; transform
(define reverse! vector-reverse!)
(define swap! vector-swap!)
(define copy! vector-copy!)
(define rcopy! vector-reverse-copy!)
(define fill! vector-fill!)
