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
;;	What types of art do you enjoy ?
;;  Have you ever taken lessons in a kind of art ?
;;  How does art help you cope with negative emotions ?

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
 '(1 (3 What types of art 2 you enjoy 3)
    2 (*specific-answer-from-art-type-you-enjoy-input* 
       *unbidden-answer-from-art-type-you-enjoy-input*
       *thematic-answer-from-art-type-you-enjoy-input*
       *question-from-art-type-you-enjoy-input*) (0 :subtrees)
   1 (3 Have you ever taken lessons 5 art 3)
    2 (*specific-answer-from-art-lessons-input* 
       *unbidden-answer-from-art-lessons-input*
       *thematic-answer-from-art-lessons-input*
       *question-from-art-lessons-input*) (0 :subtrees)
   1 (3 How 2 art help 2 cope 2 negative emotions 3) 
    2 (*specific-answer-from-ways-art-helps-input* 
       *unbidden-answer-from-ways-art-helps-input*
       *thematic-answer-from-ways-art-helps-input*
       *question-from-ways-art-helps-input*) (0 :subtrees)
)))
