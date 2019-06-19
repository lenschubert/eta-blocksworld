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
;;	What do you use your smartphone if you have one ?
;;  What is the best part of advances in technology ?
;;  What is the hardest part of advances in technology ?

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
 '(1 (3 What 2 use your smartphone 6)
    2 (*specific-answer-from-smartphone-use-input* 
       *unbidden-answer-from-smartphone-use-input*
       *thematic-answer-from-smartphone-use-input*
       *question-from-smartphone-use-input*) (0 :subtrees)
   1 (3 what 3 best part of advances in technology 3)
    2 (*specific-answer-from-technology-best-part-input* 
       *unbidden-answer-from-technology-best-part-input*
       *thematic-answer-from-technology-best-part-input*
       *question-from-technology-best-part-input*) (0 :subtrees)
   1 (3 What 3 hardest part of advances in technology 3)
    2 (*specific-answer-from-technology-hardest-part-input* 
       *unbidden-answer-from-technology-hardest-part-input*
       *thematic-answer-from-technology-hardest-part-input*
       *question-from-technology-hardest-part-input*) (0 :subtrees)
)))
