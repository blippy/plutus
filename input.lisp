;;;; read in inputs

(in-package #:plutus)


(defun read-file (filename)
  (let ((in (open filename)))
    (loop for line = (read-line in nil :eof)
       until (eq line :eof)
       collect line)))

(defun get-inputs ()
  (read-file #p"~/repos/redact/docs/accts2018/accts2018v1.txt"))
;; (print (get-inputs))


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
;; (tokenise-line '())



(defun tokenise-inputs ()
  (let* ((nontrivial (loop for line in (get-inputs) when line collect line)))
    (loop for tokens in nontrivial
	 collect (tokenise-line tokens))))

;; (print (tokenise-inputs))

