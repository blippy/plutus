;; https://stackoverflow.com/questions/48282586/saving-sbcl-image-from-emacs-multiple-threads-error

(load "plutus.asd")
(ql:quickload :plutus)
(sb-ext:save-lisp-and-die #p"plutus" :toplevel #'plutus:plutus-main
			  :executable t)
