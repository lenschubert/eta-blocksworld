
; NIL for text mode
; T for speak mode
;; (defparameter *mode* t)
(defparameter *mode* NIL)
(defparameter *user-id* NIL)

; sessionInfo.lisp should be as following
; (setq *user-id* "456")

(setf *root-dir* *default-pathname-defaults*)

;-----------Text Mode-----------
  (if (or (not *mode*) (not (probe-file "sessionInfo.lisp")))
    (progn
      ;; (format t "~%~%Enter user-id ~%")
      ;; (princ "user id: ") (finish-output)
      ;; (setq *user-id* (write-to-string (read))))
      (setq *user-id* "test"))
;----------Speak Mode-----------
    (progn
      (load "sessionInfo.lisp")))
;-------------------------------

; Delete the content of the sessionInfo.lisp file after reading
(with-open-file (outfile "./sessionInfo.lisp" :direction :output :if-exists :supersede :if-does-not-exist :create))

; Delete the content of output.txt, if it exists, otherwise create
(with-open-file (outfile "./output.txt" :direction :output :if-exists 
                               :supersede :if-does-not-exist :create))

; Delete the content of input.lisp, if it exists, otherwise create
(with-open-file (outfile "./input.lisp" :direction :output :if-exists 
                               :supersede :if-does-not-exist :create))

; Delete the content of ulf.lisp, if it exists, otherwise create
(with-open-file (outfile "./ulf.lisp" :direction :output :if-exists 
                               :supersede :if-does-not-exist :create))

; Delete the content of reaction.lisp, if it exists, otherwise create
(with-open-file (outfile "./reaction.lisp" :direction :output :if-exists 
                               :supersede :if-does-not-exist :create))



; Create hash table to store gist clauses
(defvar *gist-kb* (make-hash-table :test #'equal)); for storage of gist
                ; clauses, particularly ones obtained from user inputs;
(clrhash *gist-kb*)


;
; Load ttt
;
(setf *temp-dir* "ttt/src")
(setf *default-pathname-defaults* (truename *temp-dir*))
(load "load")
(setf *default-pathname-defaults* *root-dir*)


;
; Load shared code
;
(setf *temp-dir* "core")
(setf *default-pathname-defaults* (truename *temp-dir*))
(mapcar (lambda (file) (load file))
    (directory "*.lisp"))

(mapcar (lambda (file) (load file))
    (directory "resources/*.lisp"))

(mapcar (lambda (file) (load file))
    (directory "schemas/*.lisp"))
(setf *default-pathname-defaults* *root-dir*)


;
; Start dialogue
;
(setf *temp-dir* "rules")
(setf *default-pathname-defaults* (truename *temp-dir*))
(mapcar (lambda (file) (load file))
    (directory "*.lisp"))

(mapcar (lambda (file) (load file))
    (directory "getting-to-know/*.lisp"))

(mapcar (lambda (file) (load file))
    (directory "spatial-question/*.lisp"))
(setf *default-pathname-defaults* *root-dir*)

;
; Run Eta
;
(handler-case (eta *mode*)
  (error (c)
    (format t "Execution of Eta failed due to an internal error.~%")
    (if *mode*
      (with-open-file (outfile "./output.txt" :direction :output
                                              :if-exists :append
                                              :if-does-not-exist :create)
      (format outfile "~%#: ~a" "Execution of Eta failed due to an internal error.")))
    (values 0 c)))

(setf *default-pathname-defaults* *root-dir*)