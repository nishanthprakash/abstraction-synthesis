;(defpackage play
;  (:use 
;   utils
;   common-lisp
;   td-taxi-env
;   td-taxi-prog
;   alisp-user
;   td-taxi-prog-features
;   policy
;   ))

;(in-package play)

;(setf e (td-taxi-env:make-example-env1))
;(setf p #'td-taxi-prog:td-taxi-prog)

;(setf smdpq (alisp-smdpq:make-smdpq-alg :hist-out-dir "test/temp"))
;(setf hordq (make-instance 'ahq:<hordq>))
;(setf gs (alisp-gold-standard:make-alisp-gold-standard-learning-alg))
;(setf hsa (make-instance 'ahq:<hordq> :features *featurizer*))

;(alisp-user:learn p e 'random (list hordq smdpq gs hsa) 20000 :hist-length 20)

;; since smdpq uses temporary files, delete them
;(reset smdpq)


; (do-symbols (s (find-package "CL-USER")) (when (search "TAXI" (symbol-name `,s)) (print s)))

(in-package cl-user)

;(let 
;	((wm (let 
;		((a (make-array '(2 3) :initial-element t)))
;		(setf (aref a 0 1) nil)
;		a)))
;	(print (maze-mdp:make-maze-mdp wm)))

;(make-instance 'prod-set:<var-set> :element-type 'list :sets (list (utils:consec 0 (1- 3)) (utils:consec 0 (1- 3))))


;(let 
;	((a (make-array '(2 2))))
;	(setf (aref a 0 0) 1)
;	(setf (aref a 0 1) 0.5)
;	(setf (aref a 1 0) 2)
;	(setf (aref a 1 1) 0.5)
;	(print ((prob:sample a))))

;(defparameter *wm* (make-office-map 0))


;(in-package grid-world)

;(let* 
;	((gw (make-instance 'grid-world:<grid-world> :world-map *wm*))
;	(grid (grid-world:world-map gw))
;	(dims (array-dimensions grid))
;	(locs (loop
;	   for i below (first dims)
;	   append (loop
;	        for j below (second dims)
;	        if (aref grid i j)
;	        collect (list i j))))
;	(initial-dist (prob:make-unif-dist-over-set locs)))
;	initial-dist)


(setf e (fractal-office:make-fractal-office 0))
(rl-user:io-interface e2)


(maze-mdp:avail-actions (maze-mdp-env:maze-mdp e) '(2 3))

(mdp:terminal? (mdp-env:mdp e) '(2 3))

(maze-mdp:terminal? (mdp-env:mdp e) '(2 3))

(maze-mdp:trans-dist (maze-mdp-env:maze-mdp e) '(2 3) 'grid-world:N)

(setf wm (fractal-office:make-office-map 0))
(setf m (maze-mdp:make-maze-mdp wm))
(maze-mdp:avail-actions m '(2 3))

(setf e (make-instance 'maze-mdp-env:<maze-mdp-env> :init-dist (prob:make-unif-dist-over-set (fractal-office:valid-states wm)) :maze-mdp m))
(setf e2 (make-instance 'fractal-office:<fractal-office> :init-dist (prob:make-unif-dist-over-set (fractal-office:valid-states wm)) :maze-mdp m))

(maze-mdp:avail-actions (maze-mdp-env:maze-mdp e2) '(2 3))




(setf e (td-taxi-env:make-example-env1))

; grid-world:N
