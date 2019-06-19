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
;;	How would you stay physically active ?
;;  How can you keep your brain active ?
;;  How one can cope with hearing or vision loss ?

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
 '(1 (3 How 2 stay physically active 3)
    2 (*specific-answer-from-stay-physically-active-input* 
       *unbidden-answer-from-stay-physically-active-input*
       *thematic-answer-from-stay-physically-active-input*
       *question-from-stay-physically-active-input*) (0 :subtrees)
   1 (3 How 2 keep your brain active 3) 
    2 (*specific-answer-from-keep-brain-active-input* 
       *unbidden-answer-from-keep-brain-active-input*
       *thematic-answer-from-keep-brain-active-input*
       *question-from-keep-brain-active-input*) (0 :subtrees)
   1 (3 how 2 cope with hearing 2 vision loss 3)
    2 (*specific-answer-from-hearing-vision-loss-cope-input* 
       *unbidden-answer-from-hearing-vision-loss-cope-input*
       *thematic-answer-from-hearing-vision-loss-cope-input*
       *question-from-hearing-vision-loss-cope-input*) (0 :subtrees)
)))
