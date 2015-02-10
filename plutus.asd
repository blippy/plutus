;;;; plutus.asd

(asdf:defsystem #:plutus
  :serial t
  :depends-on (#:alexandria #:cl-fad ; #:lispbuilder-regex 
                            #:lispbuilder-lexer #:pcall-queue)
  :components ((:file "package")
               (:file "plutus")
               (:file "input")))
