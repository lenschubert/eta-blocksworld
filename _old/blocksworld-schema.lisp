; July 6/18
; For QA to test Eta's spatial relation understanding.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Collaborative problem solving in the blocks world
; `````````````````````````````````````````````` 
; (perhas named *blocks-qa-schema-1*)
; ``````````````````````````````````````
 (defparameter *blocks-qa-schema-1*
 '(event-schema ?e (?x asks-about-blocks-world-relations.v ?y) 
  ;```````````````````````````````````````````````````````````
   "person ?x asks robot assistant ?y about various blocks-world spatial relations"
   ; At present (as of June 2018) I'm assuming that schemas have just one
   ; main variable, which may be an episode- or object-variable, immediately
   ; followed by the type (characterization) of the episode or object.
   ; Probably episode schemas should be divided into situation-schemas,
   ; event-schemas, and process-schemas.

   :Fixed-roles 
     ; "Fixed" means that the variable that is the argument of the predicate
     ; retains the same value throughout any schema instance, and is known
     ; from the outset; (but this may be an unnecessary distinction); all 
     ; are tacit Skolem functions of ?e
     ?x person1.n  ; this means (?x person.n)
     ?y robot1.n  
     ?t table1.n 
     ?bb (plur block1.n)
   :Var-roles 
     ?u utterance1.n 
     ; We use !-variables as abbreviations for formulas. 
     ; Thus !x denotes (?x person1.n), !y denotes (?y robot1.n), ..., etc.
   :Static-conds 
     ?s1 (?x at-loc.p ?t)
     ?s2 (?y at-loc.p ?t)
     ; We will also use !s1 as abbreviation of "?s1 is characterized by 
     ; (?x at-loc.p ?t)", i.e., ((?x at-loc.p ?t) ** ?s1), & likewise !s2, etc.
   :Goals(?x) 
     ?g1 (?x want1.v (that ((set-of ?x ?y) converse1.v)))
     ?g2 (?y want1.v (that ((set-of ?x ?y) converse1.v)))
     ; All formulas up to here are presupposed to be true (they must have
     ; been established by prior planning, or through happenstance)
   :Events 
     ; Elsewhere I've used :Intended-episodes (& maybe :Side-effects)
     ; I've also deleted this as greeting should be reactive (see below):
     ; ?e2 ((set-of ?x ?y) exchange1.v (k (plur greeting.n)))
     ?e1 (?y say-to.v ?x
             '(OK\, I'm ready to try to answer questions about relationships
              among the blocks in front of us))
     ?e2 (:repeat-until
          ?e3 (?e2 finished2.a); holds at all times after ?e2 has been finished;
                              ; so we need to make provision for storing this in
                              ; *context* (for the event name that replaces ?e2)
                              ; 
          ?e4 (?x say-to.v ?y ?u); some utterance ?u, expected to be a question
                                 ; ?y will interpret ?u & save the interpretation
          ?e5 (:if (?u ((nn termination.n) request.n)); check interpretation of ?u
                   (:store-in-context '(?e2 finished2.a)))
                   ; syntax allows additional steps, & one or more :else-if segments,
                   ; and after :else-if, :else can head the final sequence of steps;
          ?e6 (?y react-to.v ?e4)
              ; this will typically be answering a question, but could be reacting
              ; to a good-bye (a termination request also leading to storage of
              ; (?e2 finished2.a), as specified above); it could also be 
              ; a reaction to any any other comment. ** One issue: If we go 
              ; a few times around the loop w/o getting any spatial-relation
              ; questions, how can ?x nudge ?y to ask such questions?
          ); end of repeat-loop

   :Event-relations ; 'before1.p' means "immediately before"; when allowing 
                    ; for some delay, we use 'before2.p'. We use EL rather
                    ; than keywords, since time relationships can be complex
                    ; and numerical, e.g., "at least 1 minute before ...";
     !w1 (?e1 before1.p ?e2); i.e., consecutive episodes
     !w2 (?e4 before1.p ?e5 ?e6)
     ; Note: the execution sequencing is by default in the order of listing,
     ;   with at least modest gaps allowed (=~ length of the actions). But 
     ;   we can add constraints here (e.g., as done here via 'before1.p').
     ;   However, if a constraint is added involving events ?e', ?e" from 
     ;   the same (sub)sequence of schema events, then *all* constraints
     ;   that apply to events in the sequential span from ?e' to ?e" must
     ;   be specified; in other words, the specified constraints for that
     ;   span override their ordering in the schema.
     ; Note: I think we could also have sentential connectives that imply
     ;   event-sequencing for conjoined wffs; e.g. (phi and-then.cc psi), or
     ;   (phi and-imm.cc psi), or maybe even (phi and.cc (eventually.adv-e psi))
   :Necessities; these apply to roles, static-conds and goals; unity by default;
               ; Meaning: how necessary the conditions are for successful execution.
               ; Recall: for var. ?x of specified type P, !x stands for (?x P);
               ; a pair (!x c) stands for ((that !x) is-necessary-to-degree c).
     (!x .5) (!y .5) (!t .5) (!bb .99) (!u .99) (!s1 1) (!s2 1) (!g1 1) (!g2 1)
   :Certainties
     (!e4 .9); i.e., ((that !e4) certain-to-degree .8); 
             ; **Hmm, but what would ?y do if user ?x fails to speak?
     ; Note that certainties generally are used only for expected events
   end.) 
 ); end of *blocks-qa-schema-1*

; Note that a variable like ?e4 (in the loop) will in general be instantiated
; multiple times in an instantiation of the schema in a behavioral process. 
; The loop will be unwound, i.e., we form a subplan containing one instance
; of loop steps, and a final copy of the loop. Since subplans have their 
; own hash tables for their variables, we will have unambiguous access to
; the values of the variables in each repetition of the loop. 
;
; For example, instantiating the above schema will give one top-level value
; for ?e2, and the subplan for that instance will (eventually) have values
; for ?e4-?e6 (for the initial iteration), as well as its own value for ?e2,
; which will be the identifier the rest of the iterative action within the
; subplan. The embedded ?e2 event will again be realized as a (sub)subplan,
; etc. 

; Evident requirements to executing this schema:
; `````````````````````````````````````````````
; We need mechanisms that will place relevant facts in the current-state KB:
; - must *assume* that (?x at-loc.p ?t), (?y at-loc.p ?t) (because the 
;   "looking for" ?x, the table ?t, and the blocks comes *after* schema
;   initialization; similarly for the "wanting" to converse.
; - adding to the kb that (?y see1.v ...) for whatever it sees; also, if
;   it sees the members of a set, then it should affirmatively evaluate that
;   it sees the set; so we need an introspection algorithm for verifying
;   a set-property that requires only that the members have that property;

; Comments (following draft of the above schema):
; ```````````````````````````````````````````````
; Ultimately I need to allow for plan modification by interrupts -- speech
; actions or other events that are not anticipated in the plan/schema, and
; certain actions by ?y may be prompted by arising circumstances. After all,
; "anything can happen" -- the human collaborator might say or request something
; unexpected, another person might show up, blocks might get added or fall off
; the table, ?y might notice a problem or need information, etc. 
;
; So for example, initial greetings might be inserted via rules -- if ?y
; hasn't seen ?x for a while, expect to exchange greetings. 
; 
; It occurs to me as well that we might separate expectations from corresponding
; reactions when those expectations are met. For example, when someone asks an
; instructor a question in class, answering is reactive -- it's not necessary that
; the expectation to answer already be in the lecture plan, even though some
; questions may be expected. It's just that the question itself engenders the
; obligation to answer. In general, our behavior is of course a mixture of
; reactive and planned or rote behavior. We need to smoothly integrate these.
; It's worth noting that standard dialogue management techniques are essentially
; reactive: dialogue state transitions are driven by rules dictating what to
; do in response to the immediately preceding dialogue event.
;
; I'll try formulating reaction schemas for greeting, Q/A, and (eventually)
; responding to requests for action.

(reaction-schema (?me greet1.v ?you)
;````````````````````````````````````
"Here ?me is the first greeter, prompted by seeing ?you, and not having seen 
?you for an hour or more, or never having met ?you. The greeting depends on the
recency of last seeing ?you, name knowledge, and status of ?you. The variables
?me & ?you can be instantiated with any distinct individuals, but ?me is intended
to be instantiated by an agent when it is using the schema to react, rather than
to predict another agent's reaction."

:Fixed-roles 
   !w1 (?me person1.n) 
   !w2 (?you person1.n)
:Trigger-conds 
   ?t1 ((set-of ?you ?me) meet1.v)
   ?t2 ((adv-e (for-dur.p (k (one.a hour.n))))   ; minimal criterion for
         (not (?me in-speaking-range-of.p ?you))) ; *considering* greeting
:Actions
   ?a1 (?me save2-as.v ?dur (hours-since! (th e (e (last.a epi.n)) 
                                             (((set-of ?you ?me) together.a) ** e))))
                             ; a directly executable "memory operation"
   ?a2 (if (?dur nonexistent1.a); never met before
           (?me greet-unknown-person.v ?you); a specialized schema
           (?dur > 8760); a year
           (?me greet-long-unseen-person.v ?you); a specialized schema
           (?dur > 720); a month
           (?me greet-rather-long-unseen-person.v ?you); a specialized schema
           (?dur > 168); a week
           (?me greet-several-days-unseen-person.v ?you); e.g., "Hi, how are you?"
           (?dur > 24); a day
           (?me greet-one-day-unseen-person.v ?you) ; E.g., Hi/hey plus ?you's name
           (?dur > 4);
           (?me greet-several-hours-unseen-person.v ?you) ; e.g., "hi", "Hello again"
           (?dur > 2)
           (?me greet-two-hours-unseen-person.v ?you); e.g., smile, nod 
           (?dur > 1)
           (?me greet-one-hour-unseen-person.v ?you); perhaps just a friendly look
        ); the "if" construct expects alternating conditions and actions
   end.)

(reaction-schema (?me co-greet1.v ?you)
;``````````````````````````````````````
"Here ?me is the second greeter, with ?you already having greeted ?me. In this
case, ?me's greeting is normally more like an echo..."

:Participants
   !w1 (?me person1.n) 
   !w2 (?you person1.n)
:Trigger-conds
   ?t1 ((adv-e for-dur.p (k (five.a (plur minute.n)))) (not (?me greet1.v ?you)))
   ?t2 (?you greet.v ?me); minimal criteria for returning greeting
:Actions
   ?a1 (?me save2-as.v ?dur (hours-since! (th e (e (last.a epi.n))  
                                             (((set-of ?you ?me) together.a) ** e))))
   ?a2 (?me echo-greet.v ?you ?t2.)
   ; We could make this much more complicated by taking account of the style
   ; of ?you's greeting and the hours since ?you was last seen, but that's
   ; not high-priority at the time of writing.
:ordering-constraints; NB: action are sequential (interruptions allowed) if not
   !w3 (?t1 consec ?t2 ?a1 ?a2) ; otherwise constrained.

 )

(event-schema (?me greet-unknown-person.v ?you)
 "TBC; should say hello, &  self-introduce"
 )