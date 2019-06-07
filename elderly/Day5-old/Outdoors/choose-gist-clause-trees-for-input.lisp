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
;;	What is a recent outdoor activity you have done?
;;  What is your favorite season to be outdoors?
;;  What do you enjoy doing when the weather keeps you indoors?

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
 '(1 (2 what 2 recent outdoor activity 4)
    2 (*specific-answer-from-recent-outdoor-activity-input* 
       *unbidden-answer-from-recent-outdoor-activity-input*
       *thematic-answer-from-recent-outdoor-activity-input*
       *question-from-recent-outdoor-activity-input*) (0 :subtrees)
   1 (2 What 2 favorite season 2 outdoors 2) 
    2 (*specific-answer-from-favorite-season-outdoors-input* 
       *unbidden-answer-from-favorite-season-outdoors-input*
       *thematic-answer-from-favorite-season-outdoors-input*
       *question-from-favorite-season-outdoors-input*) (0 :subtrees)
   1 (2 What 2 enjoy 3 weather keeps you indoors 2) 
    2 (*specific-answer-from-things-enjoy-doing-indoors-input* 
       *unbidden-answer-from-things-enjoy-doing-indoors-input*
       *thematic-answer-from-things-enjoy-doing-indoors-input*
       *question-from-things-enjoy-doing-indoors-input*) (0 :subtrees)
)))
