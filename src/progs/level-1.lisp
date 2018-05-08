(defpackage level-1
  (:documentation "Alisp program for Fractal Office domain.")

  (:use 
  	fractal-office
	common-lisp
	utils
	alisp-prog
	;fo-tgraph
	)

  (:export
  	level-1
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

(in-package level-1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; access functions for state
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(def-env-accessor dstn dst)
(def-env-accessor posn pos)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; partial program for Taxi domain
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun level-0 (loc)
	(until (equal (posn) loc)
		(with-choice l0-acts (pick '(N S E W))
			(action primitive pick))))


(defun level-1 ()
	(let* 
		((lpos (fo-tgraph:lnearest 1 (posn)))
		(lacts (fo-tgraph:lactions 1 lpos))
		(lnacts (append lacts (list (dstn)))))
		(until (equal (posn) (dstn))
			;(format t lnacts)
			(with-choice l1-acts (pick lnacts)
				(call (level-0 pick))))))


