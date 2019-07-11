
;; July, 11/19: define the schema *reactions-to-spatial-question*
;; ================================================================
;; 
;; This is intended to "work" for one or more non-question gist 
;; clauses followed by a final gist-clause question.
;;
;; The idea is to react to the question first, followed by "so" 
;; (as a new-topic-initiation signal), followed by a reaction to
;; the initial gist clause. (So this schema ignores any intermediate
;; clauses.) 
;;
;; An alternative would be to react to the initial gist clause
;; first, followed by "As for your question," or something similar;
;; in general, it seems to require stronger discourse signals to
;; get back to an unanswered question than to get back to another
;; component of the user's input. Also, this would work well for 
;; question-deflection responses by Eta like "Let's keep the 
;; focus on you". Anyway, in future, we might provide multiple
;; applicable schemas in "choose-reactions-to-input.lisp", and
;; choose from these (via a small choice tree, even if only to
;; vary response styles by using non-zero latency?)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *reactions-to-spatial-question*

  (Event-schema ((me react-to-spatial-question ?var ?earlier-ques) ** ?e)
  ; ?var would be the name of the (you say-to.v me '...) action
  ; that now has a ULF version of the question attached to it;
  ; the ?earlier-ques would be the previous question asked by the
  ; user -- this would be for possible referent interpretation,
  ; especially if it alse has an attached ULF; but maybe this
  ; wouldn't be an explicit argument, but rather attached
  ; somewhere, & reachable by searching backwards...
    :actions ?a1. (me seek-answer-from.v |Spatial-QA-Server| '?ulf)
               ; this would send the ulf (obtained from the properties
               ; of the actual name replacing ?var) to an appropriate
               ; file, monitored by the Spatial-QA-Server; the server
               ; would empty the file after reading it;
              ?a2. (me receive-answer-from.v |Spatial-QA-Server| '?ans+alternates)
               ; the value of ?ans+alternates would be read off from a file
               ; to which Spatial-QA-Server sends the answer (with weighted
               ; alternates); once ; the answer is read off, the file would
               ; be emptied.
              ?a3. (me conditionally-say-to.v you '?ans)
               ; here ?ans is split off from ?ans+alternates;
               ; "conditionally say to you" would normally expand
               ; into just (me say-to.v you '?ans); but I'm thinking
               ; of keeping the door open to something more complex,
               ; in cases where Georgiy's system provides multiple,
               ; weighted possibilities, in which case one might
               ; instantiate a subplan for generating a main answer
               ; but also mention alternates (attached as property
               ; to ?a3., I suppose).

)) ; end of parameter *reactions-to-spatial-question*


(setf (get '*reactions-to-spatial-question* 'semantics) 
      (make-hash-table))
 ; To fill this in, EL formulas would need to be derived from
 ; Eta reactions (not yet used). This would be rather unlike
 ; the explicit 'store-output-semantics' used in *Eta-schema*
 ; (see "Eta5-schema.lisp").


(setf (get '*reactions-to-spatial-question* 'gist-clauses) 
      (make-hash-table))
 ; Much the same comment as above applies -- something other than
 ; the straightforward 'store-output-gist-clauses' used in
 ; the *Eta-schema* code would be needed.

