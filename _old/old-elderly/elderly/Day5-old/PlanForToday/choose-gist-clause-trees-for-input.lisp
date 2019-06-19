;; File for setting up the choice tree *gist-clause-trees*,
;; which selects among specific gist-clause extraction trees
;; for processing a user input, based on a feature-augmented 
;; initial gist clause for Lissa's output (usually a question
;; to the user that prompted the input).
;;
;; The following Lissa gist clauses are from "lissa5-schema.lisp",
;; where 'store-output-gist-clauses' is used to store output
;; gist clauses in a hash table indexed by action proposition
;; variables, and the hash table itself is accessed as property
;; 'gist-clauses' of *lissa-schema*:
;;
;;	What is your plan after this session?
;;  What will you have for dinner tonight?
;;  What do you like to do to wind down before bed? 

;;
;;   While these are hand-supplied, the idea is that ultimately
;;   they would be set up automatically via NLP. For example,
;;   "Did you find it hard?" might readily lead to gist clause
;;   "Did you find your favorite class hard?" if we can successfully
;;   resolve the anaphor. More subtly, a trailing question "What
;;   about you?" often seems interpretable as a kind of analogical
;;   variant of the speaker's preceding assertion, just changing
;;   a nominal (etc.) phrase -- e.g., "I'm a comp sci major"  --> 
;;   "I'm a ... major"; "My favorite movie is Bladerunner"  --> 
;;   "My favorite movie is ...", etc.
;;
;;   This is why we don't simply use a verbatim match to Lissa's
;;   output.

(eval-when (load eval)

(READRULES '*gist-clause-trees-for-input*
 '(1 (2 What 2 plan after this session 2)
    2 (*specific-answer-from-plan-after-this-session-input* 
       *unbidden-answer-from-plan-after-this-session-input*
       *thematic-answer-from-plan-after-this-session-input*
       *question-from-plan-after-this-session-input*) (0 :subtrees)
   1 (2 What you have 2 dinner tonight 2)
    2 (*specific-answer-from-dinner-tonight-input* 
       *unbidden-answer-from-dinner-tonight-input*
       *thematic-answer-from-dinner-tonight-input*
       *question-from-dinner-tonight-input*) (0 :subtrees)
   1 (2 What 2 do 3 wind down before bed 2)
    2 (*specific-answer-from-wind-down-before-bed-input* 
       *unbidden-answer-from-wind-down-before-bed-input*
       *thematic-answer-from-wind-down-before-bed-input*
       *question-from-wind-down-before-bed-input*) (0 :subtrees)
)))
