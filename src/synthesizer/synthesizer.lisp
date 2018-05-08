
(defpackage synthesizer
  (:documentation "Package containing a simple implementation of the partial programs synthesizer.

")

  (:use 
   common-lisp)
  (:export
   synthesize
   ))

(in-package synthesizer)

(setf macro-actions (('N 'S 'E 'W) ('l1-b1 'l1-b2 'l1-b3 'l1-b4 'l1-b5 'l1-b6) ('l2-b1 'l2-b2 'l2-b3 'l2-b4 'l2-b5 'l2-b6)))

(defmacro synthesize (mactions)
   (let* 
      ((num-levels (list-length mactions)))
      `(progn ;,@(gen-levels 2)
      ,@(loop for i from 0 to (- num-levels 1) collecting 
         `(gen-macro ,i 'mactions)))))

;(package (symbol-package synthesize))

(defmacro gen-macro (n mactions)
   (let*
      ((level-actions (nth n mactions))
      (level-fn (intern (format nil "LEVEL-~a" n) *PACKAGE*))
      ((next-level-fn (format nil "LEVEL-~a" (- n 1)))))
      `(defun ,level-fn (loc)
         (let*
            ((axcall (lambda (x) (if () 'call 'action))))
            (until (equal (pos) loc)
               (with-choice level-choice (level-pick ,(concatenate level-actions next-level-fn))
               ((axcall level-pick) level-do level-pick)))))))


;(defun l0 () 
;  (let* 
;      ((axcall (lambda (x) (if (or (and (is-node x) (has-children x tree)) (x 'l1)) 'call 'action)))
;      (l1goals (level-goals 1 tree))
;      (l1goal-axns (map get-bottleneck-actions l1-goals)))
;      (loop
;        (with-choice l0-choice (l1-pick (concatenate l1goals l1goal-axns l1))
;          ((axcall l1-pick) l1-do l1-pick)))))
;


;(macroexpand-1 '(gen-macro 1 (1 2 3)))

;(macroexpand-1 '(synthesize (1 2 3)))

;(defun get-curr-package ()
;   (print *PACKAGE*))