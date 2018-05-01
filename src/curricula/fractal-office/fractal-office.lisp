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
	maze-mdp
  maze-mdp-env)


  (:export <fractal-office>
     make-fractal-office
     make-office-env
     make-office-map
     ;valid-states ; delete this later
	   N
	   S
	   E
	   W
	   pos
	   dest
	   env
	   ))

(in-package fractal-office)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Type definitions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defclass <fractal-office> (<maze-mdp-env>)
  ;((m :type maze-mdp:<maze-mdp>))
  ((dest  :initarg :dest
          :reader dest))
  (:documentation "
Constructor for <fractal-office>"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(defun make-office-env (world-map &key (dest (sample-valid-loc world-map)) (dims (array-dimensions world-map)) (rewards (make-array dims :initial-element 0))
;             (move-success-prob 1) (termination (setf (aref (make-array dims :initial-element nil) (first dest) (second dest)) t))
;             (collision-cost 1) (cost-of-living 1) (allow-rests nil))
;
;  (let* 
;    ((locs (valid-states world-map))
;    (initial-dist (prob:make-unif-dist-over-set locs)))
;    (make-instance '<fractal-office>
;       :dest dest
;       :init-dist initial-dist
;       :maze-mdp (make-maze-mdp world-map 
;          :allow-rests allow-rests
;          :rewards rewards
;          :move-success-prob move-success-prob
;          :termination termination
;          :collision-cost collision-cost 
;          :cost-of-living cost-of-living))))

(defun make-office-env (wm)
  (let 
    ((m (maze-mdp:make-maze-mdp wm :allow-rests nil)))
    (make-instance '<fractal-office> :init-dist (prob:make-unif-dist-over-set (valid-states wm)) :maze-mdp m)))


(defun make-fractal-office (depth)
  (let 
    ((wm (make-office-map depth)))
    (make-office-env wm)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; other methods on states
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun valid-states (world-map)
  (let*
    ((grid world-map)
    (dims (array-dimensions grid))
    (locs (loop
       for i below (first dims)
       append (loop
            for j below (second dims)
            if (aref grid i j)
            collect (list i j)))))
    locs))

(defun sample-valid-loc (world-map)
  (let
    ((locs (valid-states world-map)))
    (elt locs (random (length locs)))))



(defmethod print-object ((s fractal-office-state) str)
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

(in-package common-lisp-user)
