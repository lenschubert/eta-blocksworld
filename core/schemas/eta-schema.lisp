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

?a3. (:store-in-context (ulf-of.f ?a2.))

;; ?a3. (:if ())

?a4. (Me say-to.v you '(Bye\.))

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




























;; ;; *ETA-SCHEMA*: development version 6
;; ;;
;; ;; Dialogue for blocksworld conversation 
;; ;; (intro + 30 questions +  outro)
;; ;; 
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; (defparameter *eta-schema*

;; '(Event-schema (((set of me you) have-eta-dialog.v) ** ?e)
;; ;```````````````````````````````````````````````````````````
;; ; Blocksworld conversation. This consists of one or two "getting
;; ; to know you" type questions, followed by a series of 10 questions.
;; ;

;; :episodes 

;; ;; ?a1. (Me say-to.v you 
;; ;;       '(Hi I am David\. I\'m here to help answer some spatial questions for you\.
;; ;;         Please try to speak as clearly as possible\. If you wish to quit at any time\, just say bye or goodbye\.))

;; ?a1. (Me say-to.v you 
;;       '(Hi\, my name is David\. I\'m ready to answer your spatial questions\.))

;; ;; ?a2. (Me say-to.v you 
;; ;;       '(Before we begin\, would you mind telling me what your name is?))

;; ;; ?a3. (You reply-to.v ?a2.)

;; ;; ?a4. (Me react-to.v ?a3.)

;; ?a5. (:repeat-until
;;   ?e6 (?a5 finished2.a) ; Should this be '?a6.', '?a6', or '?e1' ?

;;   ?a7. (Me say-to.v you
;;         '(Do you have a spatial question for me?))

;;   ?a8. (You reply-to.v ?a5.)

;;   ?a9. (Me react-to.v ?a8.)

;;   ?a10. (:if ('?ulf ((nn termination.n) request.n)) ; check interpretation of ?ulf
;;                    (:store-in-context '(?a5 finished2.a)))
;; )

;; ;; ?a95. (Me say-to.v you
;; ;;         '(Excellent questions\, but unfortunately all that
;; ;;           thinking has been very tiring\, so I need to take a break now\.))

;; ?a11. (Me say-to.v you
;;         '(Excellent questions\, but I need to take a break now\.))

;; )); end of defparameter *eta-schema*






;; (setf (get '*eta-schema* 'semantics) (make-hash-table))
;; ;````````````````````````````````````````````````````````
;; ; EL Semantics - Not yet used
;; ;
;; (defun store-output-semantics (var wff schema-name)
;;   (setf (gethash var (get schema-name 'semantics)) wff)
;; ); end of store-output-semantics

;; (mapcar #'(lambda (x)
;;       (store-output-semantics (first x) (second x) '*eta-schema*))
;;   '()
;; ); end of mapcar #'store-output-semantics




;; (setf (get '*eta-schema* 'gist-clauses) (make-hash-table))
;; ;````````````````````````````````````````````````````````
;; ; Gist clauses
;; ;
;; (defun store-output-gist-clauses (var clauses schema-name)
;;   (setf (gethash var (get schema-name 'gist-clauses)) clauses)
;; ); end of store-output-gist-clauses

;; (mapcar #'(lambda (x) 
;;       (store-output-gist-clauses (first x) (second x) '*eta-schema*))
;;   '(
;;     ;; (?a2.  ((what is your name ?)))
;;     (?a7.  ((do you have a spatial question ?)))
;;   )
;; ); end of mapcar #'store-output-gist-clauses




;; (setf (get '*eta-schema* 'topic-keys) (make-hash-table))
;; ;````````````````````````````````````````````````````````
;; ; Topic keys
;; ;
;; (defun store-topic-keys (var keys schema-name)
;;   (setf (gethash var (get schema-name 'topic-keys)) keys)
;; ); end of store-topic-keys

;; (mapcar #'(lambda (x) 
;;       (store-topic-keys (first x) (second x) '*eta-schema*))
;;   '(
;;     ;; (?a2.  (name))
;;     (?a7.  (spatial-question1))
;;   )
;; ); end of mapcar
