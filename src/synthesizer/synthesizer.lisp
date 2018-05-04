
(defpackage synthesizer
  (:documentation "Package containing a simple implementation of trees in which nodes and edges can be labelled.

")

  (:use 
   common-lisp)
  (:export
   synthesize
   ))

(in-package synthesizer)


(defmacro synthesize (mactions)
   (let* 
      ((num-levels (list-length mactions)))
      `(progn ;,@(gen-levels 2)   
      ,@(loop for i from 0 to (- num-levels 1) collecting 
         `(gen-macro ,i 'mactions)))))


(defmacro gen-macro (n mactions)
   (let*
      ((nth n mactions)
      ;(package (symbol-package synthesize))
      (level-fn (intern (format nil "LEVEL-~a" n) *PACKAGE*)))
      `(defun ,level-fn () 'levelfn-called)))


;(macroexpand-1 '(gen-macro 1 (1 2 3)))

;(macroexpand-1 '(synthesize (1 2 3)))

;(defun get-curr-package ()
;   (print *PACKAGE*))