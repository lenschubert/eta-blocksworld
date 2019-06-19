(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; I don't like either
    ;; Response: "If your doctor strongly recommended you exercise, would you prefer doing it alone or with others?"

  (alt-focus focus concentrate concentration motivate motivated motivating)
  (alt-distracted distracted distracting annoying annoy annoyed)
  (alt-alone alone myself own)
  (alt-judge judge judgement judging embarrass embarrassing conscious shy)
  (alt-fun fun exciting engaging social entertaining)
  (alt-others others other friend friends group groups team class)

  ))

;; 	Do you like to exercise on your own or with other people?  
;;	(0 I like to exercise alone 0)  ;; one can extend the gist clause by adding some reason and make the appropriate reaction
;;	(0 I like to exercise with other people 0)
;;	exercise-alone-vs-withothers
;;	(Do you like to exercise alone or with other people ?) 
;;	(3 Do you like 2 exercise alone or with other people 3)  
	
(READRULES '*specific-answer-from-exercise-alone-vs-withothers-input*
  '(
  1 (0 alt-alone 4 alt-focus 0)
    2 ((I like to exercise alone because it helps me focus better \.) (exercise-alone-vs-withothers)) (0 :gist)
  1 (0 alt-alone 4 NEG 1 alt-distracted 0)
    2 ((I like to exercise alone because it helps me focus better \.) (exercise-alone-vs-withothers)) (0 :gist)
  1 (0 alt-alone 4 alt-judge 0)
    2 ((I like to exercise alone because I feel self conscious \.) (exercise-alone-vs-withothers)) (0 :gist)
  1 (0 alt-others 4 alt-fun 0)
    2 ((I like to exercise with other people because it is more fun \.) (exercise-alone-vs-withothers)) (0 :gist)
  1 (0 alt-others 4 alt-focus 0)
    2 ((I like to exercise with other people because it helps me focus better \.) (exercise-alone-vs-withothers)) (0 :gist)
  1 (0 alt-others 4 NEG 1 alt-distracted 0)
    2 ((I like to exercise with other people because it helps me focus better \.) (exercise-alone-vs-withothers)) (0 :gist)
  1 (0 alt-alone 0)
    2 ((I like to exercise alone \.) (exercise-alone-vs-withothers)) (0 :gist)
  1 (0 alt-others 0)
    2 ((I like to exercise with other people \.) (exercise-alone-vs-withothers)) (0 :gist)
  1 (0)
    2 ((NIL Gist \: nothing found for if I like to exercise alone \.) (exercise-alone-vs-withothers)) (0 :gist)
)) 
       
 (READRULES '*thematic-answer-from-exercise-alone-vs-withothers-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-exercise-alone-vs-withothers-input*
  '(
  
  ))
		
 (READRULES '*question-from-exercise-alone-vs-withothers-input*
  '(
  1 (0 what 2 you 0)
     2 (Do you like to exercise alone or with other people ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (Do you like to exercise alone or with other people ?) (0 :gist)
  ))

(READRULES '*reaction-to-exercise-alone-vs-withothers-input*
  '( 
  1 (0 NIL Gist 0)
    2 (Everyone has their own preferences when it comes to exercising\. Either way is fine as long as I have some way to get myself excited for it\!) (100 :out)
  1 (0 helps me focus 0)
    2 (You understand\, sometimes talking with people while exercising can be a big interruption\.) (100 :out)
  1 (0 feel self conscious 0)
    2 (Many people feel shy when exercising\! People usually don\'t judge me as much as I think they do though\.) (100 :out)
  1 (0 helps me focus 0)
    2 (Having others to motivate me certainly does make a difference\!) (100 :out)
  1 (0 is more fun 0)
    2 (Exercising with other people does help make it feel a lot less boring\.) (100 :out)
  1 (0 like to exercise alone 0)
    2 (Exercising alone is understandable\, sometimes being in a group can be very distracting\.) (100 :out)
  1 (0 like to exercise with other people 0)
    2 (Exercising with others is a great way to be social as well as get fit\.) (100 :out)
  ))
); end of eval-when
