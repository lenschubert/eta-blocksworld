(defparameter *eta-schema*

'(Event-schema (((set of me you) have-eta-dialog.v) ** ?e)
;```````````````````````````````````````````````````````````
; Blocksworld conversation. This consists of one or two "getting
; to know you" type questions, followed by a series of 10 questions.
;

:episodes 

?a1. (Me say-to.v you '(Hi\.))

?a2. (You reply-to.v ?a1.)

?a3. (:if
      ((ulf-of.f ?a2.) ((THE.D ((POSS-BY ME.PRO) NAME.N)) ((PRES BE.V) (= |BEN |))))
        ?a4. (Me say-to.v you '(Wow\, that\'s a nice name\.))
        ;; ?a4. (:if
        ;;       (A A)
        ;;         ?a5. (Me say-to.v you '(Cool\.)))
      ((ulf-of.f ?a2.) ((THE.D ((POSS-BY ME.PRO) NAME.N)) ((PRES BE.V) (= |BOB |))))
        ?a4. (Me say-to.v you '(That\'s a weird name\.))
      :default
        ?a4. (Me say-to.v you '(It\'s very nice to meet you\.)))

;; ?a3. (:store-in-context (ulf-of.f ?a2.))

;; ?a3. (:store-in-context ((THE.D ((POSS-BY ME.PRO) NAME.N)) ((PRES BE.V) (= |BEN |))))

?a6. (Me say-to.v you '(Bye\.))

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