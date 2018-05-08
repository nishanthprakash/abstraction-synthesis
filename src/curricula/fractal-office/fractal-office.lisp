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
	;utils
	;maze-mdp
  create-env
  ;env
  )


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
	   dst
	   nv
	   ))

(in-package fractal-office)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Type definitions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defstruct (fractal-office-state (:conc-name ""))
  pos
  ;pass-loc
  ;pass-source
  dst
  ;fuel
  nv)




(defclass <fractal-office> (<fully-observable-env>)
  ;((m :type maze-mdp:<maze-mdp>))
  ((destination :initarg :destination
          :reader destination)
  (m :initarg :maze-mdp
      :reader maze-mdp)
  (init-prob-dist :initarg :init-dist
       :reader init-dist
       :type prob:<prob-dist>))
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
  (let*
    ((m (maze-mdp:make-maze-mdp wm :allow-rests nil))
    (st (funcall (grid-world:unif-grid-dist-sampler m))))
    (make-instance '<fractal-office> :init-dist (prob:make-unif-dist-over-set (valid-states wm)) :maze-mdp m :destination st)))


(defun make-fractal-office (depth)
  (let 
    ((wm (make-office-map depth)))
    (make-office-env wm)))

;(defmethod sample-init :around ((e <fractal-office>))
;  (let* 
;    ((result (call-next-method))
;    (curr-state (make-fractal-office-state
;      :pos result)))
;    ;(print-object curr-state)
;    ;result))
;    curr-state))

;(defmethod reset-to-state :around ((e <fractal-office>) s)
;  (let* 
;    ((result (call-next-method))
;    (curr-state (make-fractal-office-state
;      :pos (env:get-state e))))
;    ;(print-object curr-state)
;    ;result))
;    curr-state))
;
;(defmethod sample-next :around ((e <fractal-office>) s a)
;  (progn
;    (multiple-value-setq (st rwd) (call-next-method))
;    (let
;      ((curr-state (make-fractal-office-state
;          :pos st)))
;      ;(print-object curr-state))
;      ;(values st rwd)))
;      (values curr-state rwd))))

(defparameter *avail-actions* '(N E S W))


(defmethod sample-init ((e <fractal-office>))
  (let*
      ((curr-mdp-state (prob:sample (init-dist e))))
      (make-fractal-office-state
        :pos curr-mdp-state
        :dst (destination e)
        :nv e)))

(defmethod reset-to-state ((e <fractal-office>) s)
  (set-state s e))

(defmethod reset ((e <fractal-office>) &optional reset-to-nonterminal-state)
  (set-state (sample-init e) e))

(defmethod sample-next ((e <fractal-office>) s a)
  (let* 
    ((mdp-action (cond ((eq a 'N) 'grid-world:N) ((eq a 'S) 'grid-world:S) ((eq a 'E) 'grid-world:E) ((eq a 'W) 'grid-world:W) (t nil) ))
    (m (maze-mdp e))
    (prev-mdp-state (pos s))
    (curr-mdp-state (prob:sample (maze-mdp:trans-dist m prev-mdp-state mdp-action)))
    (curr-env-state (make-fractal-office-state
        :pos curr-mdp-state
        :dst (destination e)
        :nv e)))
    (values curr-env-state (maze-mdp:reward m prev-mdp-state mdp-action curr-mdp-state))))

(defmethod is-terminal-state ((e <fractal-office>) s)
  (equal (dst s) (pos s)))

(defmethod avail-actions ((e <fractal-office>) s)
  *avail-actions*)
  ;(let* 
  ;   ((m (maze-mdp e))
  ;  (mdp-state (pos s)))
  ;  (maze-mdp:avail-actions m mdp-state)))


;(defmethod get-state ((e <fractal-office>)) 
;  )

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
  (let*
    ((wm (grid-world:world-map (maze-mdp (nv s))))
    (dim (first (array-dimensions wm))))
    (loop 
      ;with e = (env s)
      for i from 0 to (- dim 1)
      do (format str "~&") 
      do (loop 
        for j from 0 to (- dim 1) 
        do (cond ((or (= i -1) (= i dim) (= j -1) (= j dim))
            (format str "X"))
          ((not (aref wm i j)) 
            (format str "X"))
          ((equal (pos s) (list i j))
            (format str "O"))
          ((equal (dst s) (list i j))
            (format str "*"))
          (t (format str " ")))))))

(defmethod canonicalize ((s fractal-office-state))
  "convert to list"
  (list 'pos (pos s) 'dst (dst s)))


(in-package common-lisp-user)
