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
;;	What kinds of exercise do you do these days?
;;  Do you like to exercise on your own or with other people?
;;  Do you like to exercise outdoors or in a gym? 

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
 '(1 (3 what 2 exercise 2 you do 3)
    2 (*specific-answer-from-exercises-you-do-input* 
       *unbidden-answer-from-exercises-you-do-input*
       *thematic-answer-from-exercises-you-do-input*
       *question-from-exercises-you-do-input*) (0 :subtrees)
   1 (3 Do you like 2 exercise alone or with other people 3)
    2 (*specific-answer-from-exercise-alone-vs-withothers-input* 
       *unbidden-answer-from-exercise-alone-vs-withothers-input*
       *thematic-answer-from-exercise-alone-vs-withothers-input*
       *question-from-exercise-alone-vs-withothers-input*) (0 :subtrees)
   1 (3 Do you 2 exercise outdoors or 2 gym 3) 
    2 (*specific-answer-from-exercise-outdoors-vs-gym-input* 
       *unbidden-answer-from-exercise-outdoors-vs-gym-input*
       *thematic-answer-from-exercise-outdoors-vs-gym-input*
       *question-from-exercise-outdoors-vs-gym-input*) (0 :subtrees)
)))
