(defpackage fractal-office
  (:documentation " fractal-office.lisp

The fractal-office environment consists of 
	2D office-cubes that have 3x3 states and have doors to the North, South, East and West of the center of the cube.
	3x3 of these cubes form a level-2 office-cube, that has only doors on the N, S, E, W of its center connecting other level-2 cubes.
	Similarly, level-3 cubes consist of 3x3 level-3 cubes, ..., and level n consisting of 3x3 level n-1 cubes, 
	forming a fractal structure but of limited depth.

The tasks (reward specifications) are to navigate from one part of this world to the other.  

Types
------
<fractal-office>

Examples
--------
make-office-env1
make-office-env2

Accessing parts of the state
----------------------------
pos
dest
env
fuel

Exported constants
------------------------------

Actions
'N
'S
'E
'W
'F (refuel)

")
  (:use common-lisp
	utils
	create-env
	maze-mdp)


  (:export <fractal-office>
	   make-example-env1
	   make-example-env2
	   N
	   S
	   E
	   W
	   pos
	   ;src
	   dest
	   env
	   ))

(in-package fractal-office)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Type definitions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defstruct (fractal-office-state (:conc-name ""))
  pos
  dest
  env)



(defclass <fractal-office> (<maze-mdp> <mdp-env>)
  (:documentation "
Constructor for <fractal-office> takes the following required initargs
:world-map - world map
:d - dest list.  Passenger dest sampled uniformly from these

and the following optional initargs
:wcc - wall collision cost.  .5 by default.
:msp - move success prob.  .9 by default.
:col - cost of living.  .1 by default."))
   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Constants
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(defparameter *avail-actions* (action-set e))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun make-office-env (world-map dest &key (dims (array-dimensions world-map)) (rewards (make-array dims :initial-element 0))
             (move-success-prob .9) (termination (make-array dims :initial-element nil))
             (collision-cost 1) (cost-of-living 1) (allow-rests nil))

  (make-instance '<fractal-office> :world-map world-map :legality-test #'identity
     :rewards rewards :msp move-success-prob :term termination
     :col-cost collision-cost :col cost-of-living
     :state-set (make-instance '<var-set> :element-type 'list :sets (list (consec 0 (1- (first dims))) (consec 0 (1- (second dims)))))
     :action-set (if allow-rests '(N E S W R)
             '(N E S W))
     :dest dest))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; operations from <env>
;;
;; TODO : many of these are reimplementing stuff that's
;; in gridworld
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defmethod sample-next ((e <fractal-office>) s a)
  (assert (member a (action-set e))  (a) "Action ~a not member of ~a" a (action-set e))
  (let* ((m (mdp e))
   (d (prob:sample (trans-dist e s a))))
    (values d (mdp:reward m s a d))))


(defmethod sample-init ((e <fractal-office>))
  (make-fractal-office-state
   :pos (funcall (unif-grid-dist-sampler e))
   ;:dest (prob:sample-uniformly (dest e))
   :env e))


(defmethod is-terminal-state ((e <fractal-office>) s)
  (terminal? e s))


(defmethod io-interface :before ((e <fractal-office>))
  (format t "~&Welcome to the fractal-office environment.  This environment models a taxi that moves around in a map, and must pick up a passenger and drop her off at the destination.  X's on the map represent walls and blank spaces are roads.  The taxi is represented by a t or T (capitalized once you have picked up the passenger).  The actions are 0,1,2,3 to move N,E,S,W, 4 to putdown the passenger, and 5 to pickup the passenger.~%~%"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; other methods on states
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun print-office-state ((s fractal-office-state) str)
  (let
    ((dim (first (array-dimensions office))))
    (loop 
      with e = (env s)
      for i from 0 to (- dim 1)
      do (format str "~&") 
      do (loop 
        for j from 0 to (- dim 1) 
        do (cond ((or (= i -1) (= i dim) (= j -1) (= j dim))
            (format str "X"))
          ((not (aref office i j)) 
            (format str "X"))
          ((equal (pos s) (list i j))
            (format str "O"))
          (t (format str " ")))))))

(defmethod clone ((s fractal-office-state))
  (make-fractal-office-state
   :dest (clone (dest s))
   :env (env s)
   :pos (clone (pos s))))

(defmethod same ((s fractal-office-state) (s2 fractal-office-state))
  (and
   (eq (env s) (env s2))
   (equal (pos s) (pos s2))
   (equal (dest s) (dest s2))))

(defmethod canonicalize ((s td-taxi-state))
  "convert to list"
  (list 'pos (pos s) 'dest (dest s)))


(in-package common-lisp-user)














