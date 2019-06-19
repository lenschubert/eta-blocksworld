
; NIL for text mode
; T for speak mode
(setq *mode* NIL)

; sessionInfo.lisp should be as following
; (setq *user-id* "456")
; (setq *session-number* "2")

;delete the content of the sessionInfo.lisp file
(with-open-file (outfile "./sessionInfo.lisp" :direction :output :if-exists :supersede :if-does-not-exist :create))
                    


; Then we will remove the following:
(setq *user-id* nil)
(setq *session-number* nil)


(setf *root-dir* *default-pathname-defaults*)

(setq c 1)
(loop while (eq c 1) do
    (loop while (or (not *user-id*) (not *session-number*)) do   ; while at least one of these variable doesn't have a value
        ;-----------Text Mode-----------
        (if (not *mode*)
            (progn
              (format t "~%~%Enter user-id and session number (type exit to quit) ~%")
              (princ "user id: ") (finish-output)
              (setq *user-id* (write-to-string (read)))
              (princ "session number: ") (finish-output)
              (setq *session-number* (write-to-string (read))))
        ;----------Speak Mode-----------
            (progn
             (sleep .5)     ; read the file every .5 sec
             (load "sessionInfo.lisp")))
        ;-------------------------------
        (if (or (string= *user-id* "EXIT") (string= *session-number* "EXIT"))
           (setq c 0)
           (if (and *user-id* *session-number*) ; if the variables both have value, print the values and load the right file
                (progn
                    (format t "User ID is = ~a ~%" *user-id*)
                    (format t "Day number is = ~a ~%" *session-number*)
                    ;delete the content of the sessionInfo.lisp file
                    (with-open-file (outfile "./sessionInfo.lisp" :direction :output :if-exists :supersede :if-does-not-exist :create))
                    (setq session-to-load (concatenate 'string "start-day" *session-number* ".lisp"))
                    (if (probe-file session-to-load)
                        (load session-to-load)
                        (print "The session number is invalid!"))
                    (setq *user-id* nil)
                    (setq *session-number* nil))))
))
