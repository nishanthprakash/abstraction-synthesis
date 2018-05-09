(defpackage test-absynth
  (:use 
   utils
   common-lisp
   fractal-office
   level-0
   level-1
   level-2
   alisp-user
   policy
   ))

(in-package test-absynth)




(format t "~&Testing Absynth code")
(fill-format-nl #\= 60)
(format t "~&Creating objects")


;(defparameter *depth* 1)

;(defun get-obs-len (d)
;  (- (floor (* (+ d 1) (+ d 2)) 2) 2))

;(defun get-obs-index (i j)
;  (+ j (floor (* i (+ i 1)) 2) -1))

;(setf e (loop for i from 1 upto *depth* collect (fractal-office:make-fractal-office i)))
;(setf p (loop for i from 0 upto *depth* collect (symbol-function (intern (format nil "LEVEL-~a" i) (format nil "LEVEL-~a" i)))))
;(setf smdpq (loop for i from 0 upto (get-obs-len *depth*) collect (alisp-smdpq:make-smdpq-alg :hist-out-dir "test/temp") ))


;(setf e0 (fractal-office:make-fractal-office 0))
(setf e1 (fractal-office:make-fractal-office 1))
;(setf e2 (fractal-office:make-fractal-office 2))

(setf p0 #'level-0:level-0)
(setf p1 #'level-1:level-1)
;(setf p2 #'level-2:level-2)
;(setf pf2 #'flat-2:level-0)

(setf smdpq0 (alisp-smdpq:make-smdpq-alg :hist-out-dir "test/temp"))
(setf smdpq1 (alisp-smdpq:make-smdpq-alg :hist-out-dir "test/temp"))

(setf gs0 (alisp-gold-standard:make-alisp-gold-standard-learning-alg))
(setf gs1 (alisp-gold-standard:make-alisp-gold-standard-learning-alg))

(setf smdpqo0 (alisp-smdpq:make-smdpq-alg :hist-out-dir "test/temp"))
(setf smdpqo1 (alisp-smdpq:make-smdpq-alg :hist-out-dir "test/temp"))

(setf gso0 (alisp-gold-standard:make-alisp-gold-standard-learning-alg))
(setf gso1 (alisp-gold-standard:make-alisp-gold-standard-learning-alg))


;(setf hsa (make-instance 'ahq:<hordq> :features *featurizer*))

;(dolist (env e) (dolist (prg p) (alisp-user:learn prg env 'random (list hordq smdpq gs hsa) 20000 :hist-length 20)))

;(loop for i from 1 upto *depth* do
;  (loop for j from 0 upto i do 
;    (let*
;      ((env (nth i e))
;      (prg (nth j p))
;      (sq (nth (get-obs-index i j) smdpq)))
;      (alisp-user:learn prg env 'random sq 20000 :hist-length 20))))

;(terpri)
;(alisp-user:learn p2 e2 'random '() 20000 :hist-length 20)
;(alisp-user:learn p0 e2 'random '() 20000 :hist-length 20)
;(alisp-user:learn p e 'random '() 20000 :hist-length 20)

;(alisp-user:learn p-flat e 'random '() 20000 :hist-length 20)
;(alisp-user:learn p e 'random '() 20000 :hist-length 20)
;(alisp-user:learn pf2 e 'random '() 20000 :hist-length 20)

;(alisp-user:learn p-flat e 'random (list hordq smdpq gs hsa) 20000 :hist-length 20)

;(alisp-user:learn p0 e1 'random (list hordq smdpq gs hsa) 20000 :hist-length 20)

;(alisp-user:learn p2 e1 'random (list hordq smdpq gs hsa) 20000 :hist-length 20)

;(terpri)

;(let*
;  ((i 1)
;  (j 0)
;  (env (nth i e))
;  (prg (nth j p))
;  (sq (nth (+ (* 2 (- i 1)) j) smdpq)))
;  (alisp-user:learn prg env 'random sq 10000 :hist-length 100))
;

;(let*
;  ((i 1)
;  (j 1)
;  (env (nth i e))
;  (prg (nth j p))
;  (sq (nth (+ (* 2 (- i 1)) j) smdpq)))
;  (alisp-user:learn prg env 'random sq 1000000 :hist-length 1000))


;(setf evl0 (let*
;  ((i 1)
;  (j 0)
;  (env (nth i e))
;  (prg (nth j p)))
;  (alisp-user:evaluate prg env sph0 :num-steps 10000 :num-trials 10)))

;(setf evl1 (let*
;  ((i 1)
;  (j 1)
;  (env (nth i e))
;  (prg (nth j p)))
;  (alisp-user:evaluate prg env sph1 :num-steps 10000 :num-trials 10)))



;(setf sqh0 (get-q-hist smdpq0))
;(setf sqh1 (get-q-hist smdpq1))

;(rl-user:io-interface e1 (set:item 1 sqh0) (set:item 1 sqh1) (set:item 10 sqh0) (set:item 10 sqh1) (set:item 45 sqh0) (set:item 45 sqh1))

;(setf sq-pol-hist (loop for i from 0 upto (get-obs-len *depth*) collect (alisp-user:get-policy-hist (nth i smdpq))))
;(setf sq-q-hist (loop for i from 0 upto (get-obs-len *depth*) collect (get-q-hist (nth i smdpq))))
;(setf sq-rews 
;  (loop for i from 1 upto *depth* append
;    (loop for j from 0 upto i append
;      (list 
;        (let*
;          ((env (nth i e))
;          (prg (nth j p))
;          (sph (nth (get-obs-index i j) sq-pol-hist)))
;          (alisp-user:evaluate prg env sph :num-steps 1000 :num-trials 10))))))

;(format t "~%~%Learning curves for SMDPQ are ~a"


;(setf sq-rews (loop for i from 0 upto 4 collect (alisp-user:evaluate p e sq-pol-hist :num-steps 25 :num-trials 5)))

;(setf sq-pol-hist (alisp-user:get-policy-hist smdpq))
;(setf sq-q-hist (get-q-hist smdpq))
;(setf sq-rews (alisp-user:evaluate p e sq-pol-hist :num-steps 25 :num-trials 5))
;(setf hq-rews (alisp-user:evaluate p e (alisp-user:get-policy-hist hordq) :num-steps 25 :num-trials 5))
;(setf gs-rews (alisp-user:evaluate p e (alisp-user:get-policy-hist gs) :num-steps 25 :num-trials 5))
;(setf hqs-rews (alisp-user:evaluate p e (alisp-user:get-policy-hist hsa) :num-steps 25 :num-trials 5))


;(format t "~%~%Learning curves for SMDPQ, HORDQ, HORDQ-SA, and GS are ~a"
;	(map 'vector #'list sq-rews hq-rews hqs-rews gs-rews))

;; since smdpq uses temporary files, delete them
;(reset smdpq)