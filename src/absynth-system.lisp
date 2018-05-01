
; Use this asdf file instead of the one in hrl-system - this is an updated version. Comment loading of the one in hrl-system
(load "asdf/asdf.lisp")

(uiop:with-current-directory ("/Users/np/Projects/AbstractionSynthesis/programmable-reinforcement-learning/lisp/")
	(load "hrl-system.lisp")
	(make-all))

	;(load "test/test-all.lisp"))

