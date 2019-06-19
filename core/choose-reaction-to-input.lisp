(eval-when (load eval)

(mapc 'attachfeat ; needed for detecting alternatives in the
                  ; watching-or-reading question
  '())

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
 '(1 (0) 
    2 *reaction-to-example-input* (0 :subtree)
   ))

 (READRULES '*reaction-to-unexpected*
 '())
 
); end of eval-when

