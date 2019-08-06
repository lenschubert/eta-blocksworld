
(defun implement-next-plan-event ({sub}plan-name)
;`````````````````````````````````````````````````
; This is intended for event formulas whose subject is 'me' (Eta);
; i.e., we assume that this program is called only if the first action 
; (2nd element, following the event-name) of 'rest-of-plan' of 
; '{sub}plan-name' is of form (me ...), i.e., an action by Eta.
;
; We assume that every {sub}plan name has a 'rest-of-plan' property
; pointing to the remainder of the plan that has not been fully executed
; (i.e., the first step of this remainder has been at most partially
; executed). Further, every action name for a nonprimitive action has,
; or needs to be supplied with, a 'subplan' property pointing to the
; name of a subplan, which will again have a 'rest-of-plan' property.
; Also, the subplan name will have a 'subplan-of' property that points
; back to the name of the action it expands.
;
; NOTE FOR THE FUTURE: IT SEEMS THAT THIS PROGRAM COULD ITSELF BE
;   REFORMULATED AS A KIND OF CHOICE TREE THAT SELECTS A SUBPLAN
;   TO EXPAND A NONPRIMITIVE ACTION THAT IT FINDS AT THE 'REST-
;   OF-PLAN' POINTER, OR, FOR PRIMITIVE ACTIONS (SAYING WORDS),
;   EXECUTES THEM. WE MIGHT ULTIMATELY DEVELOP PLANS NON-SEQUENT-
;   IALLY, SEPARATING SUCH DEVELOPMENT FROM EXECUTION OF (CURRENTLY
;   DUE) PRIMITIVE ACTIONS. SO THE ROLE OF THE PLANNING EXECUTIVE
;   WOULD BE MORE IN THE NATURE OF "PRIORITIZING" -- DECIDING WHETHER
;   TO EXECUTE THE NEXT STEP (IF PRIMITIVE), OR WHAT PLAN STEPS TO  
;   ELABORATE, MODIFY, OR SHIFT AROUND NEXT, WHILE USING CHOICE 
;   TREES FOR FINDING SUITABLE METHODS FOR ELABORATION (AND DOING 
;   FREQUENT OVERALL CONSISTENCY, PROBABILITY, AND UTILITY 
;   CALCULATIONS).
;                                
; If the currently due event pointed to by the 'rest-of-plan' property
; of '{sub}plan-name' is primitive (e.g., Eta saying something),
; execute it and advance the 'rest-of-plan pointer' of '{sub}plan-name'.
; Otherwise, if the 'subplan' property of the currently due action
; is nil, generate a subplan name, point to it via the 'subplan'
; property of the currently due action, find a choice tree or subschema
; for realizing the currently due action, and initialize the subplan.
;
; No part of the new subplan is immediately executed or further
; elaborated, so that the main Eta plan manager can in principle
; check and amend the overall rest of the plan if necessary (e.g.,
; add or modify temporal constraints to avoid inconsistencies; more 
; radical changes may be warranted for optimizing overall utility).
; Any subschemas used in the elaboration process typically supply 
; multiple (me say-to.v you '(...)) actions, etc.), and choice packets
; used for step elaboration typically elaborate (me react-to.v ...)
; actions into single or multiple (me say-to.v you '(...)) subactions.
;
 (let* ((rest (get {sub}plan-name 'rest-of-plan))
        (event-name (car rest)) (wff (second rest)) bindings 
        expr agent user-action-name user-gist-clauses n user-gist-passage
        main-clause new-subplan-name info topic suggestion query )

;      (format t "~%WFF = ~a,~% in the LISSA action ~a being ~
;                       processed~%" wff event-name); DEBUGGING
       (cond 
             ; Choosing {if-statements (** or other conditionals, if allowed)}
             ; ````````
             ((setq bindings
                    (bindings-from-ttt-match '(:if _+) wff)); if non-nil, it
                       ; yields ((_+ (cond1 name1 wff1 cond2 name2 wff2 ...)));
                       ; ** an issue: could complex wffs can have name-wff
                       ;    pairs within them??
              (setq expr (second (car bindings))); (cond1 name1 wff1 cond2 ...)
              ; Generate a subplan for the 1st action-wff with a true condition:
              (setq new-subplan-name (plan-cond expr))
              ; Make bidirectional connection to the new subplan
              (setf (get event-name 'subplan) new-subplan-name)
              (setf (get new-subplan-name 'subplan-of) 
                                           event-name))

             ; Looping {repeat-until (** maybe add other loop types?)}
             ; ```````
             ((setq bindings
                    (bindings-from-ttt-match '(:repeat-until  _+) wff))
                       ; yields (_+ (name0 wff0 name1 wff1 ...)));
                       ; episode name0, with wff0, provides the stop condition,
                       ; wff1 the 1st action, wff2 the 2nd action (each w/ name)
              (setq expr (second bindings)); (name0 wff0 name1 wff1 ...)
              ; Generate a subplan for the 1st action-wff with a true condition:
              (setq new-subplan-name (plan-repeat-until expr))
              ; If this is nil, the stop condition holds, & we drop the loop:
              (cond ((null new-subplan-name )
                     ; associate wff0 (the stop condition, found to be true)
                     ; with 'event-name', destructively replacing the previous
                     ; characterizing wff (the repeat-until construct) with it.
                     (rplacd rest (cons (second wff) (cddr rest))))
                    (t; an iteration (& repeat-loop copy) was added as subplan;
                      ; Make bidirectional connection to the new subplan:
                      (setf (get event-name 'subplan) new-subplan-name)
                      (setf (get new-subplan-name 'subplan-of) event-name))))

             ; Saying {utterances by Eta}
             ; ``````
             ((setq bindings
                    (bindings-from-ttt-match '(me say-to.v you _+) wff))
                       ; e.g., yields ((_+ '(I am a senior comp sci 
                       ; major\, how about you?))) (or nil, for non-match)
              (setq expr (second (car bindings))); e.g., '(I am a ...)
              ; If the current "say" action is a question (which we assume
              ; can be seen from a final question mark -- to be safer, we
              ; could check for wh-words, "you", auxiliaries & other cues),
              ; then use 'topic-keys' and 'gist-clauses' of the current
              ; event-name and the *gist-kb* to see if the question
              ; already seems to have been answered. If so, change the
              ; {sub}plan to omit the current Eta action: 
              (when (obviated-question (car expr) event-name)
                    (delete-current-action {sub}plan-name))
                    ; this will also reset the 'rest-of-plan' pointer
                    ; of '{sub}plan-name'.

              (cond ((eq (car expr) 'quote); drop the quote
                     (setq expr (second expr))
                     ; say it (and/or print it), also incrementing *eta-count*,
                     ; and advance the 'rest-of-plan' pointer over the
                     ; initial "action name" and wff
                     (setq *eta-count* (1+ *eta-count*))
                     (if *live*
                         (say-words expr); the only overt output step
                         (print-words expr))
                     (setf (get {sub}plan-name 'rest-of-plan) (cddr1 rest))
;                    (print-current-plan-status {sub}plan-name); DEBUGGING
                     (update-plan {sub}plan-name)
;                    (print-current-plan-status {sub}plan-name); DEBUGGING
                    )
                    (T; nonprimitive (me say-to.v you ...)' action, perhaps
                      ; one like 
                      ;   (me say-to.v you (that (?e be.v finished.a)));
                      ; But actually, this should probably be an "illegal"
                      ; action specification because as seen below we can
                      ; (and should) consistently use 'tell.v' for inform-
                      ; acts. But for the moment, (me say-to.v you (that ...))
                      ; is handled, as equivalent to (me tell.v you (that ...))
                      (setq new-subplan-name (plan-tell-act expr))
                      ; Bidirectional hierarchy connections:
                      (setf (get event-name 'subplan) new-subplan-name)
                      (setf (get new-subplan-name 'subplan-of)
                                                   event-name))))

             ; Reacting
             ; ````````
             ; Since Eta reactions to the user need elaboration in terms of
             ; what prompted the reaction, this point will be reached only 
             ; for nonprimitive Eta actions
             ((setq bindings
                    (bindings-from-ttt-match '(me react-to.v _!) wff))
                    ; e.g., yields ((_! EP34.)), or nil if unsuccessful;
              ; this nonprimitive action is to be expanded via choice packets.
              (setq user-action-name (second (car bindings)))
              ; TBC THIS NEEDS TO BE CHANGED `````` EP-NAMES NOW PRECEDE WFFS
              (setq user-gist-clauses
                    (get user-action-name 'gist-clauses))
              (setq new-subplan-name
                    (plan-reaction-to user-gist-clauses))
              (when (null new-subplan-name)
                    (delete-current-action {sub}plan-name)
                    (return-from implement-next-plan-event nil))

              ; 'new-subplan-name' will be the name of a subplan, with either
              ; a single (me say-to.v you '(...)) step, or with multiple
              ; primitive or nonprimitive steps. Link event-name to
              ; this subplan, and conversely link the subplan to plan-event-
              ; name, using a 'subplan-of' property (which might at some point
              ; be used in bidirectional plan traversals):
              (setf (get event-name 'subplan) new-subplan-name)
              (setf (get new-subplan-name 'subplan-of) event-name))

             ; Apart from saying and reacting, assume that Eta actions
             ; also allow telling, describing, suggesting, asking, saying 
             ; hello, and saying good-bye. 
             ;
             ; (Other speech acts may be added later, such as proposing,
             ; rejecting, praising, advising, reprimanding, acknowledging,
             ; apologizing, exclaiming, etc.)
             ;
             ; Telling
             ; ```````
             ((setq bindings
                    (bindings-from-ttt-match '(me tell.v you _!) wff))
                    ; e.g., telling one's name could be formulated as
                    ;   (me tell.v you 
                    ;        (ans-to (wh ?x (me have-as.v name.n ?x)))),
                    ; and answer retrieval should bind ?x to a name. Or
                    ; we could have explicit reified propositions such as 
                    ;    (that (me have-as.v name.n 'Eta)), or
                    ;    (that (me be.v ((attr autonomous.a) avatar.n))).
                    ; The match variable _! will have as binding the (wh ...)
                    ; expression.
              (setq info (second (car bindings)))
              (setq new-subplan-name (plan-tell-act info))
              (when (null new-subplan-name)
                    (delete-current-action {sub}plan-name)
                    (return-from implement-next-plan-event nil))
              (setf (get event-name 'subplan) new-subplan-name)
              (setf (get new-subplan-name 'subplan-of) event-name))

             ; Describing
             ; ``````````
             ; Describing, like telling, is an inform-act, but while
             ; telling simply conveys whatever propositions are given as
             ; argument, describing specifies what is to be conveyed at
             ; an abstract level, e.g., describing "who I am" (which may
             ; involve supplying a name, type, age, and the like), or
             ; describing one's capabilities, someone's appearance, one's
             ; family, or "what I like about Rochester", etc. This of course
             ; involves access to knowledge in the appropriate categories,
             ; and this may then be further expanded via tell-acts.
             ;
             ; In general, describing is a severe challenge in NLG, but
             ; here it will be initially assumed that we have schemas for
             ; expanding any descriptive actions that a plan might call
             ; for. An even simpler way of packaging related sets of
             ; sentences for ouput is to just use a tell-act of type
             ;    (me tell.v you (meaning-of.f '(<sent1> <sent2> ...)))
             ; where the 'meaning-of.f' function applied to English
             ; sentences supplies their semantic interpretation (reified
             ; with the 'that' operator) -- which of course needn't
             ; actually be computed (unless we wish to paraphrase the
             ; English in some way). Combining the two ideas, we can
             ; provide schemas for expanding a describe-act directly into
             ; a tell-act with a complex (meaning-of.f '(...)) argument.
             ;
             ((setq bindings
                    (bindings-from-ttt-match '(me describe-to.v you _!) wff))
              (setq topic (second bindings))
              ; e.g., (th (main.a (plur characteristic-of.n me)))
              (setq new-subplan-name (plan-description topic))
              (when (null new-subplan-name)
                    (delete-current-action {sub}plan-name)
                    (return-from implement-next-plan-event nil))
              (setf (get event-name 'subplan) new-subplan-name)
              (setf (get new-subplan-name 'subplan-of) event-name))

             ; Suggesting
             ; ``````````
             ((setq bindings
                    (bindings-from-ttt-match '(me suggest-to.v you _!) wff))
              (setq suggestion (second bindings))
              ; e.g., suggestion = 
              ;         (that (you provide-to.v me
              ;                   (K ((attr extended.a) (plur answer.n)))))
              (setq new-subplan-name (plan-suggest-act suggestion))
              (setf (get event-name 'subplan) new-subplan-name)
              (setf (get new-subplan-name 'subplan-of) event-name))

             ; Asking
             ; ``````
             ((setq bindings
                    (bindings-from-ttt-match '(me ask.v you _!) wff))
              (setq query (second bindings))
              ; e.g., query = (ans-to (wh ?x (you have-as.v major.n ?x)))
              (setq new-subplan-name (plan-question query))
              (when (null new-subplan-name)
                    (delete-current-action {sub}plan-name)
                    (return-from implement-next-plan-event nil))
              (setf (get event-name 'subplan) new-subplan-name)
              (setf (get new-subplan-name 'subplan-of) event-name))
             
             ; Acting
             ; ``````TBC
             
             ; Saying hello
             ; ````````````
             ((equal wff '(me say-hello-to.v you))
              (setq new-subplan-name (plan-saying-hello))
              (when (null new-subplan-name)
                    (delete-current-action {sub}plan-name)
                    (return-from implement-next-plan-event nil))
              (setf (get event-name 'subplan) new-subplan-name)
              (setf (get new-subplan-name 'subplan-of) event-name)) 
              
             ; Saying good-bye
             ; ```````````````
             ((equal wff '(me say-bye-to.v you))
              (setq new-subplan-name (plan-saying-bye))
              (when (null new-subplan-name)
                    (delete-current-action {sub}plan-name)
                    (return-from implement-next-plan-event nil))
              (setf (get event-name 'subplan) new-subplan-name)
              (setf (get new-subplan-name 'subplan-of) event-name))
             
             (T (format t "~%*** UNRECOGNIZABLE STEP ~a " wff))
           )        
 )); end of implement-next-plan-event

(defun plan-repeat-until (ep-var expr)
; ```````````````````````````````````
; 'ep-var' is the variable that was replaced by a new name, designating
;    the occurrence of the complex repeat-until event. It will be used
;    again in the recursion at the end of the plan we are forming;
; 'expr' is of form
;    (name0 wff0 name1 wff1 name2 wff2 ...), 
; where 'name0' is the episode characterized by stop condition 'wff0',
; 'name1' is the episode characterized by the first action- or event-wff
; 'wff1', 'name2' is the episode characterized by the 2nd action- or
; event-wff 'wff2', etc.
;
; The subplan (if wff0 is false) will consist of all the steps of the loop, 
; and ending with another repeat-until loop, identical to the original one.
;
(let (truth-val subplan-name)
      ; first check termination condition
      (setq truth-val (contextual-truth-value (second expr)))
      (cond (truth-val nil); termination has been reached -- return nil;
                           ; the calling program will delete the loop;
            (t ;create a subplan that has the steps of the loop & 
               ; a recursive copy of the loop:  
              (setq subplan-name (gentemp "SUBPLAN"))
              (set subplan-name ; let its value be the plan containing
                                ; steps name1 wff1 name2 wff2 ...,
                                ; followed by (cons `(:repeat-until ,expr))
                   (cons :events
                         (append expr
                                 (append `(,ep-var :repeat-until) expr))))
              (setf (get subplan-name 'rest-of-plan)
                    (cdr (eval subplan-name))); cdr past ':events'
              subplan-name));
 )); end of plan-repeat-until


; I THINK I'LL ALSO NEED 'plan-seq-acts', 'plan-consec-acts', ETC.
; THESE SHOULD BE PRETTY SIMPLE, JUST LISTING THE ACTIONS & PROVIDING
; seq-ep, consec-ep, ETC. RELATIONS IN THE SUBPLAN. 
