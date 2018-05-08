(defpackage fractal-office-prog
  (:documentation "Alisp program for Fractal Office domain.")

  (:use td-taxi-env
	common-lisp
	utils
	alisp-prog)

  (:export fractal-office-prog
;	   N
;	   S
;	   E
;	   W
;	   loc
;	   task-choice
;	   task-choice-exit
;	   nav
;	   nav-choice
;	   nav-choice-exit
;	   nav-src
;	   nav-src-exit
;	   nav-dest
;	   nav-dest-exit
;	   get-pass
;	   put-pass
))

(in-package fractal-office-prog)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; access functions for state
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(def-env-accessor dst dst)
(def-env-accessor pos pos)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; partial program for Taxi domain
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun level-0 (loc)
	(until (equal pos loc)
		(with-choice l0-acts (pick '(N S E W))
			(action primitive pick))))


(defun level-1 (loc)
	(let* 
		((lpos (lnearest 1 pos))
		(lacts (lactions 1 lpos))
		(lnacts (concatenate lacts loc)))
		(until (equal pos loc)
			(with-choice l1-acts (pick lnacts)
				(call (level-0 pick))))))


(defun level-2 ()
	(let* 
		((lpos (lnearest 2 pos))
		(lacts (lactions 2 lpos))
		(lnacts (concatenate lacts loc)))
		(until (equal pos dst)
			(with-choice l2-acts (pick lnacts)
				(call (level-1 pick))))))


;(defmacro call-lactions (lacts n) 
;	(dolist (i lacts)
;		`(call (,level-fn ,i))))


;			    (choose l1-acts
;				    (call l1a (level-0 (nth )))
;				    (call l1a (level-0 ()))
;				    (call l1a (level-0 ()))
;				    (call l1a (level-0 ()))
;				    (call l1a (level-0 ()))
;				    (call l1a (level-0 ()))
;				    (call l1-l0 (level-0 loc))
;				    ))))

