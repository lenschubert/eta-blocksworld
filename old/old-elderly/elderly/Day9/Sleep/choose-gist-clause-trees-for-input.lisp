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
;;	How do you sleep at night ?
;;  Do you think that naps during the day are helpful ?
;;  What do you do to improve your sleep ?

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
 '(1 (3 how 2 sleep 2 night 3) 
    2 (*specific-answer-from-sleep-quality-input* 
       *unbidden-answer-from-sleep-quality-input*
       *thematic-answer-from-sleep-quality-input*
       *question-from-sleep-quality-input*) (0 :subtrees)
   1 (3 do you think 2 naps 5 helpful 3) 
    2 (*specific-answer-from-opinion-about-nap-input* 
       *unbidden-answer-from-opinion-about-nap-input*
       *thematic-answer-from-opinion-about-nap-input*
       *question-from-opinion-about-nap-input*) (0 :subtrees)
   1 (3 What 4 improve your sleep 3)
    2 (*specific-answer-from-improve-sleep-input* 
       *unbidden-answer-from-improve-sleep-input*
       *thematic-answer-from-improve-sleep-input*
       *question-from-improve-sleep-input*) (0 :subtrees)
)))
