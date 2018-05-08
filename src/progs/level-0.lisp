(defpackage level-0
  (:documentation "Alisp program for Fractal Office domain.")

  (:use
  	fractal-office
	common-lisp
	utils
	alisp-prog)

  (:export
  	level-0
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

(in-package level-0)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; access functions for state
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(def-env-accessor dstn dst)
(def-env-accessor posn pos)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; partial program for Taxi domain
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun level-0 ()
	(until (equal (posn) (dstn))
		(with-choice l0-acts (pick '(N S E W))
			(action primitive pick))))

