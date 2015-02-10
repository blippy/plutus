;;;; (ql:quickload "plutus")
;;;; (load "scratch.lisp")
(in-package #:plutus)

;;(defparameter *commands* (tokenise-inputs))

(read-inputs)
;;;; TODO they are now in the ledger. The ledger needs to be processed
  
;;;; TODO  add to website
(alexandria:eswitch (action :test #'equal-string)
                    ("foo" (do-foo) )
                    ("bar"  (do-bar )))



;;; https://github.com/marijnh/pcall/blob/master/queue.lisp
(defparameter q (pcall-queue:make-queue))
(progn
  (setf q (pcall-queue:make-queue))
  (pcall-queue:queue-push 14 q)
  (pcall-queue:queue-push 15 q)
  (pcall-queue:queue-push 'wanganum q)
  (loop ;;until (pcall-queue:queue-empty-p q)
   for empty = (pcall-queue:queue-empty-p q)
   for el = (pcall-queue:queue-pop q)
   until empty
   ;;for foo = 1
   do (print el))
  t)
(inspect q)

(pcall-queue:queue-length q)
