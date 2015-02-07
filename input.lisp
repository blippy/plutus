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
