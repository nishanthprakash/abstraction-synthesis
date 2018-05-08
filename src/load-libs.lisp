; Use this asdf file instead of the one in hrl-system - this is an updated version. Comment loading of the one in hrl-system
(load "asdf/asdf.lisp")

;library sources from ~/.local/share/common-lisp/source

;(asdf:operate 'asdf:load-op 'alexandria)

;(asdf:operate 'asdf:load-op 'metabang-bind)

;(asdf:operate 'asdf:load-op 'named-readtables)

;(asdf:operate 'asdf:load-op 'curry-compose-reader-macros)

;(asdf:operate 'asdf:load-op 'graph)

(asdf:operate 'asdf:load-op 'hrl)


;(uiop:with-current-directory ("/Users/np/Projects/AbstractionSynthesis/programmable-reinforcement-learning/lisp/")
;	(load "hrl-system.lisp")
;	(make-all))

	;(load "test/test-all.lisp"))