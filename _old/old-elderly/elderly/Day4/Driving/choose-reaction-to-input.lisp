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
;; the inputs responding to the questions (as gist clauses)
;;
;;	What do you remember about your first car ?
;;  Have you ever taken a fun road trip ?
;;  How one can cope with giving up driving ?

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
 '(   1 (0 my first car 0)
    2 *reaction-to-first-car-input* (0 :subtree)
    
; e.g., 
   1 (0 I 1 never taken 2 road trip 0) 
    2 *reaction-to-road-trips-input* (0 :subtree)
	
	1 (0 I took 2 road trip 0) 
    2 *reaction-to-road-trips-input* (0 :subtree)

; e.g., 
   1 (0 way 1 cope with giving up driving 0)
    2 *reaction-to-giving-up-driving-input* (0 :subtree)

   1 (0 do not know 2 deal with giving up driving 0)
    2 *reaction-to-giving-up-driving-input* (0 :subtree)
   ))
 
 (READRULES '*reaction-to-unexpected*
   '(1 (0 thank you 0)
      2 *user-thanks-schema* (0 :schema))
 )
 
)

