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
;;  Do you think your doctor takes your concerns seriously ?
;;	What are the qualities of a good doctor ?
;;  how are you managing your health concerns ?

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
 '(1 (3 Do you think 2 doctor takes 3 concerns seriously 3) 
    2 (*specific-answer-from-doctor-attitude-concerns-input* 
       *unbidden-answer-from-doctor-attitude-concerns-input*
       *thematic-answer-from-doctor-attitude-concerns-input*
       *question-from-doctor-attitude-concerns-input*) (0 :subtrees)
   1  (3 what 2 qualities of a good doctor 3) 
    2 (*specific-answer-from-good-doctor-qualities-input* 
       *unbidden-answer-from-good-doctor-qualities-input*
       *thematic-answer-from-good-doctor-qualities-input*
       *question-from-good-doctor-qualities-input*) (0 :subtrees)
   1 (3 how 2 you managing 2 health concerns 3)
    2 (*specific-answer-from-managing-health-concerns-input* 
       *unbidden-answer-from-managing-health-concerns-input*
       *thematic-answer-from-managing-health-concerns-input*
       *question-from-managing-health-concerns-input*) (0 :subtrees)
)))
