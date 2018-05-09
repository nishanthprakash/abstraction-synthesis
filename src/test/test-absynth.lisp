
(in-package test-absynth)

(alisp-user:learn p0 e1 'random smdpq0 50000000 :hist-length 100)
(alisp-user:learn p1 e1 'random smdpq1 50000000 :hist-length 100)

(alisp-user:learn p0 e1 'random gs0 50000000 :hist-length 100)
(alisp-user:learn p1 e1 'random gs1 50000000 :hist-length 100)

(alisp-user:on-policy-learning p0 e1 'random smdpqo0 50000000 :hist-length 100)
(alisp-user:on-policy-learning p1 e1 'random smdpqo1 50000000 :hist-length 100)

(alisp-user:on-policy-learning p0 e1 'random gso0 50000000 :hist-length 100)
(alisp-user:on-policy-learning p1 e1 'random gso1 50000000 :hist-length 100)


(setf sph0 (alisp-user:get-policy-hist smdpq0))
(setf sph1 (alisp-user:get-policy-hist smdpq1))

(setf gsh0 (alisp-user:get-policy-hist gs0))
(setf gsh1 (alisp-user:get-policy-hist gs1))

(setf spho0 (alisp-user:get-policy-hist smdpqo0))
(setf spho1 (alisp-user:get-policy-hist smdpqo1))

(setf gsho0 (alisp-user:get-policy-hist gso0))
(setf gsho1 (alisp-user:get-policy-hist gso1))


(setf evls0 (alisp-user:evaluate p0 e1 sph0 :num-steps 1000 :num-trials 5))
(setf evls1 (alisp-user:evaluate p1 e1 sph1 :num-steps 1000 :num-trials 5))

(setf evlg0 (alisp-user:evaluate p e gsh0 :num-steps 1000 :num-trials 5))
(setf evlg1 (alisp-user:evaluate p e gsh1 :num-steps 1000 :num-trials 5))

(setf evls0 (alisp-user:evaluate p0 e1 spho0 :num-steps 1000 :num-trials 5))
(setf evls1 (alisp-user:evaluate p1 e1 spho1 :num-steps 1000 :num-trials 5))

(setf evlg0 (alisp-user:evaluate p e gsho0 :num-steps 1000 :num-trials 5))
(setf evlg1 (alisp-user:evaluate p e gsho1 :num-steps 1000 :num-trials 5))