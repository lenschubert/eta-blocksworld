
; NIL for text mode
; T for speak mode
(defparameter *mode* t)
;; (defparameter *mode* NIL)
(defparameter *safe-mode* NIL)
(defparameter *user-id* NIL)

; sessionInfo.lisp should be as following
; (setq *user-id* "456")

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
(with-open-file (outfile "./answer.lisp" :direction :output :if-exists 
                               :supersede :if-does-not-exist :create))



; Create hash table to store gist clauses
(defvar *gist-kb* (make-hash-table :test #'equal)); for storage of gist
                ; clauses, particularly ones obtained from user inputs;
(clrhash *gist-kb*)


; Load ttt
;``````````
(load (truename "ttt/src/load.lisp"))


; Load core code
; (in directory 'core/')
;````````````````````````
(mapcar (lambda (file) (load file))
    (directory "core/*.lisp"))


; Load core resources
; (in directory 'core/resources/')
;``````````````````````````````````
(mapcar (lambda (file) (load file))
    (directory "core/resources/*.lisp"))


; Load schema files
; (in directory 'schemas/')
;````````````````````````````
(mapcar (lambda (file) (load file))
    (directory "schemas/*.lisp"))


; Load general rule files
; (in directory 'rules/')
;`````````````````````````
(mapcar (lambda (file) (load file))
    (directory "rules/*.lisp"))


; Load topic-specific rule files
; (in subdirectories of 'rules/')
;`````````````````````````````````
(mapcar (lambda (directory)
    (mapcar (lambda (file) (load file))
        (directory (concatenate 'string (namestring directory) "/*.lisp"))))
    (remove nil (mapcar (lambda (p) (if (not (pathname-name p)) p)) (directory "rules/*"))))


; Run Eta
;``````````
(if *safe-mode*
  (handler-case (eta *mode*)
    (error (c)
      (error-message "Execution of Eta failed due to an internal error." *mode*)
      (values 0 c)))
  (eta *mode*))