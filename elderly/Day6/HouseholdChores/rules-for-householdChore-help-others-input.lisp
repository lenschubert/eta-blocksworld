(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
  	(friend friends)
    (family grandchildren grandchild children child daughter daughters son sons spouse wife husband siblings brother brothers sister sisters
      parents mother father grandparents grandmother grandfather uncle uncles aunt aunts)
    (neighbour neighbours neighbor neighbors)

    (happy amazing enjoyable good great nice memorable lovely wonderful welcoming)
    (normal boring tedious ok okay)

    (help helped helps)
    (help-object friend family neighbour)
  ))
   
;;  Tell me about a time you helped someone else with a chore. How did it make you feel? 
;;	gist: How did it feel a time you helped someone else with a household chore ?
;;	(0 I helped someone with 0) (0 felt 2 I helped someone with household chores 0)
;;	householdChore-help-others
;;	(3 How 4 feel 3 helped 4 household chore 3)

	

(READRULES '*specific-answer-from-householdChore-help-others-input*
  '( 1 (1 NEG 1 help 2 household 0) ;; e.g. I haven't really helped someone with household
        2 ((I have not helped anyone with household \.)  (householdChore-enjoy)) (0 :gist) ;; new gist clause format needed
     1 (0 help-object 6 cleaning-verb cleaning-noun 0) 
        2 ((I helped 3 with 4 5 \.)  (householdChore-help-others)) (0 :gist)
     1 (0 help-object 6 feeding 1 pets 0) 
        2 ((I helped 2 with 4 5 \.)  (householdChore-help-others)) (0 :gist)
     1 (0 help-object 6 doing laundry 0) 
        2 ((I helped 2 with 4 5 \.)  (householdChore-help-others)) (0 :gist)
     1 (0 help-object 6 preparing meals 0) 
        2 ((I helped 2 with 4 5 \.)  (householdChore-help-others)) (0 :gist)
     1 (0 help-object 6 watering plants 0) 
        2 ((I helped 2 with 4 5 \.)  (householdChore-help-others)) (0 :gist)
     1 (0 help-object 6 weeding garden 0) 
        2 ((I helped 2 with 4 5 \.)  (householdChore-help-others)) (0 :gist)
     1 (0 help-object 6 bathing pets 0) 
        2 ((I helped 2 with 4 5 \.)  (householdChore-help-others)) (0 :gist)
     1 (0 help-object 6 pruning trees 0) 
        2 ((I helped 2 with 4 5 \.)  (householdChore-help-others)) (0 :gist)
     1 (0 help-object 6 cooking 0) 
        2 ((I helped 2 with cooking \.)  (householdChore-help-others)) (0 :gist)
     1 (0 help-object 6 arranging 0) 
        2 ((I helped 2 with 4 \.)  (householdChore-help-others)) (0 :gist)
     1 (0 help-object 6 laundry 0) 
        2 ((Doing I helped 2 with laundry \.)  (householdChore-help-others)) (0 :gist)
     1 (0 help-object 6 cleaning-verb 0) 
        2 ((I helped 2 with 4 \.)  (householdChore-help-others)) (0 :gist)
    ; ====================================================================================

     1 (0 cleaning-verb cleaning-noun 0) 
        2 ((I helped someone with 2 3 \.)  (householdChore-help-others)) (0 :gist)
     1 (0 feeding 1 pets 0) 
        2 ((I helped someone with 2 3 \.)  (householdChore-help-others)) (0 :gist)
     1 (0 doing laundry 0) 
        2 ((I helped someone with 2 3 \.)  (householdChore-help-others)) (0 :gist)
     1 (0 preparing meals 0) 
        2 ((I helped someone with 2 3 \.)  (householdChore-help-others)) (0 :gist)
     1 (0 watering plants 0) 
        2 ((I helped someone with 2 3 \.)  (householdChore-help-others)) (0 :gist)
     1 (0 weeding garden 0) 
        2 ((I helped someone with 2 3 \.)  (householdChore-help-others)) (0 :gist)
     1 (0 bathing pets 0) 
        2 ((I helped someone with 2 3 \.)  (householdChore-help-others)) (0 :gist)
     1 (0 pruning trees 0) 
        2 ((I helped someone with 2 3 \.)  (householdChore-help-others)) (0 :gist)
     1 (0 cooking 0) 
        2 ((I helped someone with 2 \.)  (householdChore-help-others)) (0 :gist)
     1 (0 arranging 0) 
        2 ((I helped someone with 2 \.)  (householdChore-help-others)) (0 :gist)
     1 (0 laundry 0) 
        2 ((Doing I helped someone with 2 \.)  (householdChore-help-others)) (0 :gist)
     1 (0 cleaning-verb 0) 
        2 ((I helped someone with 2 \.)  (householdChore-help-others)) (0 :gist)

    ;============================================================================
     1 (0 friend 0) 
        2 ((I helped 2 with household chores \.)  (householdChore-help-others)) (0 :gist)
     1 (0 family 0) 
        2 ((I helped 2 with household chores \.)  (householdChore-help-others)) (0 :gist)
     1 (0 neighbour 0) 
        2 ((Doing I helped 2 with household chores \.)  (householdChore-help-others)) (0 :gist)
     1 (0 happy 0) 
        2 ((It felt 2 when I helped someone with household chores \.)  (householdChore-help-others)) (0 :gist)
     1 (0 normal 0) 
        2 ((It felt 2 when I helped someone with household chores \.)  (householdChore-help-others)) (0 :gist)
  	1 (0)
       2 ((NIL Gist \: nothing found for the household chore I helped someone with \.) (householdChore-help-others)) (0 :gist)
))
       
       
 (READRULES '*thematic-answer-from-householdChore-help-others-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-householdChore-help-others-input*
  '(
  ))
		
 (READRULES '*question-from-householdChore-help-others-input*
  '(  1 (0 how 2 you 2 chores 0)
        2 (How can you do chores ?) (0 :gist)
      1 (3 How 4 feel 3 helped 3 household chore 3)
        2 (How did it make you feel a time you helped someone else with a household chore ?) (0 :gist)
  ))

(READRULES '*reaction-to-householdChore-help-others-input*
  '( 1 (0 NEG helped 0) 
        2 (Okay\. You used to help your kids with household \.) (100 :out)

     1 (0 friend 0) 
        2 (Helping friends out is a nice thing to do\.) (100 :out)
     1 (0 family 0) 
        2 (You also used to help your 2 doing household chores\.) (100 :out)
     1 (0 neighbour 0) 
        2 (You am going to cover your neighbour\'s chores this week\. They help each other out from time to time\.) (100 :out)

     1 (0 happy 0) 
        2 (You am glad to hear that you liked helping people with chores\.) (100 :out)
     1 (0 normal 0) 
        2 (Doing chores can be boring sometimes\.) (100 :out)

  	 1 (0 cleaning-verb 1 cleaning-noun 0) ;; e.g. wash the floor
        2 (People need to keep our 4 clean\. ) (100 :out)
     1 (0 feeding pets 0) 
        2 (You helped feeding your friend\‘s dog several times\. He is quite cooperative so it is good\.) (100 :out)
     1 (0 doing laundry 0) 
        2 (You have helped doing laundry for your kids\.) (100 :out)
     1 (0 preparing meals 0) 
        2 (You cook meals with your friends from time to time in college\.) (100 :out)
     1 (0 watering plants 0) 
        2 (Sounds nice that I are helping someone watering plants\.) (100 :out)
     1 (0 weeding garden 0) 
        2 (You used to volunteer to help people weeding our garden in college\.) (100 :out)
     1 (0 bathing pets 0) 
        2 (You helped feeding your friend\'s dog but have never helped bathing it\.) (100 :out)
     1 (0 pruning trees 0) 
        2 (You used to volunteer to help people weeding our garden in college\.) (100 :out)
     1 (0 cooking 0) 
        2 (You cook meals with your friends from time to time in college\.) (100 :out)
     1 (0 arranging 0) 
        2 (You rarely help people arranging our stuff becuase you are not familiar with our habit of arranging things\.) (100 :out)
     1 (0 laundry 0) 
        2 (You have helped doing laundry for your kids\.) (100 :out)
     1 (0 cleaning-verb 0) 
        2 (People need to keep our place clean\. ) (100 :out)
      1 (0 NIL Gist 0) 
       2 (You usually help your kids getting used to doing chores\.) (100 :out)
  ))
); end of eval-when
