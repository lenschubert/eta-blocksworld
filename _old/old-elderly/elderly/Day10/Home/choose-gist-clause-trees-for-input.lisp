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
;;	Do you live in an apartment or a house ?
;;  What would you do to make you feel comfortable in your home ?
;;  What is a memory you have of one of your homes ?

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
 '(1 (3 do you live 2 apartment 2 house 3)
    2 (*specific-answer-from-place-you-live-input* 
       *unbidden-answer-from-place-you-live-input*
       *thematic-answer-from-place-you-live-input*
       *question-from-place-you-live-input*) (0 :subtrees)
   1 (3 What 2 you do 2 make you feel comfortable 2 home 3)
    2 (*specific-answer-from-things-comfortable-home-input* 
       *unbidden-answer-from-things-comfortable-home-input*
       *thematic-answer-from-things-comfortable-home-input*
       *question-from-things-comfortable-home-input*) (0 :subtrees)
   1 (3 What 2 memory 6 your homes 3)
    2 (*specific-answer-from-memory-from-home-input* 
       *unbidden-answer-from-memory-from-home-input*
       *thematic-answer-from-memory-from-home-input*
       *question-from-memory-from-home-input*) (0 :subtrees)
)))
