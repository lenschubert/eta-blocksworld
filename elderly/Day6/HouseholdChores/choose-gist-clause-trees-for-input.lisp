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
;;	What household chores did you work on today ?
;;  What is the household chore you enjoy the most ?
;;  How did it make you feel a time you helped someone else with a household chore ?

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
 '(1 (3 what 3 household chores 4 today 3)
    2 (*specific-answer-from-householdChores-today-input* 
       *unbidden-answer-from-householdChores-today-input*
       *thematic-answer-from-householdChores-today-input*
       *question-from-householdChores-today-input*) (0 :subtrees)
   1 (3 what 2 household chore 2 enjoy 3)
    2 (*specific-answer-from-householdChore-enjoy-input* 
       *unbidden-answer-from-householdChore-enjoy-input*
       *thematic-answer-from-householdChore-enjoy-input*
       *question-from-householdChore-enjoy-input*) (0 :subtrees)
   1 (3 How 4 feel 3 helped 4 household chore 3)
    2 (*specific-answer-from-householdChore-help-others-input* 
       *unbidden-answer-from-householdChore-help-others-input*
       *thematic-answer-from-householdChore-help-others-input*
       *question-from-householdChore-help-others-input*) (0 :subtrees)
)))
