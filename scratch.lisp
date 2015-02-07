;;;; (ql:quickload "plutus")
;;;; (load "scratch.lisp")
(in-package #:plutus)

(defvar *commands* (tokenise-inputs))

; TODO now process those commands !


(defclass inputs ()
  (comms etrans))
(defvar *inputs* (make-instance 'inputs))
(inspect *inputs*)

(loop for (cmd args) in (tokenise-inputs) do
      (alexandria:eswitch (cmd :test #'string-equal)
                          ("etran" (print "found etran"))
                          ("comm"  (print "found comm"))))

(ql:system-apropos "utilities")
(coerce "etran" 'symbol)
(equalp (intern "etran") 'etran)
(intern (string "foo"))
(describe 'alexandria)
#'switch
