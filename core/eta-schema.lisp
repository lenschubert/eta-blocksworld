;; *ETA-SCHEMA*: development version 6
;;
;; Dialogue for blocksworld conversation 
;; (intro + 10 questions +  outro)
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *eta-schema*

'(Event-schema (((set of me you) have-eta-dialog.v) ** ?e)
;```````````````````````````````````````````````````````````
; Blocksworld conversation. This consists of one or two "getting
; to know you" type questions, followed by a series of 10 questions.
;

:Actions 

?a1. (Me say-to.v you 
      '(Hi I am Eta\. I\'m here to help answer some spatial questions for you\.))

?a2. (Me say-to.v you 
      '(Before we begin\, would you mind telling me what your name is?))

?a3. (You reply-to.v ?a2.)

?a4. (Me react-to.v ?a3.)

; 1
?a5. (Me say-to.v you
      '(Do you have a spatial question for me?))

?a6. (You reply-to.v ?a5.)

?a7. (Me react-to.v ?a6.)

; 2
?a8. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a9. (You reply-to.v ?a8.)

?a10. (Me react-to.v ?a9.)

; 3
?a11. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a12. (You reply-to.v ?a11.)

?a13. (Me react-to.v ?a12.)

; 4
?a14. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a15. (You reply-to.v ?a14.)

?a16. (Me react-to.v ?a15.)

; 5
?a17. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a18. (You reply-to.v ?a17.)

?a19. (Me react-to.v ?a18.)

; 6
?a20. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a21. (You reply-to.v ?a20.)

?a22. (Me react-to.v ?a21.)

; 7
?a23. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a24. (You reply-to.v ?a23.)

?a25. (Me react-to.v ?a24.)

; 8
?a26. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a27. (You reply-to.v ?a26.)

?a28. (Me react-to.v ?a27.)

; 9
?a29. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a30. (You reply-to.v ?a29.)

?a31. (Me react-to.v ?a30.)

; 10
?a32. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a33. (You reply-to.v ?a32.)

?a34. (Me react-to.v ?a33.)



?a35. (Me say-to.v you
        '(Excellent questions\, but unfortunately all that
          thinking has been very tiring\, so I need to take a break now\.))

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
    (?a2.  ((what is your name ?)))
    (?a5.  ((do you have a spatial question ?)))
    (?a8.  ((do you have a spatial question ?)))
    (?a11. ((do you have a spatial question ?)))
    (?a14. ((do you have a spatial question ?)))
    (?a17. ((do you have a spatial question ?)))
    (?a20. ((do you have a spatial question ?)))
    (?a23. ((do you have a spatial question ?)))
    (?a26. ((do you have a spatial question ?)))
    (?a29. ((do you have a spatial question ?)))
    (?a32. ((do you have a spatial question ?)))
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
    (?a2.  (name))
    (?a5.  (spatial-question1))
    (?a8.  (spatial-question2))
    (?a11. (spatial-question3))
    (?a14. (spatial-question4))
    (?a17. (spatial-question5))
    (?a20. (spatial-question6))
    (?a23. (spatial-question7))
    (?a26. (spatial-question8))
    (?a29. (spatial-question9))
    (?a32. (spatial-question10))
  )
); end of mapcar
