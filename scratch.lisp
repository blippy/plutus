; (ql:quickload "alexandria")
; (ql:quickload "cl-fad")
; (ql:system-apropos "lex")
; (ql:quickload "cl-lex")
; (ql:quickload "lispbuilder-lexer")

;;;; (ql:quickload "plutus")

;(require :cl-fad);

;(defpackage #:plutus
;  (:use #:alexandria #:cl #:cl-fad #:cl-lex))

(in-package #:plutus)

(defun read-file (filename)
    (let ((in (open filename)))
      (loop for line = (read-line in nil :eof)
            until (eq line :eof)
            collect line)))

;            do (print line))))



;;;(cl-fad:walk-directory "/home/mcarter/redact/docs/accts2014/data" #'read-file)

(defun get-inputs ()
  (let ((dir1 (cl-fad:list-directory "/home/mcarter/redact/docs/accts2014/data"))
        (dir2 (cl-fad:list-directory "/home/mcarter/.ssa/gofi")))
    (alexandria:flatten
     (loop for filename in (append dir1 dir2) ; (cl-fad:list-directory "/home/mcarter/redact/docs/accts2014/data")
           collect (read-file filename)))))

;;(get-inputs)

;;(defparameter mylexer)

(lispbuilder-lexer:deflexer
 mylexer
 ;; ("[A-Z]+" (return (values :chunk   %0))); (read-from-string lispbuilder-lexer:%0))))
 ("\".*\"" (return lispbuilder-lexer:%0))
 ("#.*")
 ("\\S+" (return lispbuilder-lexer:%0))
 ("[:space:]"))



;(yacc:define-parser *myparser*


;(setq *lex* (mylexer "P       2014-04-05      18:06:57        NIL     1.0000 NIL"))
;(funcall *lex*)
;(funcall (mylexer "21"))

;(defparameter line "FIN P vis    \"      Visa                                                      \"")
(defun tokenise-line (line)
  (let ((lex (mylexer  line)))
    (loop
     ;for i from 1 to 15
     for token = (funcall lex)
     while token
     collect token)))


;;(tokenise-line line)

(defun tokenise-inputs () 
;;  (mapcar #'tokenise-line (get-inputs)))
  (loop for line in (get-inputs)
        for tokens = (tokenise-line line)
        when tokens collect tokens))

(tokenise-inputs)

