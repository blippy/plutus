;;;; read in inputs

(in-package #:plutus)

(defun read-file (filename)
    (let ((in (open filename)))
      (loop for line = (read-line in nil :eof)
            until (eq line :eof)
            collect line)))

(defun get-inputs ()
  (let ((dir1 (cl-fad:list-directory "/home/mcarter/redact/docs/accts2014/data"))
        (dir2 (cl-fad:list-directory "/home/mcarter/.ssa/gofi")))
    (alexandria:flatten
     (loop for filename in (append dir1 dir2)
           collect (read-file filename)))))




(lispbuilder-lexer:deflexer
 mylexer
 ("\".*\"" (return lispbuilder-lexer:%0))
 ("#.*")
 ("\\S+" (return lispbuilder-lexer:%0))
 ("[:space:]"))


(defun tokenise-line (line)
  (let ((lex (mylexer  line)))
    (loop
     ;for i from 1 to 15
     for token = (funcall lex)
     while token
     collect token)))




(defun tokenise-inputs () 
  (loop for line in (get-inputs)
        for tokens = (tokenise-line line)
        when tokens collect tokens))

(defparameter *schema*
  '(("comm" store comm input-fields (sym dload type unit exc ticker name))
    ("echo" echo)
    ("etran" store etran input-fields (dstamp way acc sym qty amount))
    ("FIN" drop)
    ("nacc" drop)
    ("ntran" drop)
    ("P" store price input-fields (dstamp tstamp sym unit))
    ("period" drop)
    ("return" drop)))



(defclass ledger ()
  (comm etran price))


(defmethod initialize-instance ((instance ledger) &rest initargs)
  (loop for slot in '(comm etran price)
        do
        ;;(setf (slot-value instance slot) (pcall-queue:make-queue)))
        (setf (slot-value instance slot) nil)
  t))



(defparameter *ledger* (make-instance 'ledger))




;;;; create the classes from the schema description
(loop for (name action . rest)  in *schema*
      do 
      (when (equalp action 'STORE)
        (let ((name (first rest))
              (slots (third rest)))
          ;;(format t "creating class ~a ~a ~%" name slots)
          (eval `(defclass ,name () ,slots))
          t)))

;;;; begin schema action dispatcher

(defun echo (schema-entry args)
  (format *standard-output* "~a~%" (car args)))

(defun drop (schema-entry args) nil) ; just do nothing

(defun store(schema-entry args)
  (let* ((class (third schema-entry))
         (input-fields (fifth schema-entry))
         (ledger-slot (slot-value *ledger* class) )
         (c (make-instance class)))
    (loop for field-name in input-fields
          for arg in args
          do
          (setf (slot-value c field-name) arg))
    ;;(pcall-queue:queue-push c ledger-slot)
    (setf (slot-value *ledger* class) (append ledger-slot (list c)))
    ;;(if ledger-slot (push c (cdr (last ledger-slot)))
    ;;  (setf ledger-slot (list c)))
    t))


;;;; end schema action dispatcher


(defun read-inputs ()
  "Read inputs, tokenise them, decode them, and add to them to the *ledger*"
  (setf *ledger* (make-instance 'ledger))
  (loop for (cmd . args) in (tokenise-inputs)
        for schema-entry = (find cmd *schema* :test #'string-equal :key #'car)
        for action = (second schema-entry)
        do
        (funcall action schema-entry args))
  t)

