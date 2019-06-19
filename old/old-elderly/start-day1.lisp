;;
;; Day 1
;;

;in the new dialogues take care of
;./input.lisp
;./output.txt


; At the very begining of the first day for each user make a gist-kb file. This file contains the knowledge base
; collected during sessions. We have one file corresponding to each id. At the end of each session we append
; the session's knowledge to that file (using the user's id)

(defvar *gist-kb* (make-hash-table :test #'equal)); for storage of gist
                ; clauses, particularly ones obtained from user inputs;
(clrhash *gist-kb*)

;; (setf *mode* nil)
(setf *root-dir* *default-pathname-defaults*)


; global counter for the output file
(defvar *global-count*); 
(setq *global-count* 0)

; ************ clear the output.txt file if it exists, if it doesn't create one
(with-open-file (outfile "./output.txt" :direction :output :if-exists 
                               :supersede :if-does-not-exist :create))



;
; load ttt
;

(setf *temp-dir* "ttt/src")
(setf *default-pathname-defaults* (truename *temp-dir*))

(load "load")

(setf *default-pathname-defaults* *root-dir*)
;(setq *ttt-addr* "C:/inetpub/wwwroot/RocSpeakRafayet/ttt/ttt/src/load")


;
; load shared code
;

(setf *temp-dir* "elderly/Core")
(setf *default-pathname-defaults* (truename *temp-dir*))
(load "lissa5"); lissa5.lisp is the main Lissa code
(load "choose-doolittle-response-1.lisp")  ; rule part of original data.lisp
(load "general-word-data-5.lisp") ; generic word-level stuff from data.lisp
(load "choose-reactions-to-input.lisp")
(load "choose-reaction-to-question.lisp")
(load "choose-wff-extraction-trees-for-input.lisp")
(load "schema-for-reactions-to-answer-plus-question.lisp")
(load "schema-for-reactions-to-question+clause.lisp")

(setf *default-pathname-defaults* *root-dir*)

;================================
;    Getting to know you
;================================

(setf *temp-dir* "elderly/Day1/GettingToKnow")
(setf *default-pathname-defaults* (truename *temp-dir*))
(load "start-lissa5")

(setf *default-pathname-defaults* *root-dir*)
(print *default-pathname-defaults*)

;================================
;    Where are you from
;================================

(setf *temp-dir* "elderly/Day1/WhereAreYouFrom")
(setf *default-pathname-defaults* (truename *temp-dir*))
(load "start-lissa5")
(setf *default-pathname-defaults* *root-dir*)

;================================
;    Activities you like to do
;================================

(setf *temp-dir* "elderly/Day1/Activities")
(setf *default-pathname-defaults* (truename *temp-dir*))
(load "start-lissa5")
(setf *default-pathname-defaults* *root-dir*)


;delete the content of the sessionInfo.lisp file
(with-open-file (outfile "./sessionInfo.lisp" :direction :output :if-exists :supersede :if-does-not-exist :create))


;
; store the extracted knowledge
; append the content of the hash table *gist-kb* to the file "gist-kb/X.txt" in which X is the user's id (get it from *user-id*)
;

(setq kb-file-name (ensure-directories-exist (concatenate 'string "gist-kb/" *user-id* ".txt")))

;; If file exists overwrite it with empty file
(with-open-file (outfile kb-file-name :direction :output :if-exists :supersede :if-does-not-exist :create))

(maphash #'(lambda (key val)
                   (with-open-file (outfile kb-file-name :direction :output :if-exists
                           :append :if-does-not-exist :create)
                   (format outfile "~% ~a   ~a" key val)))
           *gist-kb*)
