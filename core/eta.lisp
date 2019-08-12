;; July 10/19 
;; ===========================================================
;;
;; For inputs, we use the question it answers to create a list
;; of simple, explicit English clauses, especially the first of 
;; which is intended to capture the "gist" of what was said,
;; i.e., the content of an utterance most likely to be needed
;; to understand the next turn in the dialogue. The intent is that
;; logical interpretations will later play that role, and this
;; has been initiated by supplying a hash table of (some) Eta 
;; output interpretations,
;;     *output-semantics*
;; (which uses keys such as (*eta-schema* ?a3.) along with the
;; hash table of gist clauses,
;;     *output-gist-clauses*
;; (indexed in the same way). These tables can be used to set up
;; the 'interpretation' and 'output-gist-clauses' properties of
;; action proposition names, generated in forming plans from 
;; schemas.
;;
;; One important goal in setting up these tables is to be able
;; later to match certain user inputs to Eta question gists/
;; interpretations, to see if the inputs already answer the
;; questions, making them redundant. 
;;
;; TODO: Regarding coreference and memory, it seems like there are
;; a couple separate things:
;; 1. Eta needs a way to parameterize say-to.v actions (and the corresponding
;; gist clauses) based on previous user answers. For example, if Eta asks "what
;; was your favorite class?" and the user replies "Macroeconomics", instead of the
;; next question being "did you find your favorite class hard", it should be
;; "did you find Macroeconomics hard?"
;; 2. Eta needs a way to "trigger" bringing up past information in response to
;; a user question, perhaps based on some similarity metric
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; -*- Common-Lisp -*-

; [This is partly derivative from "doolittle", an improvement of
; Weizenbaum's ELIZA that carries information forward from the
; previous question/answer pair, makes greater use of features,
; uses more flexible, hierarchical pattern matching, and initially
; classifies inputs by their general form (instead of by keyword).]
	
; To run the program, do the following (while in the present
; eta directory):
; lisp
; (load "start")





(defun init ()
;`````````````````````````````
; Initialize global parameters
;
; TODO:
; Other global parameters used here, but whose values are set elsewhere,
; are:  ***THIS NEEDS UPDATING
;      *next-input*
;      *next-answer*
;      *output-semantics*
;      *output-gist-clauses*
;      *eta-schema* (top-level schema) & possibly many subschemas
;      *reactions-to-input* (top-level choice tree for selecting a
;         schema or subtree to react to a user turn (possibly multiple
;         extracted "gist clauses")
;      *reaction-to-assertion* for individual user assertions
;      *reaction-to-question* for individual user questions
;      *interpretation-of-input* (top-level interpretation tree),
;         and many other interpretation trees (built from packets).
;      *gist-clause-trees* (top-level gist clause extraction
;         tree) and many subsidiary gist-clause extraction trees
;         (formed from corresponding packets).
;
  ; Use response inhibition via latency numbers when *use-latency* = T
  (defvar *use-latency* nil)

  ; Initialized from a dialogue schema, which is destructively
  ; modified as the plan is implemented. It retains already
  ; completed actions, but the 'rest-of-plan' property tells us
  ; where we are in the plan currently. Action names can have a
  ; 'subplan' property which in turn has a 'rest-of-plan' property, etc.
  (defvar *dialog-plan*)

  ; List of discourse entities
  (defvar *discourse-entities* nil)

  ; A doolittle relic, kept here because we'll probably
  ; want to have some sort of *context* parameter
  ; eventually, e.g., for the identity of the inter-
  ; locutors, potential referents, etc. The doolittle
  ; *context* was reset when doolittle asked a question,
  ; and any very brief user response (such as "yes",
  ; or "my mother") was expanded using that context.
  ;
  ; NOTE: Instead of doolittle's "contexts", Eta has 'subtree'
  ; and 'schema' "directives" in its reassembly rules, giving the name
  ; of another choice tree or schema to be used to construct a step or 
  ; steps for a subplan.
  ;
  ; AS A MEMORY-PEG: The final doolittle code also allowed special "theme"
  ; atoms in "contexts" (as specified in reassembly rules) that enabled
  ; repetitive return to the same "region" of the doolittle choice tree,
  ; maintaining topical focus. This may also turn out to be relevant to
  ; Eta, although currently we attempt to maintain topical consistency
  ; in Eta by (a) following sequences of steps, and (b) computing "gist
  ; clauses" or interpretations based on the user input, which should reveal
  ; the current theme unambiguously, and thus enable making relevant
  ; response choices.
  ;
  (defparameter *context* nil)

  ; Another doolittle relic: a list of saved responses,
  ; to be used to revert to an earlier exchange, if 
  ; no better options remained. This idea may still be
  ; relevant to Eta.
  (defparameter *memory* nil)

  ; number of Eta outputs generated so far (maintained
  ; for latency enforcement, i.e., not repeating a previously
  ; used response too soon).
  (defparameter *count* 0)

  ; This is used to check whether some error has caused Eta to enter
  ; an infinite loop (e.g. if the plan isn't correctly updated).
  (defparameter *error-check* 0)

  ; If *live* = T, operates in "live mode" (intended for avatar
  ; system) with file IO. If *live* = nil, operates in terminal mode.
  (defparameter *live* nil)

  ; Initialize/clear output file (only used in live mode)
  (with-open-file (outfile "./output.txt" :direction :output
                                          :if-exists :append
                                          :if-does-not-exist :create))
) ; END init





(defun eta (live)
;``````````````````````````
; live = t: avatar mode; live = nil: terminal mode
;
; Main program: Originally handled initial and final formalities,
; (now largely commented out) and controls the loop for producing,
; managing, and executing the dialog plan (mostly, reading & feature-
; annotating inputs & producing outputs, but with some subplan
; formation, gist clause formation, etc.).
;
  (init)
  (setq *live* live)
  (setq *discourse-entities* nil)
  (setq *count* 0) ; Number of outputs so far

  ; Create a partially instantiated dialog plan from a schema,
  ; starting with a copy of the schema with the first action variable
  ; given a new name, and the 'rest-of-plan' property pointing to
  ; the rest of the plan beginning with the new name.
  (init-plan '*dialog-plan* '*eta-schema* nil)
  ;; (print-current-plan-status '*dialog-plan*) ; DEBUGGING

  ; Call 'process-next-action' repeatedly, using the 'rest-of-plan'
  ; pointer. Every time an action is completed, the 'rest-of-plan'
  ; pointer is updated to point at a new action name (which may
  ; be nonprimitive and in turn have a 'subplan' property). If an
  ; action is primitive (e.g. (me say-to.v you)) execute it, otherwise
  ; form and initialize a subplan.
  (loop while (and
    (not (null (get '*dialog-plan* 'rest-of-plan)))
    (not (eq (process-next-action '*dialog-plan*) 'exit)))
  do
    ;; (print-current-plan-status '*dialog-plan*) ; DEBUGGING
    ;; (format t "~% here is after the print-current-plan-status -----------")

    ; Error check
    (cond
      ((> *error-check* 100)
        (error-message "An error caused Eta to fall into an infinite loop. Check if the plan is being updated correctly." *live*)
        (error))
      (t (setq *error-check* (1+ *error-check*))))

    ; Update the 'rest-of-plan' pointers after processing the
    ; previous step.
    (update-rest-of-plan-pointers '*dialog-plan*)

    ;; (format t "~% here is after the update-rest-of-plan-pointers -----------")
    ;; (print-current-plan-status '*dialog-plan*) ; DEBUGGING
    ;; (format t "~% here is after the print-current-plan-status -----------")
    ;; (format t "~%'rest-of-plan' pointers have been updated") ; DEBUGGING
  )

) ; END eta





(defun init-plan (plan-name schema-name args)
;```````````````````````````````````````````````````
; (eval plan-name) is presumably nil, while (eval schema-name)
; is the schema (starting with '(event-schema ((..) ** ?e) ... )')
; that the plan will be based on. For non-nil 'args', we replace
; successive variables occurring in the (..) part of the header
; (i.e., exclusive of ?e) by successive elements of 'args'.
;
  (let (plan episode-list prop-var prop-name)
    (setf (get plan-name 'schema-name) schema-name)

    ;; (format t "~%'schema-name' of ~a has been set to ~a" plan-name
    ;;                         (get plan-name 'schema-name)) ; DEBUGGING
  
    ; Make full copy so that we can make destructive changes to plan
    (set plan-name (copy-tree (eval schema-name)))

    ;; (format t "~%Schema to be used to initialize plan ~a is ~% ~a" 
    ;;                                    plan-name plan) ; DEBUGGING

    (setq plan (eval plan-name))
    (setq plan (cons 'plan (cdr plan)))

    ; If no episodes in schema, return error
    (when (not (find :episodes plan))
      (format t "~%*** Attempt to form plan ~a from schema ~a ~
                  which contains no ':episodes' keyword" plan-name schema-name)
      (return-from init-plan nil))

    ; Substitute the arguments 'args' (if non-nil) for the variables in the
    ; plan/schema header (other than the episode variable) throughout the
    ; plan. The substitution is destructive.
    (if args (setq plan (nsubst-schema-args args plan)))

    ;; (format t "~%Schema to be used for plan ~a, with arguments instantiated~
    ;;            ~% ~a" plan-name plan) ; DEBUGGING

    ; Find first action variable, should be a list like (:episodes ?a1. ...)
    (setq episode-list (member :episodes plan))
    (setq prop-var (second episode-list))

    ;; (format t "~%Action list of argument-instantiated schema is~
    ;;            ~% ~a" episode-list) ; DEBUGGING
    ;; (format t "~%The first action variable, ~a, has (variable? ~a) = ~a"
    ;;            prop-var prop-var (variable? prop-var)) ; DEBUGGING

    ; If first action variable does not start with '?', return error
    (when (not (variable? prop-var))
      (format t "~%*** Attempt to form plan ~a from schema ~a ~
                  which contains no episodes" plan-name schema-name)
      (return-from init-plan nil))

    ; Found the next action to be processed; set rest-of-plan pointer
    (setf (get plan-name 'rest-of-plan) (cdr episode-list))

    (process-plan-variables schema-name plan-name prop-name prop-var)
  plan-name)
) ; END init-plan





(defun update-plan (plan-name rest)
;```````````````````````````````````
; Similar to init-plan, substitute dual constants for variables
;
  (let (prop-var prop-name schema-name)
    ; Update rest-of-plan pointer
    (setf (get plan-name 'rest-of-plan) (cddr1 rest))

    (setq prop-var (car (get plan-name 'rest-of-plan)))

    ; Should start with '?'
    (when (not (variable? prop-var))
      ;; (format t "~%@@ end of plan ~a reached" plan-name) ; DEBUGGING
      (return-from update-plan nil))

    (process-plan-variables schema-name plan-name prop-name prop-var)

    ; Restart error count
    (setq *error-check* 0)

    (get plan-name 'rest-of-plan)
  plan-name)
) ; END update-plan





(defun update-rest-of-plan-pointers (plan-name)
;```````````````````````````````````````````````
; This gets a plan & its subplans ready for processing the next
; step by updating 'rest-of-plan' pointers and making sure that
; for any completed step (at any level) the next step of the schema
; being progressively instantiated has been initialized (given a
; unique (dualized) step name, with a 'gist-clause' property, etc.) 
; via 'update-plan'.
;
; If the rest-of-plan' pointer of 'plan-name' is nil, no pointer
; updates are needed (the plan of 'plan-name' is fully executed).
; 
; If the first step at the 'rest-of-plan' pointer of 'plan-name'
; has no 'subplan' property, then no updates are needed -- the most
; recent step executed was a primitive one, so that the 'rest-of-plan'
; pointer was aleady updated and the next step was initialized (via
; 'update-plan').
;
; Otherwise, after recursively updating the 'rest-of-plan' pointers
; of the subplan (whose name is accessed via the first action's
; 'subplan' property), if the pointer for that action has become nil,
; advance the 'rest-of-plan' pointer of 'plan-name' by one step;
; (the currently due step of 'plan-name' has been fully executed);
; then initialize its next action (if any) using 'update-plan'.
;
; Note: An alternative to the following pointer-update function
; would be to use the "upward" connections from subplans to steps
; (via the plan name's 'subplan-of' pointer) whenever a primitive
; action has been executed. This would require that all steps
; of the main *dialog-plan* also have a 'subplan-of' property
; that supplies '*dialog-plan*' as value. That's because if we 
; want to update the 'rest-of-plan' pointer of a plan, we need
; the plan name.
;

  ; Error check
  (cond
    ((> *error-check* 100)
      (error-message "An error caused Eta to fall into an infinite loop. Check if the plan is being updated correctly." *live*)
      (error))
    (t (setq *error-check* (1+ *error-check*))))

  (let ((rest (get plan-name 'rest-of-plan)) step-name subplan-name)
    (setq step-name (car rest))
    ;; (format t "~%~%'rest-of-plan' pointer of ~a at beginning of update~
    ;;            ~% is (~a ~a ...)" plan-name step-name (second rest)) ; DEBUGGING
    (cond
      ; Unexpected issues
      ((null rest) nil)
      ((or (not (symbolp step-name)) (null step-name)) nil)
      ((null (get step-name 'subplan)) nil)
      ; Otherwise update plan pointers
      (t (setq subplan-name (get step-name 'subplan))
        (cond
          ((null (get subplan-name 'rest-of-plan))
            ;; (format t "~%~%Since subplan ~a has a NIL 'rest-of-plan', ~% advance~
                      ;; 'rest-of-plan' of ~a over step ~a ~% with WFF = ~a~%"
                      ;; subplan-name plan-name step-name (second rest)) ; DEBUGGING
            (update-plan plan-name rest))
          (t (update-rest-of-plan-pointers subplan-name)))))

    ;; (format t "~%~%'rest-of-plan' pointer of ~a at end of update ~% is (~a ~a ...)~%"
    ;;   plan-name (car (cddr1 rest)) (second (cddr1 rest))) ; DEBUGGING

)) ; END update-rest-of-plan-pointers





(defun process-plan-variables (schema-name plan-name prop-name prop-var)
;```````````````````````````````````````````````````````````````````````
; Handles the creation and substitution of dual names from variables,
; as well as attaching properties to the action from associated hash tables,
; during the init-plan and update-plan functions.
;
  (let (2names ep-var ep-name gist-clauses interpretation topic-keys)
    ; 'prop-var' should end in a period (e.g. ?a1.), which stands for
    ; the (reified) proposition that the formula so-named characterizes
    ; the episode whose name is obtained by dropping the period (e.g. ?a1).
    ; We then create two names for the episode, one with and one without the
    ; period. e.g. ((?a3 . E35) (?a3. . E35.))
    (setq 2names (episode-and-proposition-name prop-var))

    ; We now substitute the names for the variables (destructively)
    ; in the rest of the plan.
    (setq ep-var (caar 2names) ep-name (cdar 2names))
    (nsubst ep-name ep-var (get plan-name 'rest-of-plan))
    (setq prop-var (car (second 2names)))
    (setq prop-name (cdr (second 2names)))
    (nsubst prop-name prop-var (get plan-name 'rest-of-plan))

    ;; (format t "~%Action list after substituting ~a for ~a: ~% ~a"
    ;;           prop-name prop-var (get plan-name 'rest-of-plan)) ; DEBUGGING

    ; Also we need to make action formulas available from the
    ; propositions names:
    (setf (get prop-name 'wff)
      (second (get plan-name 'rest-of-plan)))

    (unless schema-name
      (setq schema-name (get plan-name 'schema-name)))

    ; If this is a Eta action, transfer to it the gist clauses, interpretation,
    ; and topic key list from the hash tables associated with 'schema-name':
    (when (eq 'me (car (get prop-name 'wff)))
      (setq gist-clauses (gethash prop-var (get schema-name 'gist-clauses)))
      (setf (get prop-name 'gist-clauses) gist-clauses)
      
      ;; (format t "~%Gist clauses attached to ~a =~% ~a" prop-name
      ;;                         (get prop-name 'gist-clauses)) ; DEBUGGING

      (setq interpretation (gethash prop-var (get schema-name 'semantics)))
      (setf (get prop-name 'semantics) interpretation)

      (setq topic-keys (gethash prop-var (get schema-name 'topic-keys)))
      (setf (get prop-name 'topic-keys) topic-keys)

      ;; (format t "~%Topic keys attached to ~a =~% ~a" prop-name
                                    ;; (get prop-name 'topic-keys)) ; DEBUGGING
    )
)) ; END process-plan-variables





(defun find-curr-{sub}plan (plan-name)
;``````````````````````````````````````
; Find the deepest subplan of 'plan-name' (starting with the action
; at the 'rest-of-plan' pointer of 'plan-name') with an immediately
; pending action.
;
  (let* ((rest (get plan-name 'rest-of-plan)) (act-propos-name (car rest))
        (wff (second rest)) (subplan-name (get act-propos-name 'subplan)))

  ;; (format t "~%  'rest-of-plan' of ~a is ~%   (~a ~a ...)"
            ;; plan-name (car rest) (second rest)) ; DEBUGGING

  ; Error check
  (cond
    ((> *error-check* 100)
      (error-message "An error caused Eta to fall into an infinite loop. Check if the plan is being updated correctly." *live*)
      (error))
    (t (setq *error-check* (1+ *error-check*))))

  (cond
    ; Next action is top-level; may be primitive, or may need elaboration into subplan
    ((null subplan-name) plan-name)
    ; Unexpected: if the subplan is fully executed, then the 'rest-of-plan'
    ; pointer should have been advanced
    ; NOTE: Modified by Ben (7/15/19) to avoid recursive explosion with nested subplans
    ((null (get subplan-name 'rest-of-plan))
      ;; (format t "~%**'find-curr-{sub}plan' applied to ~a ~
      ;;           ~%   arrived at a completed subplan ~a" plan-name subplan-name)
      ;; (update-plan plan-name rest)
    )
    ; The subplan is not fully executed, so find & return the current
    ; {sub}subplan recursively:
    (t (find-curr-{sub}plan subplan-name)))
)) ; END find-curr-{sub}plan





(defun delete-current-action ({sub}plan-name)
;```````````````````````````````````````````````
; Skip over the action of {sub}plan-name pointed to by its
; 'rest-of-plan' pointer. The original intention was to destructively
; delete obviated actions, however since plans are currently represented
; as simple list structures rather than doubly-linked lists, we would have
; to search from the beginning of the plan to find the point where
; we'd need to apply 'rplaca' to physically delete the name (and then wff)
; of the skipped action.
;
; TODO: Ultimately, to facilitate general plan modifications, rearrangements,
; etc. we should be using a doubly linked list - perhaps record-structures for
; steps that have fields for preceding and following steps (and wff fields, gist
; clause fields, etc.)
;

  ;; (format t "~% CURRENT ACTION ~a BEING DELETED FROM ~a, ALONG WITH ITS ~
  ;;           ~%  WFF = ~a" (car (get {sub}plan-name 'rest-of-plan)) {sub}plan-name 
  ;;                         (second (get {sub}plan-name 'rest-of-plan))) ; DEBUGGING

  (update-plan {sub}plan-name (get {sub}plan-name 'rest-of-plan))

  ;; (format t "~% So the next plan is now  ~a" (get {sub}plan-name 'rest-of-plan)) ; DEBUGGING

) ; END delete-current-action





(defun obviated-question (sentence eta-action-name)
;````````````````````````````````````````````````````
; Check whether this is a (quoted, bracketed) question.
; If so, check what facts, if any, are stored in *gist-kb* under 
; the 'topic-keys' obtained as the value of that property of
; 'eta-action-name'. If there are such facts, check if they
; seem to provide an answer to the gist-version of the question,
; which will be the last gist clause stored under property
; 'gist-clauses' of 'eta-action-name'.
;
  (let (topic-keys facts)
    ;; (format t "~% ****** quoted question returns ~a **** ~%" (quoted-question? sentence)) ; DEBUGGING
    (if (not (quoted-question? sentence))
      (return-from obviated-question nil))
    (setq topic-keys (get eta-action-name 'topic-keys))
    ;; (format t "~% ****** topic key is ~a ****** ~%" topic-keys) ; DEBUGGING
    (if (null topic-keys) (return-from obviated-question nil))
    (setq facts (gethash topic-keys *gist-kb*))
    ;; (format t "~% ****** gist-kb ~a ****** ~%" *gist-kb*)
    ;; (format t "~% ****** list facts about this topic = ~a ****** ~%" facts)
    ;; (format t "~% ****** There is no fact about this topic. ~a ****** ~%" (null facts)) ; DEBUGGING
    (if (null facts) (return-from obviated-question nil))
    ; We have an Eta question, corresponding to which we have stored facts
    ; (as user gist clauses) that seem topically relevant.
    ; NOTE: in this initial version, we don't try to verify that the facts
    ; actually obviate the question, but just assume that they do. 
  facts)
) ; END obviated-question





(defun process-next-action (plan-name)
;``````````````````````````````````````````
; As currently envisaged, 'plan-name' will always be the main Eta
; plan, but in looking for the next action we potentially descend
; into subplans.
;
; I.e., we follow 'rest-of-plan' and 'subplan' pointers to find the
; next action in the current plan or subplan. If there are further
; actions, the car of the rest of the (sub)plan is the name of an action
; proposition, and the cdr begins with an action specification (a wff
; characterizing the implicit event-- whose name can be obtained by
; dropping the final period from the "action name"). 'Rest-of-plan'
; pointers become nil when a (sub)plan has been fully executed, but
; process-next-action only does this pointer-advancement when executing
; a primitive action, whereas updating the pointers for any higher-level
; actions is handled by 'update-rest-of-plan-pointers'.
;
; So, we process the action heading the rest of the (sub)plan, which
; for a primitive action entails execution of the action and advancement
; of the 'rest-of-plan' pointer of 'plan-name'. For a nonprimitive 
; action it leads to the creation of an initialized subplan intended
; to implement the nonprimitive action, with a name pointed to by
; the 'subplan' property of 'plan-name'. We hold off on executing the
; first step of such a subplan (leaving this to the next iteration
; of 'process-next-action' as called for in the main eta program),
; in order to give the main plan management program (eta) a chance
; to evaluate the "proposed" subplan and possibly make amendments.
; [This is just for future enhancements of the system, not immediately
; used.] 
;
; Question: Why not use the names of nonprimitive steps themselves as
; subplan names? Answer: We want to potentially allow for associating
; multiple alternative subplans with a given step (if we do this, we
; should change 'subplan' to 'subplans', which will point to a *list* 
; of subplan names); when one subplan fails, the step may still be
; achievable with an alternative subplan. (For user inputs, different
; subplans represent alternative expectations about user behavior, and
; this eventually opens the door to an AND-OR style of planning, as in
; two-person games.)
;
  (let ((rest (get plan-name 'rest-of-plan)) {sub}plan-name wff)

    ; If no next action, return nil so the system will terminate
    (if (null rest) (return-from process-next-action nil))
  
    ; Find the next action (at the lowest level), by following
    ; 'subplan' pointers (if any) to the deepest level where there
    ; is a subplan with a non-nil 'rest-of-plan' pointer.
    (setq {sub}plan-name (find-curr-{sub}plan plan-name))

    (setq rest (get {sub}plan-name 'rest-of-plan))

    (format t "~%'rest-of-plan' of currently due ~a is~% ~a~%"
              {sub}plan-name rest) ; DEBUGGING

    (setq wff (second rest))

    ; Match '(me ...)' (Eta) actions, or '(you ...)' (User) actions, and
    ; act accordingly.
    (cond
      ((eq (car wff) 'me)
        (implement-next-eta-action {sub}plan-name))
      ((eq (car wff) 'you)
        (observe-next-user-action {sub}plan-name))
      (t (implement-next-plan-episode {sub}plan-name)))
)) ; END process-next-action





(defun implement-next-plan-episode ({sub}plan-name)
;````````````````````````````````````````````````````
; We assume that every {sub}plan name has a 'rest-of-plan' property
; pointing to the remainder of the plan that has not been fully executed
; (i.e., the first step of this remainder has been at most partially
; executed). Further, every action name for a nonprimitive action has,
; or needs to be supplied with, a 'subplan' property pointing to the
; name of a subplan, which will again have a 'rest-of-plan' property.
; Also, the subplan name will have a 'subplan-of' property that points
; back to the name of the action it expands.
;
; This program is called if an episode is a general event or control flow
; formula, rather than an action formula starting with "Me" or "You".
;
  (let* ((rest (get {sub}plan-name 'rest-of-plan)) (episode-name (car rest))
        (wff (second rest)) bindings expr user-action-name user-ulf n new-subplan-name
        user-gist-clauses user-gist-passage main-clause info topic suggestion query user-ulf
        ans alternates)
  
    ;; (format t "~%WFF = ~a,~% in the ETA action ~a being ~
              ;; processed~%" wff episode-name) ; DEBUGGING

    ; Big conditional statement to determine the type of the current
    ; action, and to form the subsequent action accordingly.
    (cond

      ;`````````````````````````
      ; Eta: Storing in context
      ;`````````````````````````
      ; Storing a given wff expression in context
      ((setq bindings (bindings-from-ttt-match '(:store-in-context _+) wff))
        (setq expr (get-multiple-bindings bindings))
        ; Generate a subplan for the 1st action-wff with a true condition:
        (store-in-context expr)
        (update-plan {sub}plan-name rest))

      ;`````````````````````
      ; Eta: Choosing
      ;`````````````````````
      ; if-statements, potentially other conditionals in the future.
      ; bindings yields ((_+ (cond1 name1 wff1 cond2 name2 wff2 ...)))
      ; NOTE: one potential issue, could complex wffs have name-wff pairs within them??
      ((setq bindings (bindings-from-ttt-match '(:if _+) wff))
        (setq expr (get-multiple-bindings bindings))
        ; Generate a subplan for the 1st action-wff with a true condition:
        (setq new-subplan-name (plan-cond expr))
        ; Make bidirectional connection to the new subplan (if not nil)
        (cond
          (new-subplan-name
            (setf (get episode-name 'subplan) new-subplan-name)
            (setf (get new-subplan-name 'subplan-of) episode-name))
          (t (update-plan {sub}plan-name rest))))

      ;`````````````````````
      ; Eta: Looping
      ;`````````````````````
      ; repeat-until, potentially other forms of loops in the future.
      ; bindings yields ((_+ (name0 wff0 name1 wff1 ...)))
      ; episode name0, with wff0, provides the stop condition. wff1 the 1st action,
      ; wff2 the 2nd action (each w/ name), etc.
      ((setq bindings (bindings-from-ttt-match '(:repeat-until  _+) wff))
        (setq expr (get-multiple-bindings bindings))
        ; Generate a subplan for the 1st action-wff with a true condition:
        (setq new-subplan-name (plan-repeat-until episode-name expr))
        ; If this is nil, the stop condition holds, & we drop the loop:
        (cond
          ; If nil, the stop condition holds, so we drop the loop by associating wff0
          ; with 'episode-name', destructively replacing the previous characterizing wff
          ; (the repeat-until construct) with it.
          ((null new-subplan-name)
            (rplacd rest (cons (second wff) (cddr rest))))
          ; Otherwise, an iteration (and repeat-loop copy) was added as subplan, so
          ; make bidirectional connection to new subplan.
          (t
            (setf (get episode-name 'subplan) new-subplan-name)
            (setf (get new-subplan-name 'subplan-of) episode-name))))
      
      ; Unrecognizable step
      (t (format t "~%*** UNRECOGNIZABLE STEP ~a " wff))
    )
)) ; END implement-next-plan-episode





(defun implement-next-eta-action ({sub}plan-name)
;``````````````````````````````````````````````````
; We assume that every {sub}plan name has a 'rest-of-plan' property
; pointing to the remainder of the plan that has not been fully executed
; (i.e., the first step of this remainder has been at most partially
; executed). Further, every action name for a nonprimitive action has,
; or needs to be supplied with, a 'subplan' property pointing to the
; name of a subplan, which will again have a 'rest-of-plan' property.
; Also, the subplan name will have a 'subplan-of' property that points
; back to the name of the action it expands.
;
; We assume that this program is called only if the first action of
; 'rest-of-plan' of '{sub}plan-name' is already known to be of type
; (me ...), i.e., an action by Eta.
;
; TODO: IT SEEMS THAT THIS PROGRAM COULD ITSELF BE
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
; If the currently due action pointed to by the 'rest-of-plan'
; property of '{sub}plan-name' is primitive (e.g., saying something),
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
; multiple (me say-to.v you '(...)) actions), and choice packets used
; for step elaboration typically elaborate (me react-to.v ...) actions
; into single or multiple (me say-to.v you '(...)) subactions.
;
  (let* ((rest (get {sub}plan-name 'rest-of-plan)) (episode-name (car rest))
        (wff (second rest)) bindings expr user-action-name user-ulf n new-subplan-name
        user-gist-clauses user-gist-passage main-clause info topic suggestion query user-ulf
        ans alternates)
  
    ;; (format t "~%WFF = ~a,~% in the ETA action ~a being ~
    ;;           processed~%" wff episode-name) ; DEBUGGING

    ; Big conditional statement to determine the type of the current
    ; action, and to form the subsequent action accordingly.
    (cond

      ;`````````````````````
      ; Eta: Saying
      ;`````````````````````
      ; e.g. yields ((_+ '(I am a senior comp sci major\, how about you?)))
      ; or nil, for non-match
      ((setq bindings (bindings-from-ttt-match '(me say-to.v you _+) wff))
        (setq expr (get-single-binding bindings))
        ; If the current "say" action is a question (final question mark,
        ; can also check for wh-words & other cues), then use 'topic-keys'
        ; and 'gist-clauses' of current episode-name and the *gist-kb*
        ; to see if question has already been answered. If so, omit action.
        (when (not (null (obviated-question expr episode-name)))
          (delete-current-action {sub}plan-name)
          (return-from implement-next-eta-action nil))
        (cond
          ; Primitive say-to.v act: drop the quote, say it, increment the
          ; *count* variable, and advance the 'rest-of-plan' pointer
          ((eq (car expr) 'quote)
            (setq expr (second expr))
            (setq *count* (1+ *count*))
            (if *live* (say-words expr) (print-words expr))
            ;(print-current-plan-status {sub}plan-name); DEBUGGING
            (update-plan {sub}plan-name rest)
            ;(print-current-plan-status {sub}plan-name); DEBUGGING
          )
          ; Nonprimitive say-to.v act (e.g. (me say-to.v you (that (?e be.v finished.a)))):
          ; Should probably be illegal action specification since we can use 'tell.v' for
          ; inform acts. For the moment however, handle equivalently to tell.v.
          (t
            (setq new-subplan-name (plan-tell expr))
            (setf (get episode-name 'subplan) new-subplan-name)
            (setf (get new-subplan-name 'subplan-of) episode-name))))

      ; For now, saying something is the only primitive action, so everything
      ; beyond this point is non-primitive actions, to be expanded using choice packets.

      ;`````````````````````
      ; Eta: Reacting
      ;`````````````````````
      ; Yields e.g. ((_! EP34.)), or nil if unsuccessful.
      ((setq bindings (bindings-from-ttt-match '(me react-to.v _!) wff))
        (setq user-action-name (get-single-binding bindings))
        ; Get user gist clauses and ulf from bound user action
        ; TODO: modify to use ulf to plan reaction
        (setq user-gist-clauses (get user-action-name 'gist-clauses))
        (setq user-ulf (get user-action-name 'ulf))
        (format t "~% user gist clause is ~a ~%" user-gist-clauses) ; DEBUGGING
        (format t "~% user ulf is ~a ~%" user-ulf) ; DEBUGGING
        (setq new-subplan-name (plan-reaction-to user-gist-clauses user-ulf))
        (when (null new-subplan-name)
          (delete-current-action {sub}plan-name)
          (return-from implement-next-eta-action nil))

        ; 'new-subplan-name' will be the name of a subplan with some amount of primitive
        ; or nonprimitive steps (usually just a single say-to.v action). Link eta action
        ; to subplan bidirectionally (in case bidirectional plan traversals are used in future)
        (setf (get episode-name 'subplan) new-subplan-name)
        (setf (get new-subplan-name 'subplan-of) episode-name))

      ; NOTE: Apart from saying and reacting, assume that Eta actions
      ; also allow telling, describing, suggesting, asking, saying 
      ; hello, and saying good-bye. 
      ;
      ; (Other speech acts may be added later, such as proposing,
      ; rejecting, praising, advising, reprimanding, acknowledging,
      ; apologizing, exclaiming, etc.)

      ; TODO: Most of the following use redundant code, which can probably
      ; be factored into a single higher order function (for now)

      ;`````````````````````
      ; Eta: Telling
      ;`````````````````````
      ; e.g. telling one's name could be formulated as
      ; (me tell.v you (ans-to (wh ?x (me have-as.v name.n ?x))))
      ; and answer retrieval should bind ?x to a name. Or we could have
      ; explicit reified propositions such as (that (me have-as.v name.n 'Eta))
      ; or (that (me be.v ((attr autonomous.a) avatar.n))). The match variable
      ; _! will have as a binding the (wh ...) expression.
      ((setq bindings (bindings-from-ttt-match '(me tell.v you _!) wff))
        (setq info (get-single-binding bindings))
        (setq new-subplan-name (plan-tell info))
        (when (null new-subplan-name)
          (delete-current-action {sub}plan-name)
          (return-from implement-next-eta-action nil))
        (setf (get episode-name 'subplan) new-subplan-name)
        (setf (get new-subplan-name 'subplan-of) episode-name))

      ;`````````````````````
      ; Eta: Describing
      ;`````````````````````
      ; Describing, like telling, is an inform-act, but describing conveys a proposition
      ; at an abstract level (e.g. "who I am", describing one's capabilities or appearance, etc.).
      ; This involves access to knowledge in the appropriate categories, and this may then
      ; be further expanded via tell-acts.
      ;
      ; In general, describing is a severe challenge in NLG, but here it will be initially assumed
      ; that we have schemas for expanding any descriptive actions that a plan might call for.
      ; An even simpler way of packaging related sets of sentences for outputs is to just use a
      ; tell-act of type (me tell.v you (meaning-of.f '(<sent1> <sent2> ...))), where the
      ; 'meaning-of.f' function applied to English sentences supplies their semantic interpretation,
      ; reified with the 'that' operator. Combining the two ideas, we can provide schemas for expanding
      ; a describe-act directly into a tell-act with a complex meaning-of.f argument.
      ((setq bindings (bindings-from-ttt-match '(me describe-to.v you _!) wff))
        (setq topic (get-single-binding bindings))
        (setq new-subplan-name (plan-description topic))
        (when (null new-subplan-name)
          (delete-current-action {sub}plan-name)
          (return-from implement-next-eta-action nil))
        (setf (get episode-name 'subplan) new-subplan-name)
        (setf (get new-subplan-name 'subplan-of) episode-name))

      ;`````````````````````
      ; Eta: Suggesting
      ;`````````````````````
      ; e.g. (that (you provide-to.v me (K ((attr extended.a) (plur answer.n)))))
      ((setq bindings (bindings-from-ttt-match '(me suggest-to.v you _!) wff))
        (setq suggestion (get-single-binding bindings))
        (setq new-subplan-name (plan-suggest suggestion))
        (when (null new-subplan-name)
          (delete-current-action {sub}plan-name)
          (return-from implement-next-eta-action nil))
        (setf (get episode-name 'subplan) new-subplan-name)
        (setf (get new-subplan-name 'subplan-of) episode-name))

      ;`````````````````````
      ; Eta: Asking
      ;`````````````````````
      ; e.g. (ans-to (wh ?x (you have-as.v major.n ?x)))
      ((setq bindings (bindings-from-ttt-match '(me ask.v you _!) wff))
        (setq query (get-single-binding bindings))
        (setq new-subplan-name (plan-question query))
        (when (null new-subplan-name)
          (delete-current-action {sub}plan-name)
          (return-from implement-next-eta-action nil))
        (setf (get episode-name 'subplan) new-subplan-name)
        (setf (get new-subplan-name 'subplan-of) episode-name))

      ;`````````````````````
      ; Eta: Saying hello
      ;`````````````````````
      ((equal wff '(me say-hello-to.v you))
        (setq new-subplan-name (plan-saying-hello))
        (when (null new-subplan-name)
          (delete-current-action {sub}plan-name)
          (return-from implement-next-eta-action nil))
        (setf (get episode-name 'subplan) new-subplan-name)
        (setf (get new-subplan-name 'subplan-of) episode-name))

      ;`````````````````````
      ; Eta: Saying good-bye
      ;`````````````````````
      ((equal wff '(me say-bye-to.v you))
        (setq new-subplan-name (plan-saying-bye))
        (when (null new-subplan-name)
          (delete-current-action {sub}plan-name)
          (return-from implement-next-eta-action nil))
        (setf (get episode-name 'subplan) new-subplan-name)
        (setf (get new-subplan-name 'subplan-of) episode-name))

      ;````````````````````````````````````````
      ; Eta: Seek answer from external source
      ;````````````````````````````````````````
      ((setq bindings (bindings-from-ttt-match '(me seek-answer-from.v _! _!1) wff))
        (setq system (second (first bindings)))
        (setq user-ulf (second (second bindings)))
        ; Leaving this open in case we want different procedures for different systems
        (cond
          ((null *live*) nil)
          ((eq system '|Spatial-QA-Server|) (write-ulf (second user-ulf)))
          (t (write-ulf (second user-ulf))))
        (update-plan {sub}plan-name rest))

      ;``````````````````````````````````````````
      ; Eta: Recieve answer from external source
      ;``````````````````````````````````````````
      ((setq bindings (bindings-from-ttt-match '(me receive-answer-from.v _! _!1) wff))
        (setq system (second (first bindings)))
        (setq expr (second (second bindings)))
        ; Leaving this open in case we want different procedures for different systems
        (cond
          ((null *live*) (setq ans '(Could not connect with system \: not in live mode \.)))
          ((eq system '|Spatial-QA-Server|) (setq ans (get-answer)))
          (t (setq ans (get-answer))))
        ; If '?ans+alternates, split answer into answer and alternates
        (cond ((eq expr '?ans+alternates)
          (setq alternates (second ans))
          (setq ans (first ans))))
        ; Set 'ans (and 'alternates if applicable) attributes to the recieved answer and
        ; alternates for the current action and subsequent action
        (setf (get episode-name 'ans) ans)
        (setf (get episode-name 'alternates) alternates)
        (update-plan {sub}plan-name rest)
        (setf (get (car (get {sub}plan-name 'rest-of-plan)) 'ans) ans)
        (setf (get (car (get {sub}plan-name 'rest-of-plan)) 'alternates) alternates))

      ;````````````````````````````
      ; Eta: Conditionally saying
      ;````````````````````````````
      ; NOTE: Currently just creates a primitive say-to.v subplan directly from the given
      ; answer
      ; TODO: In the future we should change this to use the alternates (if given) somehow
      ((setq bindings (bindings-from-ttt-match '(me conditionally-say-to.v you _!) wff))
        (setq expr (second (first bindings)))
        (cond
          ; For now, if expr is a variable read off of 'ans attribute attached to current action
          ; (regardless of what specific variable is given - TODO this should probably be changed)
          ; and convert directly to primitive say-to.v subplan
          ((or (variable? expr) (variable? (second expr)))
            (setq ans (get episode-name 'ans))
            (if (equal (first ans) 'poss-ans)
              (setq ans (append
                '(You are not sure if you understood the question correctly\, but your answer is)
                (cdr ans))))
            (setq new-subplan-name (create-say-to-subplan ans))
            (when (null new-subplan-name)
              (delete-current-action {sub}plan-name)
              (return-from implement-next-eta-action nil))
            (setf (get episode-name 'subplan) new-subplan-name)
            (setf (get new-subplan-name 'subplan-of) episode-name))
          ; Otherwise, convert directly to primitive say-to.v subplan
          (t
            (setq new-subplan-name (create-say-to-subplan (second expr)))
            (when (null new-subplan-name)
              (delete-current-action {sub}plan-name)
              (return-from implement-next-eta-action nil))
            (setf (get episode-name 'subplan) new-subplan-name)
            (setf (get new-subplan-name 'subplan-of) episode-name))))
      
      ; Unrecognizable step
      (t (format t "~%*** UNRECOGNIZABLE STEP ~a " wff))
    )
)) ; END implement-next-eta-action





(defun observe-next-user-action ({sub}plan-name)
;`````````````````````````````````````````````````
; '{sub}plan-name' provides the name of a (sub)plan whose
; 'rest-of-plan' pointer points to a user action, i.e., the
; name of a user action followed by a wff of type (you ...).
;
; We build a two-level plan structure for nonprimitive user
; replies (with a (you say-to.v me '(...)) at the primitive
; level), and (in another Eta plan iteration) "interpret" 
; these replies. The value returned is a pair 
;    (<user action name> <corresponding wff>) 
; for the step that was processed. (This is not needed but 
; may help in debugging.)
;
; The idea is that we should recognize user actions as being
; hierarchically organized (just like Eta actions). 
; Currently we're just anticipating nonprimitive top-level
; actions like 
;        (you reply-to.v <eta action>)
; that we expand to one further, primitive level of type
;        (you say-to.v me '(...)) 
; actions. However, in principle, observing a user action
; is a plan-recognition process, where for example multiple 
; sentences uttered by the user may comprise a sequence of
; speech acts of different types (just like outputs by Eta);
; as well, the highest-level user plan that is recognized may
; fail to match the *expected* type of the user action (but
; we're ignoring this possibility for now).
;
; Primitive user actions arise in two ways: First, (you say-to.v
; me '(...)) actions are generated here from nonprimitive
; (you reply-to.v ...) actions as already mentioned and explained
; further below. Second, Eta actions of type (Me react-to.v ...)
; may generate schema-based subplans that contain multiple Eta
; comments of type (Me say-to.v you '(...)), where these are
; preceded by "hallucinated" user inputs of form (You paraphrase.v
; '(...)); here the quoted words comprise a gist clause "attributed"
; to the user, i.e., these are treated as implicit versions of 
; (parts of) the user's previous actual input that were "para-
; phrased" by the user in the context of the Eta question they
; answer. These "hallucinated" clauses attributed to the user are
; needed to enable uniform processing of Eta's reaction to each
; individual gist clause derived from an actual input.
;
; To generate a subplan containing a primitive (you say-to.v me 
; '(...)) action, given a (you reply-to.v <eta action>) action, 
; we read the user input, form a wff for the primitive action with
; the input word list filled in, generate a plan name for the
; simple subordinate plan, and assign a value to that plan name
; consisting of a new action name for the primitive action and the
; (you say-to.v ...) wff. We don't make interpretation of the 
; user input part of the process of generating the primitive 
; action (though we could, since we have at hand the <eta action>
; to which the user is responding, in the wff (you reply-to.v 
; <eta action>)); instead, we derive the interpretation when
; processing the primitive action; this is for consistency with
; the general principle that interpretation (including speech act
; recognition) should proceed bottom-up (but with the previous 
; Eta utterance as context). [However, maybe hierarchical
; interpretation should be a process separate from hierarchical
; plan processing...]
; 
; So, processing of primitive (you say-to.v me '(...)) actions
; should lead to their "interpretation", i.e., extraction of gist
; clauses and possibly supplementary information that could
; obviate later Eta questions. This requires finding out what
; the user is replying to, by looking "upward" and "backward" in the
; plan hierarchy. Specifically, we need to access the nonprimitive
; user action that immediately subsumes the (you say-to.v me ...)
; action -- this is accessible via the 'subplan-of' property of
; {sub}plan-name -- and the wff of this noprimitive action in turn
; supplies the name of the Eta action that the user is responding
; to. The 'gist-clauses' property of that Eta action name leads 
; to the desired context information for interpreting the user input 
; utterance. (In future the 'interpretation' property is to be used.)
; 
  (let* ((rest (get {sub}plan-name 'rest-of-plan)) (user-action-name (car rest))
        (wff (second rest)) bindings words user-action-name1 wff1 eta-action-name
        eta-clauses user-gist-clauses main-clause subplan-name user-ulf input)

    ;; (format t "~%WFF = ~a,~%      in the user action ~a being ~
    ;;           processed~%" wff user-action-name) ; DEBUGGING

    ; Big conditional statement to observe different types of user actions
    (cond
      ;`````````````````````
      ; User: Saying
      ;`````````````````````
      ; We deal with primitive say-actions first (previously created from
      ; (you reply-to.v <eta action>)) based on reading the user's input:
      ((setq bindings (bindings-from-ttt-match '(you say-to.v me _!) wff))
        (setq words (get-single-binding bindings))
        ; Anything but a quoted word list is unexpected:
        (when (not (eq (car words) 'quote))
          (format t "~%*** SAY-ACTION ~a~%    BY THE USER ~
                    SHOULD SPECIFY A QUOTED WORD LIST" words)
          (return-from observe-next-user-action nil))
        ; Drop the quote
        (setq words (decompress (second words)))
        ; Prepare to "interpret" 'words', using the Eta output it is a response to;
        ; first we need the superordinate action
        (setq user-action-name1 (get {sub}plan-name 'subplan-of))
        ;; (format t "~%User action name1 = ~a" user-action-name1) ; DEBUGGING
        
        ; Next we find the Eta action name referred to in the wff of the
        ; (nonprimitive) superordinate action; this wff is expected to be of form
        ; (you reply-to.v <eta action>).
        (setq wff1 (get user-action-name1 'wff))
        ;; (format t "~%User WFF1 = ~a, if correct,~%            ~
        ;;           ends in a ETA action name" wff1) ; DEBUGGING
        (setq eta-action-name (car (last wff1)))
        (when (not (symbolp eta-action-name))
          (format t "~%***UNEXPECTED USER ACTION ~A" wff)
          (return-from observe-next-user-action nil))
        ; Next, the "interpretation" (gist clauses) of the Eta action:
        (setq eta-clauses (get eta-action-name 'gist-clauses))
        ;; (format t "~%ETA action name is ~a" eta-action-name)
        ;; (format t "~%ETA gist clauses that the user is responding to ~
        ;;           ~% = ~a " eta-clauses) ; DEBUGGING

        ; Compute the "interpretation" (gist clauses) of the user input,
        ; which will be done with a gist-clause packet selected using the
        ; main Eta action clause, and with the user input being the text
        ; to which the tests in the gist clause packet (tree) are applied.
        ;
        ; TODO: In the future, we might instead of in addition use
        ; (get eta-action-name 'interpretation).
        (setq user-gist-clauses
          (form-gist-clauses-from-input words (car (last eta-clauses))))

        ; Remove contradiction
        (setq user-gist-clauses (remove-contradiction user-gist-clauses))

        ; Both the primitive user action and the immediately subordinate action
        ; recieve the gist-clause interpretation just computed.
        (setf (get user-action-name 'gist-clauses) user-gist-clauses)
        (setf (get user-action-name1 'gist-clauses) user-gist-clauses)

        ; Get ulfs from user gist clauses and set them as an attribute to the current
        ; user action
        (setq user-ulf (mapcar #'form-ulf-from-clause user-gist-clauses))

        (setf (get user-action-name 'ulf) user-ulf)
        (setf (get user-action-name1 'ulf) user-ulf)

        ; Advance the 'rest-of-plan' pointer of the primitive plan past the
        ; action name and wff just processed, and initialize the next action (if any)
        ;; (print-current-plan-status {sub}plan-name) ; DEBUGGING
        (update-plan {sub}plan-name rest)
        ;; (print-current-plan-status {sub}plan-name) ; DEBUGGING
        (list user-action-name wff))

      ;`````````````````````
      ; User: Paraphrasing
      ;`````````````````````
      ; Next we deal with gist clauses "attributed" to the user, in user
      ; actions of form '(you paraphrase.v '<gist clause>')' in a subplan
      ; derived from a schema for handling complex user turns; i.e. we take the
      ; view that the user paraphrased these gist clauses in his/her original, 
      ; often "condensed", sentences; thus we can directly set the 'gist-clauses'
      ; properties of the user action rather than applying 'form-gist-clauses-from-input'
      ; again (as was done above for (you say-to.v me '(...)) actions).
      ((setq bindings (bindings-from-ttt-match '(you paraphrase.v _!) wff))
        (setq words (get-single-binding bindings))
        (when (not (eq (car words) 'quote))
          (format t "~%*** PARAPHRASE-ACTION ~a~%    BY THE USER ~
                    SHOULD SPECIFY A QUOTED WORD LIST" words)
          (return-from observe-next-user-action nil))
        ; Drop quote, leaving a singleton list of clauses
        (setq user-gist-clauses (cdr words))
        (setf (get user-action-name 'gist-clauses) user-gist-clauses)
        ; Advance the 'rest-of-plan' ptr of the primitive plan past the action name
        ; and wff just processed, and initialize the next action (if any)
        ;; (print-current-plan-status {sub}plan-name) ; DEBUGGING
        (update-plan {sub}plan-name rest)
        ;; (print-current-plan-status {sub}plan-name) ; DEBUGGING
        (list user-action-name wff))

      ;`````````````````````
      ; User: Replying
      ;`````````````````````
      ; Nonprimitive (you reply-to.v <eta action name>) action; we particularize this
      ; action as a subplan, based on reading the user's input
      (t
        (loop while (not input) do
          (setq input (if *live* (hear-words) (read-words))))

        ;; (format t "~% input is equal to ~a ~%" input) ; DEBUGGING

        ; "quick exit" code in the event that the user says "goodbye" or "bye".
        ; TODO: update this in the future with something that actually makes sense,
        ; such as a schema, rather than something hardcoded.
        ;; (when (or (member 'goodbye input) (member 'bye input))
	      ;;   (setq expr '(Oh\, thank you for the questions\. Good bye for now!))
        ;;   (if *live* (say-words expr) (print-words expr))
        ;;   (return-from observe-next-user-action 'exit))

        ; Make sure that any final punctuation, such as ?, ., or !,
        ; is separated from the final word (so as to not impair pattern matching)
        (when (null input)
          (delete-current-action {sub}plan-name)
          (return-from observe-next-user-action nil))
        (setq input (detach-final-punctuation input))
        ;; (format t "~%echo of input: ~a" input) ; DEBUGGING
        (setq wff1 `(you say-to.v me (quote ,input)))
        ;; (format t "~%echo of WFF1 ~a" wff1) ; DEBUGGING
        (setq user-action-name1 (action-name))
        (setf (get user-action-name1 'wff) wff1)
        (setq subplan-name (gensym "SUBPLAN"))
        ; NOTE: maybe the following is not needed
        (set subplan-name (list :episodes user-action-name1 wff1))
        (setf (get subplan-name 'rest-of-plan) (cdr (eval subplan-name)))
        ; Bidirectional hierarchical connections
        (setf (get subplan-name 'subplan-of) user-action-name)
        (setf (get user-action-name 'subplan) subplan-name)
        ;; (print-current-plan-status subplan-name) ; DEBUGGING
        (list user-action-name1 wff1))
    )
)) ; END observe-next-user-action





(defun form-gist-clauses-from-input (words prior-gist-clause)
;``````````````````````````````````````````````````````````````
; Find a list of gist-clauses corresponding to the user's 'words',
; interpreted in the context of 'prior-gist-clause' (usually a
; question output by the system). Use hierarchically related 
; choice trees for extracting gist clauses.
;
; The gist clause extraction patterns will be similar to the
; ones in the choice packets for reacting to inputs, used in
; the previous version; whereas the choice packets for reacting
; will become simpler, based on the gist clauses extracted from
; the input.
;
; TODO:
; For the purposes of the Blocksworld application, this function
; has been modified to only use one strategy for extracting gist
; clauses, which simply uses the entire input (in addition to
; potentially looking for a final question). In the future, this
; should be made more flexible somehow (without relying on hardcoded
; functionality)
;
; - look for a final question -- either yes-no, starting
;   with auxiliary + "you{r}", or wh-question, starting with
;   a wh-word and with "you{r}" coming within a few words.
;   "What about you" isa fairly common pattern. (Sometimes the
;   wh-word is not detected but "you"/"your" is quite reliable.)
;   The question, by default, is reciprocal to Eta's question.
;
;   This might use choice trees such as
;       *question-from-major-input*,
;       *question-from-favorite-class-input*,
;       etc. 
;
  (let ((n (length words)) tagged-prior-gist-clause relevant-trees 
        specific-content-tree question-content-tree chunks tagged-chunk
        clause keys specific-answers  question facts gist-clauses)

    ; Form specific answer clauses from input
    ;`````````````````````````````````````````
    ;; (format t "~% prior-gist-clause =" prior-gist-clause) ; DEBUGGING
    (setq tagged-prior-gist-clause (mapcar #'tagword prior-gist-clause))
    ;; (format t "~% tagged prior gist clause = ~a" tagged-prior-gist-clause) ; DEBUGGING
    (setq relevant-trees (cdr
      (choose-result-for tagged-prior-gist-clause '*gist-clause-trees-for-input*)))
         
    ;; (format t "~% this is a clue == ~a" (choose-result-for tagged-prior-gist-clause
    ;;   '*gist-clause-trees-for-input*))
    ;; (format t "~% relevant trees = ~a" relevant-trees) ; DEBUGGING      
    (setq specific-content-tree (first relevant-trees)
          question-content-tree (fourth relevant-trees))

    (setq specific-answer (cdr
      (choose-result-for (mapcar #'tagword words) specific-content-tree)))
    (when specific-answer
      (setq keys (second specific-answer))
      (setq specific-answer (car specific-answer))
      (store-fact (car specific-answer) keys *gist-kb*))

    ; Form final question from input
    ;````````````````````````````````
    ; Use up to 12 final words of input
    (if (> n 2) (setq question (cdr
      (choose-result-for (mapcar #'tagword (last words 12)) question-content-tree))))
    ; NOTE: questions by the user are currently not stored
    ; (though we could store the fact that the user asked them).
      
    ; The results obtained will be stored as the 'gist-clauses'
    ; property of the name of the user input. So, concatenate
    ; the above results; in reacting, Eta will pay particular
    ; attention to the first clause, and any final question.
    (setq facts (list specific-answer))
    (setq gist-clauses facts)
    (if question
      (setq gist-clauses (append facts (list question))))
	
	  ; Allow arbitrary unexpected inputs to be processed
    ; replace nil with (null gist-clauses)
    (if nil (list words)
		  gist-clauses)
)) ; END form-gist-clauses-from-input





(defun form-ulf-from-clause (clause)
;`````````````````````````````````````
; Find the ULF corresponding to the user's 'clause' (a gist clause).
; **Right now, this uses *spatial-question-ulf-tree* directly, instead of
;   using, say *clause-ulf-tree*, as a general starting point for any
;   sentential input. When *clause-ulf-tree* has been designed 
;   (branching to subtrees for assertions, questions, requests, etc.)
;   it should replace *spatial-question-ulf-tree* below.
;
; **For initial experimentation, the "raw" question rather than any
;   gist clause derived from it is processed. The idea is that we
;   would transform inputs like "What's to the right of it?" or
;   "Add another one" into gist clauses, using the prior utterance
;   or action. This should be possible with the existing gist clause
;   mechanisms. For example, if the prior utterance was "Put a red
;   block on the NVidia block", then "Add another one" should be
;   interpretable as "Put another red block on the current structure",
;   or something like that. The present program would be applied 
;   to this. Cf., the use of the tagged prior gist clause in
;   'form-gist-clauses-from-input'.
;
; Use hierarchical choice trees for extracting the ULF.
;
  (let (tagged-clause ulf)
    (setq tagged-clause (mapcar #'tagword clause))
    (setq ulf (choose-result-for tagged-clause '*clause-ulf-tree*))
 ulf)
) ; END form-ulf-from-clause





(defun store-in-context (wffs)
;```````````````````````````````
; Stores a given list of wffs in context.
; TODO: improve context - different types of facts (static & temporal), list of discourse entities, etc.
; Use hash tables?
;
  (setq *context* (append wffs *context*))
) ; END store-in-context





(defun contextual-truth-value (wff)
;`````````````````````````````````````
; TODO: implement contextual-truth-value
;
  (member wff *context* :test #'equal)
) ; END contextual-truth-value





(defun plan-cond (expr)
;````````````````````````
; Expr is a list of consecutive (cond name wff) triples. Currently, cond is either
; a pair (?var expr), in which case the condition is satisfied if the value of ?var is
; equivalent to expr, or :default, in which case the condition will be satisfied unconditionally.
; The first condition that is satisfies results in a subplan being created from the subsequent
; name and wff. If no conditions are satisfied, a nil subplan is returned.
; TODO: This should be changed in the future to allow for complicated wff's which are actually
; lists of name and wff pairs. Potentially we might also want to allow for more complex conditions.
;
  (let ((cond1 (eval-functions (first expr))) (name1 (second expr)) (wff1 (third expr)) subplan-name)
    (format t " |- ~a~% |- ~a~% |- ~a~%" cond1 name1 wff1)
    (cond
      ; None of the cases have been matched, so no subplan is generated
      ((null expr) nil)
      ; The condition is satisfied (or :default), so create a subplan from the given action & wff
      ((or (and (symbolp cond1) (equal cond1 :default))
           (and (listp cond1) (= (length cond1) 2) (equal (first cond1) (second cond1))))
        (create-simple-subplan name1 wff1))
      ; Try next (cond name wff) triple
      (t (plan-cond (cdddr expr))))
)) ; END plan-cond





(defun plan-repeat-until (prop-var expr)
;````````````````````````````````````````
; TODO: Create plan-repeat-until
; expr = (name0 wff0 name1 wff1 ...)
;
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
; TODO: I THINK I'LL ALSO NEED 'plan-seq-acts', 'plan-consec-acts', ETC.
; THESE SHOULD BE PRETTY SIMPLE, JUST LISTING THE ACTIONS & PROVIDING
; seq-ep, consec-ep, ETC. RELATIONS IN THE SUBPLAN. 
;
  (let ((name0 (first expr)) (wff0 (second expr)) (expr-rest (cddr expr)) truth-val subplan-name)
    ; First check termination condition
    (setq truth-val (contextual-truth-value wff0)) ; TODO: create contextual-truth-value
    (cond
      ; Termination has been reached - return nil so the calling program can delete loop
      (truth-val nil)
      ; Otherwise, create a subplan that has the steps of the loop & a recursive copy of the loop
      (t
        (setq subplan-name (gentemp "SUBPLAN"))
        ; Value of subplan has steps name1 wff1 name2 wff2 ... followed by (cons `(:repeat-until ,expr))
        ;; (set subplan-name (cons :episodes
        ;;   (append expr (append `(,prop-var :repeat-until) expr))))
        (set subplan-name (cons :episodes
          (append expr-rest (list prop-var (cons :repeat-until expr)))))
        (setf (get subplan-name 'rest-of-plan) (cdr (eval subplan-name)))
        (format t ">>>~a~%" (get subplan-name 'rest-of-plan))
        ;; (update-plan subplan-name (get subplan-name 'rest-of-plan))
        (format t ">>>~a~%" (get subplan-name 'rest-of-plan))
        subplan-name))
)) ; END plan-repeat-until





(defun plan-reaction-to (user-gist-clauses user-ulf)
;`````````````````````````````````````````````````````````
; Starting at a top-level choice tree root, choose an action or
; subschema suitable for reacting to 'user-gist-clauses' (which
; is one or more sentences, without tags (and with a final detached
; "\." or "?"), that try to capture the main content (gist) of
; a user input). Return the (new) name of a plan for realizing 
; that action or subschema.
;
; If the action arrived at is a particular verbal output (instantiated
; reassembly pattern, where the latter was signalled by directive :out, 
; & is indicated by ':out' in the car of the 'choose-result-for' result), 
; form a plan with one action, viz. the action of saying that verbal 
; output.
;
; If the action arrived at is another choice tree root (signalled by
; directive :subtree), this will be automatically pursued recursively
; in the search for a choice, ultimately delivering a verbal output
; or a schema name.
;
; If the action arrived at is a :schema+args "action" (a schema name
; along with an argument list), use this schema to form a subplan.
;
; ** Should the new subplan name also receive a 'semantics'
; property? ... We don't really expect a further user response to these
; reactive comments from Eta, which would then need to be understood
; in light of the meaning of these reactive comments...More thought
; required.
;
  (let (user-gist-words choice tagged-words wff subplan-name
        action-prop-name schema-name args)
    
    (if (null user-gist-clauses)
      (return-from plan-reaction-to nil))

    ; Currently we're only using a single ulf
    ; TODO: in case use of ulf is extended, we will probably want to have some
    ; way of dealing with multiple ulf in the same way that we deal with multiple
    ; gist clauses
    (if user-ulf (setq user-ulf (car user-ulf)))

    ; If the extracted ulf specifies an :out directive, we want to create a
    ; say-to.v subplan directly
    (cond
      ((and user-ulf (eq (car user-ulf) :out))
        (return-from plan-reaction-to (create-say-to-subplan (cdr user-ulf)))))

    ; We use either choice tree '*reaction-to-input*' or
    ; '*reactions-to-input*' (note plural) depending on  whether
    ; we have one or more gist clauses.
    (cond
      ; Single gist clause
      ((null (cdr user-gist-clauses))
        (setq tagged-words (mapcar #'tagword (car user-gist-clauses)))
        ;; (format t "~% (single clause) tagwords are ~a ~% " tagged-words) ; DEBUGGING
        (setq choice (choose-result-for tagged-words '*reaction-to-input*))
        ;; (format t "~% (single clause) choice are ~a ~% " choice) ; DEBUGGING
      )

      ; Multiple gist clauses
      (t
        ; Remove 'nil' gist clauses
        (setq user-gist-clauses_p (purify-func user-gist-clauses))
        ;; (format t "~% user-gist-words are ~a ~% " user-gist-clauses_p) ; DEBUGGING
        (setq user-gist-words (apply 'append user-gist-clauses_p))
        ;; (format t "~% user-gist-words are ~a ~% " user-gist-words) ; DEBUGGING
        (setq tagged-words (mapcar #'tagword user-gist-words))
        ;; (format t "~% tagwords are ~a ~% " tagged-words) ; DEBUGGING
        (setq choice (choose-result-for tagged-words '*reactions-to-input*))
        ;; (format t "~% choice is ~a ~% " choice) ; DEBUGGING
    ))

    (if (null choice) (return-from plan-reaction-to nil))

    ; 'choice' may be an instantiated reassembly pattern (prefaced by
    ; directive :out), or the name of a schema (to be initialized).
    ; In the first case we create a 1-step subplan whose action is of
    ; the type (me say-to.v you '(...)), where the verbal output is
    ; adjusted by applying 'modify-response' to the reassembly patterns.
    ; In the second case, we initiate a multistep plan.
    (cond
      ; :out directive
      ((eq (car choice) :out)
        (create-say-to-subplan (cdr choice)))

      ; :schema directive
      ((eq (car choice) :schema)
        (setq schema-name (cdr choice))
        (setq subplan-name (gensym "SUBPLAN"))
        (init-plan subplan-name schema-name nil))

      ; :schema+args directive
      ((eq (car choice) :schema+args)
        ; We assume that the cdr of 'choice' must then be of form
        ; (<schema name> <argument list>)
        ; The idea is that the separate pieces of the word sequence
        ; supply separate gist clauses that Eta may react to in the
        ; steps of the schema. These are provided as sublists in 
        ; <argument list>.
        (setq schema-name (first (cdr choice)) args (second (cdr choice)))
        (setq subplan-name (gensym "SUBPLAN"))
        (init-plan subplan-name schema-name args))

      ; :schema+ulf directive
      ((eq (car choice) :schema+ulf)
        ; TODO: Just a temporary directive to test spatial-question schema. Needs changing.
        (setq schema-name (cdr choice) args (list user-ulf nil))
        (setq subplan-name (gensym "SUBPLAN"))
        (init-plan subplan-name schema-name args))
      )
)) ; END plan-reaction-to





(defun plan-tell (info) ; TBC
;`````````````````````````````
; Return the name of a plan for telling the user the 'info';
; 'info' is a reified proposition that may be in a form that makes
; verbalization trivial, e.g.,
;     (meaning-of.f '(I am Eta. I am an autonomous avatar.))
; where the 'meaning-of.f' function in principle provides EL
; propositions corresponding to English sentences -- i.e., semantic
; parser output, reified using 'that'; but of course, for verbal-
; ization we don't need to first convert to EL! Or else the info 
; is directly in EL form, e.g.,
;     (that (me have-as.v name.n 'Eta)), or
;     (that (me be.v ((attr autonomous.a) avatar.n))),
; which requires English generation for a fully expanded tell
; act.
;
  (if (null info) (return-from plan-tell nil))
  ; TBC
) ; END plan-tell





(defun plan-description (topic) ; TBC
;`````````````````````````````````````
  (if (null info) (return-from plan-description nil))
  ; TBC
) ; END plan-description





(defun plan-suggest (suggestion) ; TBC
;````````````````````````````````````````
  (if (null suggestion) (return-from plan-suggest nil))
  ; TBC
) ; END plan-suggest





(defun plan-question (query) ; TBC
;```````````````````````````````````
  (if (null query) (return-from plan-question nil))
  ; TBC
) ; END plan-question





(defun plan-saying-hello () ; TBC
;`````````````````````````````````
  ; TBC
) ; END plan-saying-hello





(defun plan-saying-bye () ; TBC
;```````````````````````````````
  ; TBC
) ; END plan-saying-bye





(defun choose-result-for (tagged-clause rule-node)
;```````````````````````````````````````````````````
; This is just the top-level call to 'choose-result-for', with
; no prior match providing a value of 'parts', i.e., 'parts' = nil;
; this is to enable tracing of just the top-level calls
  (choose-result-for1 tagged-clause nil rule-node)
) ; END choose-result-for





(defun choose-result-for1 (tagged-clause parts rule-node)
;`````````````````````````````````````````````````````````
; This is a generic choice-tree search program, used both for
; (i) finding gist clauses in user inputs (starting with selection
; of appropriate subtrees as a function of Eta's preceding
; question, simplified to a gist clause), and (ii) in selecting
; outputs in response to (the gist clauses extracted from) user 
; inputs. Outputs in the latter case may be verbal responses
; obtained with reassembly rules, or names (possibly with
; arguments) of other choice trees for response selection, or
; the names (possibly with arguments) of schemas for planning 
; an output. The program works in essentially the same way for
; purposes (i) and (ii), but returns
;      (cons <directive keyword> result)
; where the directive keyword (:out, :subtree, :subtree+clause,
; :schema, ...) is the one associated with the rule node that
; provided the final result to the calling program. (The calling
; program is presumed to ensure that the appropriate choice tree
; is supplied  as 'rule-node' argument, and that the result is
; interpreted and used as intended for that choice tree.)
;
; So, given a feature-tagged input clause 'tagged-clause', a list 
; 'parts' of matched parts from application of the superordiate
; decomposition rule (initially, nil), and the choice tree node 
; 'rule-node' in a tree of decomposition/result rules, we generate
; a verbal result or other specified result starting at that rule,
; prefixed with the directive keyword.
;
; Decomposition rules (as opposed to result rules) have no
; 'directive' property (i.e., it is NIL). Note that in general
; a decomposition rule will fail if the pattern it supplies fails
; to match 'tagged-clause', while a result rule will fail if its
; latency requirements prevent its (re)use until more system
; outputs have been generated. (This avoids repetitive outputs.)
;
; Note also that result rules can have siblings, but not children,
; since the "downward" direction in a choice tree corresponds to
; successive refinements of choices. Further, note that if the
; given rule node provides a decomposition rule (as indicated by
; a NIL 'directive' property), then it doesn't make any direct
; use of the 'parts' list supplied to it -- it creates its own
; 'newparts' list via a new pattern match. However, if this
; match fails (or succeeds but the recursion using the children 
; returns NIL), then the given 'parts' list needs to be passed
; to the siblings of the rule node -- which after all may be 
; result rules, in particular reassembly rules.
;
; Method:
;````````
; If the rule has a NIL 'directive' property, then its 'pattern'
; property supplies a decomposition rule. We match this pattern,
; and if successful, recursively seek a result from the children
; of the rule node (which may be result rules or further decomp-
; osition rules), returning the result if it is non-nil; in case
; of failure, we recursively return a result from the siblings
; of the rule node (via the 'next' property); these siblings
; represent alternatives to the current rule node, and as such
; may be either alternative decomposition rules, or result rules 
; (with a non-nil 'directive' property) -- perhaps intended as
; a last resort if the decomposition rules at the current level
; fail.
;
; In all cases of non-nil directives, if the latency requirement
; is not met, i.e., the rule cannot be reused yet, the recursive
; search for a result continues with the siblings of the rule.
;
; If the rule node has directive property :out, then its 'pattern'
; property supplies a reassembly rule. If the latency requirement 
; of the rule is met, the result based on the reassembly rule and
; the 'parts' list is returned (after updating 'time-last-used'). 
; The latency criterion uses the 'latency' property of 'rule-node' 
; jointly with the 'time-last-used' property and the global result 
; count, *count*. 
;
; If the rule node has directive property :subtree, then 'pattern'
; will just be the name of another choice tree. If the latency 
; requirement is met, a result is recursively computed using the
; named choice tree (with the same 'tagged-clause' as input).
; The latency will usually be 0 in this case, i.e., a particular
; choice subtree can usually be used again right away.
;
; If the rule node has directive property :subtree+clause, then
; 'pattern' supplies both the name of another choice tree and
; a reassembly pattern to be used to construct a clause serving
; as input in the continued search (whereas for :subtree the
; recursion continues with the original clause). Again the
; latency will usually be 0.
;
; (June 9/19) If the rule node has directive property :ulf-recur,
; then 'pattern' supplies two reassembly rules, the first of which,
; upon instantiation with 'parts', is a list such as
;  ((*be-ulf-tree* ((is be pres))) 
;   (*np-ulf-tree* (the det def) (Nvidia name corp-name) (block cube obj))
;   (*rel-ulf-tree* (to prep dir loc) (the det def) (left noun loc) (of prep))
;   (*np-ulf-tree* (a det indef) (red adj color) (block cube obj)) 
;   (*end-punc-ulf-tree* (? end-punc ques-punc))),
; ie., a list of sublists of tagged words, with each sublist prefaced by
; the name of a rule tree to be used to produce a ulf for that sublist of
; tagged words. The instantiated reassembly rule is then processed
; further, by successively trying to get a result for each of the rule
; trees named in the sublists; if all succeed, the individual results
; are assembled into an overall ULF, and this is the result returned
; (otherwise, the result is nil -- failure). The second reassembly rule
; provides the right bracketing structure for putting together the
; individual ULFs. Example: ((1 2 (3 4)) 5); result for the above:
;     (((pres be.v) (the.d (|Nvidia| block.n)) 
;                   (to_the_left_of.p (a.d (red.a block.n)))) ?)
;
; Other directives (leading to direct return of a successful result
; rather than possible failure, leading to continuing search) are 
; - :subtrees (returning the names of multiple subtrees (e.g., 
;   for extracting different types of gist clauses from a 
;   potentially lengthy user input); 
; - :schema (returning the name of a schema to be instantiated, 
;   where this schema requires no arguments); 
; - :schemas (returning multiple schema names, perhaps as 
;   alternatives); 
; - :schema+args (a schema to be instantiated for the specified 
;   args derived from the given 'tagged-clause'); 
; - :gist (a gist clause extracted from the given 'tagged-clause,
;   plus possibly a list of topic keys for storage);
; - :ulf (June 9/19) (returning a ulf for a phrase simple enough
;   to be directly interpreted);
; - perhaps others will be added, such as :subtrees+clauses or
;   :schemas+args
;
; These cases are all treated uniformly -- a result is returned
; (with the directive) and it is the calling program's responsib-
; ility to use it appropriately. Specifically, if the latency
; requirement is met, the value supplied as 'pattern', instantiated
; with the supplied 'parts', is returned. (Thus integers appearing
; in the value pattern are interpreted as references to parts
; obtained from the prior match.) 
;

  ; First make sure we have the lexical code needed for ULF computation
  (if (not (fboundp 'eval-lexical-ulfs)) (load "eval-lexical-ulfs.lisp"))

  (let (directive pattern newparts newclause new-tagged-clause ulf ulfs result)
    ; Don't use empty choice trees
    (if (null rule-node) (return-from choose-result-for1 nil))

    ; Get directive and pattern from rule node
    (setq directive (get rule-node 'directive))
    (setq pattern (get rule-node 'pattern))

    ; If latency is being enforced, skip rule if it was used too recently
    (when (and directive *use-latency*
            (< *count* (+ (get rule-node 'time-last-used)
                          (get rule-node 'latency))))
      (return-from choose-result-for1
        (choose-result-for1 tagged-clause parts (get rule-node 'next))))

    ;; (format t "~% ***1*** Tagwords = ~a ~%" tagged-clause) ; DEBUGGING
    ;; (format t tagged-clause)
    ;; (format t "~% =====2==== Pattern/output to be matched in rule ~a = ~
    ;;            ~%  ~a and directive = ~a" rule-node pattern directive) ; DEBUGGING
  
    ; Big conditional statement for dealing with all possible directives.
    ; We first deal with cases requiring further tree-descent (with possible
    ; failure and thus recursive backtracking), no directive (i.e. decomposition
    ; rule), :subtree, :subtree+clause, and :ulf-recur
    (cond
      ;``````````````````
      ; No directive
      ;``````````````````
      ; Look depth-first for more specific match, otherwise try alternatives
      ((null directive)
        (setq newparts (match1 pattern tagged-clause))
        ;; (format t "~% ----3---- new part = ~a ~%" newparts) ; DEBUGGING

        ; Pattern does not match 'tagged-clause', search siblings recursively
        (if (null newparts)
          (return-from choose-result-for1
            (choose-result-for1 tagged-clause parts (get rule-node 'next))))

        ; Pattern matched, try to obtain recursive result from children
        (setq result
          (choose-result-for1 tagged-clause newparts (get rule-node 'children)))

        (if result (return-from choose-result-for1 result)
                   (return-from choose-result-for1
                      (choose-result-for1 tagged-clause parts (get rule-node 'next)))))

      ;`````````````````````
      ; :subtree directive
      ;`````````````````````
      ; Recursively obtain a result from the choice tree specified via its
      ; root name, given as 'pattern'
      ((eq directive :subtree)
        (setf (get rule-node 'time-last-used) *count*)
        (return-from choose-result-for1
          (choose-result-for1 tagged-clause parts pattern)))

      ;````````````````````````````
      ; :subtree+clause directive
      ;````````````````````````````
      ; Similar to :subtree, except that 'pattern' is not simply the root
      ; name of a tree to be searched, but rather a pair of form
      ; (<root name of tree> <reassembly pattern>), indicating that the
      ; reassembly pattern should be used together with 'parts' to reassemble
      ; some portion of 'tagged-clause', whose results should then be used
      ; (after re-tagging) in the recursive search.
      ((eq directive :subtree+clause)
        (setf (get rule-node 'time-last-used) *count*)
        (setq newclause (instance (second pattern) parts))
        (setq new-tagged-clause (mapcar #'tagword newclause))
        (return-from choose-result-for1
          (choose-result-for1 new-tagged-clause nil (car pattern))))

      ;````````````````````````
      ; :ulf-recur directive
      ;````````````````````````
      ; Find the instance of the rule pattern determined by 'parts',
      ; which will be a shallow analysis of a text segment, of the
      ; form described in the initial commentary; try to find results
      ; (ULFs) for the component phrases, and if successful assemble
      ; these into a complete ULF for the input. NB: (first pattern)
      ; supplies the top-level phrasal segments to be further analyzed
      ; (using the ulf rule trees heading each phrasal segment), while
      ; (second pattern) supplies the bracketing structure for the
      ; phrasal ULFs.
      ((eq directive :ulf-recur)
        ; Instantiate shallow analysis
        (setq newclause (instance (first pattern) parts))
        ; Interpret recursive phrases; the car of each nonatomic phrase
        ; either gives the name of the relevant rule tree to use, or it
        ; is 'lex-ulf!'; in the former case we proceed recursively, in
        ; the latter we keep the phrase as-is
        (dolist (phrase newclause)
          (if (or (atom phrase) (eq (car phrase) 'lex-ulf!))
            (setq ulf phrase) ; e.g., ulf of (next to) = next_to.p
            (setq ulf
              (choose-result-for (mapcar #'tagword (cdr phrase)) (car phrase))))
          ; If failure, exit loop
          (when (null ulf)
            (setq ulfs nil)
            (return-from choose-result-for1 nil))
          (push ulf ulfs))
        ; Assemble the (initially reversed) list of phrasal ULFs into a
        ; ULF for the entire input, using the second reassembly rule
        (when ulfs
          (setq n (length ulfs)) ; number of phrasal ULFs
          (setq result (second pattern)) ; bracket structure with indices
          (dolist (ulf ulfs)
            (setq ulf (eval-lexical-ulfs ulf))
            (setq result (subst ulf n result))
            (decf n)))
        (return-from choose-result-for1 result))

      ; Now we deal with cases expected to directly return a result,
      ; not requiring allowance for failure-driven backtracking

      ;`````````````````
      ; :ulf directive
      ;`````````````````
      ; In the case of ULF computation we don't prefix the result with
      ; the directive symbol; this is in contrast with  cases like :out,
      ; :gist, :schema, etc., where the schema executor needs to know
      ; what it's getting back as result for an input, and hence what
      ; to do with it
      ((eq directive :ulf)
        (setq result (instance pattern parts))
        (setq result (eval-lexical-ulfs result))
        (return-from choose-result-for1 result))

      ;```````````````````````
      ; :ulf-coref directive
      ;```````````````````````
      ; Obtains a ulf result using the subtree & input specified in the pattern, and
      ; then resolves the coreferences in the resulting ulf
      ; TODO: Implement coreference resolution (ulf case)
      ((eq directive :ulf-coref)
        (setq newclause (instance (second pattern) parts))
        (setq new-tagged-clause (mapcar #'tagword newclause))
        (setq result (choose-result-for1 new-tagged-clause nil (car pattern)))
        (setq result (coref-ulf result))
        ;; (format t "discourse entities are ~a~%" *discourse-entities*) ; DEBUGGING
        (return-from choose-result-for1 result))

      ;```````````````````````
      ; :gist-coref directive
      ;```````````````````````
      ; TODO: Implement coreference resolution (gist case)
      ((eq directive :gist-coref)
        (setq result (cons directive (instance pattern parts)))
        (setf (get rule-node 'time-last-used) *count*)
        (setq result (coref-gist result))
        (return-from choose-result-for1 result))

      ;```````````````````````````````
      ; Misc non-recursive directives
      ;```````````````````````````````
      ; TODO: Remove temporary :schema+ulf directive once solution is found
      ((member directive '(:out :subtrees :schema :schemas 
                           :schema+args :gist :schema+ulf))
        (setq result (cons directive (instance pattern parts)))
        (setf (get rule-node 'time-last-used) *count*)
        (return-from choose-result-for1 result))

      ; A directive is not recognized
      (t
        (format t "~%*** UNRECOGNIZABLE DIRECTIVE ~s ENCOUNTERED ~
                  FOR RULE ~s~%    FOR THE FOLLOWING PATTERN AND TAGGED ~
                  CLAUSE: ~%    ~s,  ~s" directive rule-node pattern tagged-clause))
    )
)) ; END choose-result-for1






