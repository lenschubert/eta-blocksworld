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
;;	What are some ways you manage your money ?
;;  Is managing money stressful for you ?
;;  How did you learn about managing money ?

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
 '(1 (3 how far 3 go in school 3)
    2 (*specific-answer-from-education-how-far-input* 
       *unbidden-answer-from-education-how-far-input*
       *thematic-answer-from-education-how-far-input*
       *question-from-education-how-far-input*) (0 :subtrees)
   1 (3 what part 3 education 2 most meaningful 3)
    2 (*specific-answer-from-education-most-meaningful-input* 
       *unbidden-answer-from-education-most-meaningful-input*
       *thematic-answer-from-education-most-meaningful-input*
       *question-from-education-most-meaningful-input*) (0 :subtrees)
   1 (3 what 2 think 3 lifelong learning 3)
    2 (*specific-answer-from-thoughts-about-lifelong-learning-input* 
       *unbidden-answer-from-thoughts-about-lifelong-learning-input*
       *thematic-answer-from-thoughts-about-lifelong-learning-input*
       *question-from-thoughts-about-lifelong-learning-input*) (0 :subtrees)
)))
