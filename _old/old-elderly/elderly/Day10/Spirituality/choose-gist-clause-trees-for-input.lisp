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
;;	Do you attend religious services ?
;;  What ways is spirituality a part of your life ?
;;  How does spirituality help you ?

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
 '(1 (3 Do you 3 religious services 3)
    2 (*specific-answer-from-religious-services-input* 
       *unbidden-answer-from-religious-services-input*
       *thematic-answer-from-religious-services-input*
       *question-from-religious-services-input*) (0 :subtrees)
   1 (3 What ways 2 spirituality a part of your life 3)
    2 (*specific-answer-from-spirituality-part-of-life-input* 
       *unbidden-answer-from-spirituality-part-of-life-input*
       *thematic-answer-from-spirituality-part-of-life-input*
       *question-from-spirituality-part-of-life-input*) (0 :subtrees)
   1 (3 How does spirituality help you 3 )
    2 (*specific-answer-from-spirituality-helps-you-input* 
       *unbidden-answer-from-spirituality-helps-you-input*
       *thematic-answer-from-spirituality-helps-you-input*
       *question-from-spirituality-helps-you-input*) (0 :subtrees)
)))
