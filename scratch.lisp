;;;; (ql:quickload "plutus")
;;;; (load "scratch.lisp")
(in-package #:plutus)


;;(defparameter *commands* (tokenise-inputs))

;;;; TODO need to reset inputs on each read!
(read-inputs)
;;;; TODO they are now in the ledger. The ledger needs to be processed

;;(inspect (slot-value *ledger* 'comm))
(print *ledger*)

