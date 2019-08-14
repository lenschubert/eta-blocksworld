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

; Alternate (longer) intro
;; ?a1. (Me say-to.v you 
;;       '(Hi I am David\. I\'m here to help answer some spatial questions for you\.
;;         Please try to speak as clearly as possible\. If you wish to quit at any time\, just say bye or goodbye\.))

; Short intro
?a1. (Me say-to.v you 
      '(Hi\, my name is David\. I\'m ready to answer your spatial questions\.))


; The following actions are excluded for now.
;; ?a2. (Me say-to.v you 
;;       '(Before we begin\, would you mind telling me what your name is?))

;; ?a3. (You reply-to.v ?a2.)

;; ?a4. (Me react-to.v ?a3.)



; Repeat prompting the user for a spatial question until finished.
?a5. (:repeat-until (:context (?a5 finished2.a))

    ; Prompt the user for a spatial question.
    ?a7. (Me say-to.v you
          '(Do you have a spatial question for me?))

    ; User replies with either spatial question, special request, or smalltalk.
    ?a8. (You reply-to.v ?a7.)

    ; If user makes 'goodbye' special request, store the fact that ?a5 is finished.
    ?a9. (:if
        ((:equal (ulf-of.f ?a8.) (GOODBYE.GR))
        ?a11. (:store-in-context '(?a5 finished2.a))
        ?a12. (Me react-to.v ?a8.))

        ; If user makes 'pause' special request, repeat listening to the user for a request to resume.
        ((:equal (ulf-of.f ?a8.) (PAUSE.GR))
        ?a12. (Me react-to.v ?a8.)
        ?a13 (:repeat-until (:context (?a13 finished2.a))

            ; Empty say-to act, carries (implied) meaning "do you want to resume?". Not ideal, but currently
            ; necessary to give the user something to reply to.
            ?a14. (Me say-to.v you '())

            ; User replies with either special request or smalltalk.
            ?a15. (You reply-to.v ?a14.)

            ; If user makes 'resume' special request, store the fact that ?a12 is finished.
            ?a16. (:if
                ((:equal (ulf-of.f ?a15.) (RESUME.GR))
                ?a17. (:store-in-context '(?a13 finished2.a))
                ?a18. (Me react-to.v ?a15.))

                ; If user makes 'goodbye' special request, store the fact that both ?a5 and ?a12 are finished.
                ((:equal (ulf-of.f ?a15.) (GOODBYE.GR))
                ?a17. (:store-in-context '(?a13 finished2.a) '(?a5 finished2.a))
                ?a18. (Me react-to.v ?a15.))))))

  ; React to the user's input (but stay silent if they made a special request)
  ?a19. (:if
      ((:not (:or (:equal (ulf-of.f ?a8.) (PAUSE.GR)) (:equal (ulf-of.f ?a8.) (GOODBYE.GR))))
        ?a20. (Me react-to.v ?a8.))))

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
    ;; (?a2.  ((what is your name ?)))
    (?a7.  ((do you have a spatial question ?)))
    (?a14. ((do you want to resume ?)))
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
    ;; (?a2.  (name))
    (?a7.  (spatial-question1))
  )
); end of mapcar
