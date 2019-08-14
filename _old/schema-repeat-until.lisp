;; *ETA-SCHEMA*: development version 6
;;
;; Dialogue for blocksworld conversation 
;; (intro + 30 questions +  outro)
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *eta-schema*

'(Event-schema (((set of me you) have-eta-dialog.v) ** ?e)
;```````````````````````````````````````````````````````````
; Blocksworld conversation. This consists of one or two "getting
; to know you" type questions, followed by a series of 10 questions.
;

:episodes 

?a1. (Me say-to.v you '(Hi\.))

?a2. (You reply-to.v ?a1.)

?e3. (:repeat-until (:context (?e3 finished2.a))
      
      ?a4. (Me say-to.v you '(Looping until user says goodbye\.))

      ?a5. (You reply-to.v ?a4.)

      ?a6. (:if
            ((:equal (ulf-of.f ?a5.) (GOODBYE.GR))
            ?a7. (:store-in-context '(?e3 finished2.a)))))

;; ?a3. (:store-in-context (ulf-of.f ?a2.))

;; ?a3. (:store-in-context '((THE.D ((POSS-BY ME.PRO) NAME.N)) ((PRES BE.V) (= |BEN |))))

?a8. (Me say-to.v you '(Bye\.))

)); end of defparameter *eta-schema*






(setf (get '*eta-schema* 'semantics) (make-hash-table))
;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(defun store-output-semantics (var wff schema-name)
  (setf (gethash var (get schema-name 'semantics)) wff)
); end of store-output-semantics

(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*eta-schema*))
  '()
); end of mapcar #'store-output-semantics




(setf (get '*eta-schema* 'gist-clauses) (make-hash-table))
;````````````````````````````````````````````````````````
; Gist clauses
;
(defun store-output-gist-clauses (var clauses schema-name)
  (setf (gethash var (get schema-name 'gist-clauses)) clauses)
); end of store-output-gist-clauses

(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*eta-schema*))
  '(
    (?a1.  ((what is your name ?)))
    (?a4.  ((do you have a spatial question ?)))
  )
); end of mapcar #'store-output-gist-clauses




(setf (get '*eta-schema* 'topic-keys) (make-hash-table))
;````````````````````````````````````````````````````````
; Topic keys
;
(defun store-topic-keys (var keys schema-name)
  (setf (gethash var (get schema-name 'topic-keys)) keys)
); end of store-topic-keys

(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*eta-schema*))
  '(
    (?a1.  (name))
  )
); end of mapcar