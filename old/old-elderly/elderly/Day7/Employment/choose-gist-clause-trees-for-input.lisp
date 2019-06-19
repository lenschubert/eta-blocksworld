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
;;	How did work benefit you ?
;;  what is the best part of the retirement ?
;;  What are some ways you give back to your community ?

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
 '(1 (3 How 2 work benefit 3)
    2 (*specific-answer-from-work-benefit-input* 
       *unbidden-answer-from-work-benefit-input*
       *thematic-answer-from-work-benefit-input*
       *question-from-work-benefit-input*) (0 :subtrees)
   1 (3 what 2 best part 2 retirement 3)
    2 (*specific-answer-from-retirement-best-part-input* 
       *unbidden-answer-from-retirement-best-part-input*
       *thematic-answer-from-retirement-best-part-input*
       *question-from-retirement-best-part-input*) (0 :subtrees)
   1 (3 What 2 ways 3 give back to your community 3)
    2 (*specific-answer-from-give-back-to-community-input* 
       *unbidden-answer-from-give-back-to-community-input*
       *thematic-answer-from-give-back-to-community-input*
       *question-from-give-back-to-community-input*) (0 :subtrees)
)))
