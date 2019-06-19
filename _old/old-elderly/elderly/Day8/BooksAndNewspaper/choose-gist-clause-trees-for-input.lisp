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
;;	What kinds of books do you like to read ? 
;;  How often do you read the newspaper ?
;;  Do you like to discuss politics ?

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
 '(1 (3 What kinds of books 2 like to read 3)
    2 (*specific-answer-from-books-like-to-read-input* 
       *unbidden-answer-from-books-like-to-read-input*
       *thematic-answer-from-books-like-to-read-input*
       *question-from-books-like-to-read-input*) (0 :subtrees)
   1 (3 How often 2 read 2 newspaper 3) 
    2 (*specific-answer-from-newspaper-how-often-input* 
       *unbidden-answer-from-newspaper-how-often-input*
       *thematic-answer-from-newspaper-how-often-input*
       *question-from-newspaper-how-often-input*) (0 :subtrees)
   1 (3 Do you like 2 discuss politics 5)
    2 (*specific-answer-from-like-politics-input* 
       *unbidden-answer-from-like-politics-input*
       *thematic-answer-from-like-politics-input*
       *question-from-like-politics-input*) (0 :subtrees)
)))
