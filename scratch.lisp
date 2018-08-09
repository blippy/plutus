;;;; (ql:quickload "plutus")
;;;; (load "scratch.lisp")
(in-package #:plutus)

(defun process-etran (rec)
  ;;(declaim (sb-ext:muffle-conditions cl:style-warning))
  ;;(print rec)
  (multiple-value-bind (cmd dstamp acc epic qty amount way desc) (values-list rec)
    ; silence unused variables
    (setf cmd t)
    (setf dstamp t)
    (setf amount t)
    ;;(setf way t)
    (setf desc t)
    ;;(setf qty (with-input-from-string (in qty) (read qty)))
    (setf qty (parse-float qty))
    (print qty)
    t))

(defun find-and-process-etrans ()
  (loop for rec in (tokenise-inputs)
     when (string= (car rec) "etran-2")
     do (process-etran rec)))


(find-and-process-etrans)


(ql:system-apropos "parse")
