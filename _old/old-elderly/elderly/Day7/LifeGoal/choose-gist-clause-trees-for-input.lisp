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
;;	What is a personal goal you are working on to stay healthy ?
;;  How can being healthier improve your life quality ?
;;  What steps have you taken to achieve your goal ?

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
 '(1 (3 What 2 personal goal 3 working 3 healthy 3)
    2 (*specific-answer-from-goal-stay-healthy-input* 
       *unbidden-answer-from-goal-stay-healthy-input*
       *thematic-answer-from-goal-stay-healthy-input*
       *question-from-goal-stay-healthy-input*) (0 :subtrees)
   1 (3 how 2 being healthier 2 improve your life quality 4)
    2 (*specific-answer-from-being-healthier-life-quality-input* 
       *unbidden-answer-from-being-healthier-life-quality-input*
       *thematic-answer-from-being-healthier-life-quality-input*
       *question-from-being-healthier-life-quality-input*) (0 :subtrees)
   1 (3 What steps 4 achieve your goal 3)
    2 (*specific-answer-from-steps-achieve-goal-input* 
       *unbidden-answer-from-steps-achieve-goal-input*
       *thematic-answer-from-steps-achieve-goal-input*
       *question-from-steps-achieve-goal-input*) (0 :subtrees)
)))
