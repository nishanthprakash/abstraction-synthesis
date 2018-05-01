(in-package cl-user)


(defun print-office (office)
	(let
		((dim (first (array-dimensions office))))
		(loop for i from 0 to (- dim 1)
			do (format t "~&") 
			do (loop for j from 0 to (- dim 1) do 
				(cond 
					((or (= i -1) (= i dim) (= j -1) (= j dim))
			    		(format t "X")) ;█
			    	((eq (aref office i j) nil) 
			       		(format t "X"))
					(t (format t " ")))))))

(defun get-dim (depth)
	(+ (* 5 (expt 3 depth)) (- (expt 3 depth)) 1))

(defun build-boundary (dim office pos)
	(let 
		((x (first pos))
		(y (second pos)))
		(loop for i from 0 upto (- dim 1) do
			(when (not (= i (/ (- dim 1) 2)))
				;(print x)
				(setf (aref office (+ x i) y) nil)
				(setf (aref office x (+ y i)) nil)
				(setf (aref office (+ x i) (+ y (- dim 1))) nil)
				(setf (aref office (+ x (- dim 1)) (+ y i)) nil)))))

(defun build-walls (depth office pos)
	(if (< depth 0)
		office
		(let 
			((dim (get-dim depth))
			(p (first pos))
			(q (second pos)))
			;(print `(,dim ,depth ,pos))
			;(print-office office)
			(build-boundary dim office pos) ; build levels boundary walls
			;(print office)
			(loop for x from p upto (+ p (- dim 2)) by (/ (- dim 1) 3) do
				(loop for y from q upto (+ q (- dim 2)) by (/ (- dim 1) 3) do
					(build-walls (- depth 1) office `(,x ,y)))))))

(defun make-office-map (depth)
	(let* 
		((dim (get-dim depth))
		(office (make-array `(,dim ,dim) :initial-element t)))
		(build-walls depth office '(0 0))
		office))

(defun fractal-office-samples ()
	(loop for i from 0 upto 3 do
		(format t "office: depth ~a" i)
		(print-office (make-office-map i))
		(format t "~2%")))

;(+ (* 5 (expt 3 0)) (- (expt 3 0)) 1)