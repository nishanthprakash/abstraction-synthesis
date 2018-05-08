(defpackage fo-tgraph
  (:documentation " ")
  (:use common-lisp)
  (:export lnearest
  	lactions))

(in-package fo-tgraph)

(defparameter *default-dim* 13)

;(defvar *graph* (graph:populate (make-instance 'graph:graph)
;	:nodes '(1 2 3 4 5 6 7)
;	:edges-w-values '(((1 2) . 3)
;		((2 4) . 1)
;		((2 3) . 2)
;		((3 5) . 1)
;		((4 5) . 2)
;		((5 6) . 3))))
;
;(graph:nodes *graph*)
;
;(graph:edge-value *graph* '(4 5))
;
;(graph:node-edges *graph* '2)
;
;
;(defvar *graph2* (graph:populate (make-instance 'graph:graph)
;	:nodes '('(1 1) '(2 1) '(3 1) '(4 1) '(5 1) '(6 1) '(7 1))
;	:edges-w-values '(('(1 2) . 3)
;		(('(2 1) '(4 1)) . 1)
;		(('(2 1) '(3 1)) . 2)
;		(('(3 1) '(5 1)) . 1)
;		(('(4 1) '(5 1)) . 2)
;		(('(5 1) '(6 1)) . 3))))

;(defun make-fo-transition-graph (depth)
;	(let* 
;		((wm (fractal-office:make-office-map depth)))
;		(loop for level from 0 to depth do
;			(make-bn-graph level)))
;
;	)

;(loop for i upto 3 append (loop for j upto 3 append `((,i ,j))))

;(defun to-row-order (pos dim)
;	((* (first pos) dim) (second pos)))
;
;(defun from-row-order (pos dim)
;	(multiple-value-bind (q r) (floor pos dim) `(,q ,r)))

(defun get-start (level)
	(* 2 (expt 3 (- level 1))))

(defun get-step (level)
	(* 4 (expt 3 (- level 1))))

(defun get-dim (depth)
	(+ (* 5 (expt 3 depth)) (- (expt 3 depth)) 1))

(defun bottlenecks (level dim)
	(loop for i from (get-start level) upto (- dim 1) by (get-step level) append
		(loop for j from 0 upto (- dim 1) by (get-step level) append
			`((,i ,j) (,j ,i)))))

(defun vertical-bottlenecks (level dim)
	(loop for i from (get-start level) upto (- dim 1) by (get-step level) append
		(loop for j from 0 upto (- dim 1) by (get-step level) append
			`((,j ,i)))))

(defun horizontal-bottlenecks (level dim)
	(loop for i from (get-start level) upto (- dim 1) by (get-step level) append
		(loop for j from 0 upto (- dim 1) by (get-step level) append
			`((,i ,j)))))

(defun lnearest (level pos &optional (dim *default-dim*))
	(let* 
		((bns (bottlenecks level dim)))
		(reduce (lambda (x y) (if (< (sq-dist pos y) (sq-dist pos x)) y x)) bns)))

(defun lactions (level pos &optional (dim *default-dim*))
	(let* 
		((vbns (vertical-bottlenecks level dim))
		(hbns (horizontal-bottlenecks level dim))
		(a1 (get-step level))
		(hacts (list 	
					(list 0 a1) 
					(list 0 (- a1)) 
					(list (/ a1 2) (/ a1 2)) 
					(list (- (/ a1 2)) (/ a1 2)) 
					(list (/ a1 2) (- (/ a1 2))) 
					(list (- (/ a1 2)) (- (/ a1 2)))))
		(vacts (list 
					(list a1 0) 
					(list (- a1) 0) 
					(list (/ a1 2) (/ a1 2)) 
					(list (- (/ a1 2)) (/ a1 2)) 
					(list (/ a1 2) (- (/ a1 2))) 
					(list (- (/ a1 2)) (- (/ a1 2))))))
		(cond 
			((member pos vbns :test 'equal) (remove-if-not (lambda (x) (and (< (first x) dim) (< (second x) dim) (>= (first x) 0) (>= (second x) 0))) (map 'list (lambda (x) (list (+ (first pos) (first x)) (+ (second pos) (second x)))) vacts)))
			((member pos hbns :test 'equal) (remove-if-not (lambda (x) (and (< (first x) dim) (< (second x) dim) (>= (first x) 0) (>= (second x) 0))) (map 'list (lambda (x) (list (+ (first pos) (first x)) (+ (second pos) (second x)))) hacts)))
			(t nil))))

(defun sq(n) (* n n))

(defun sq-dist (loc1 loc2)
	(+ (sq (- (first loc1) (first loc2))) (sq (- (second loc1) (second loc2)))))




