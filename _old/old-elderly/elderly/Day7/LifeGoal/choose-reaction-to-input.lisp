;; "choose-reaction-to-input.lisp" (for single gist clause inputs)
;; ===============================================================
;; File for choosing a reaction to a feature-augmented gist
;; clause extracted from a user's answer to a question. In
;; general, the gist clause is expected to provide sufficient
;; information to allow choice of a comment (if warranted) from
;; Lissa, based on choice trees for specific answers, thematic
;; answers, and potentially a final question in the gist
;; clause list.
;;
;; This packet is for single clauses -- see 
;;     "choose-reactions-to-input.lisp"
;; (note the plural) for a packet that makes a choice of a schema
;; depending on multiple gist clauses extracted from the user 
;; input -- but realizing the steps of the schema again depend
;; on the choice packet in this file, and the choice trees 
;; referenced here.
;; 
;; The gist clause input is expected to be of the (at least
;; approximate) form currently constructed by the choice trees
;; for extracting gist clauses from user input, specifically
;; the inputs responsing to the questions (as gist clauses)
;;
;;	What is a personal goal you are working on to stay healthy ?
;;  How can being healthier improve your life quality ?
;;  What steps have you taken to achieve your goal ?

(eval-when (load eval)

(mapc 'attachfeat ; needed for detecting alternatives in the
                  ; watching-or-reading question
  '( ))

(READRULES '*reaction-to-input*
  ; Choose between reaction to a question and an assertion
  ; Only one gist clause is expected here
 '(1 (0 wh_ 3 you 0)
    2 *reaction-to-question* (0 :subtree)
   1 (0 wh_ 3 your 0)
    2 *reaction-to-question* (0 :subtree)
   1 (0 aux your 0)
    2 *reaction-to-question* (0 :subtree)
   1 (0 aux you 0)
    2 *reaction-to-question* (0 :subtree)
   1 (0 right-really 4 ?)
    2 *reaction-to-question* (0 :subtree)
   1 (0); by default, it's an assertion
    2 *reaction-to-assertion* (0 :subtree)
 ))

(READRULES '*reaction-to-assertion*
  ; Very rough initial attempt.
  ; Actually, it seems we could readily provide reactions
  ; directly here, instead of delegating to specialized
  ; choice trees. However, it seems we have better oversight
  ; by using separate choice trees, specified in a file that
  ; also contains the specialized features for the topic at
  ; issue.
  ;
; e.g., 
 '(1 (0 personal goal I am working on to stay healthy 0) 
    2 *reaction-to-goal-stay-healthy-input* (0 :subtree)
    
; e.g., 
   1 (0 being healthier improves my life quality 0)
    2 *reaction-to-being-healthier-life-quality-input* (0 :subtree)

; e.g., 
   1 (0 step that I have taken to achieve my goal 0)
    2 *reaction-to-steps-achieve-goal-input* (0 :subtree)
   
   ))
 
 (READRULES '*reaction-to-unexpected*
   '(1 (0 thank you 0)
      2 *user-thanks-schema* (0 :schema))
 )
 
)

