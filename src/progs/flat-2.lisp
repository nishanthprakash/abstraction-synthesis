(defpackage flat-2
  (:documentation "Alisp program for Fractal Office domain.")

  (:use
  	fractal-office
	common-lisp
	utils
	alisp-prog)

  (:export flat-2
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

(in-package flat-2)

(defun nshuffle (sequence)
  (loop for i from (length sequence) downto 2
        do (rotatef (elt sequence (random i))
                    (elt sequence (1- i))))
  sequence)
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
		(with-choice l0-acts (pick (nshuffle '((1 1) (2 2) (3 3) (4 4))))
			(let*
				((pk (cond ((equal pick '(1 1)) 'N) ((equal pick '(2 2)) 'S) ((equal pick '(3 3)) 'E) ((equal pick '(4 4)) 'W))))
				(action primitive pk)))))