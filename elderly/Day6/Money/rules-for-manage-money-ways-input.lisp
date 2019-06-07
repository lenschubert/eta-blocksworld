(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
    (budget plan planning)
    (advisor advisors consultant consultants)
    (credit card report)
    (software app apps)
    (family grandchildren grandchild children child daughter daughters son sons spouse wife husband siblings brother brothers sister sisters
      parents mother father grandparents grandmother grandfather cousin cousins uncle aunt)
    ))
   
;;  What are some ways you manage your money? For example, tell me about 
;;	some of your strategies to pay bills on time or strategies for saving money.
;;	gist: What are some ways you manage your money ?
;;	(0 way 3 manage 1 money 0)
;;	manage-money-ways
;;	(2 What 2 ways 1 manage 1 money 2)
	

(READRULES '*specific-answer-from-manage-money-ways-input*
  '(1 (0 budget 0 )
      2 ((The way I manage my money is having plan \.) (manage-money-ways)) (0 :gist)
    1 (0 advisor 0 )
      2 ((The way I manage my money is getting help from 2 \.) (manage-money-ways)) (0 :gist)
    1 (0 credit credit 0 )
      2 ((The way I manage my money is checking 2 3 on time \.) (manage-money-ways)) (0 :gist)
    1 (0 software 0 )
      2 ((The way I manage my money is getting help from 2 \.) (manage-money-ways)) (0 :gist)
    1 (0 family 0 )
      2 ((The way I manage my money is getting help from 2 \.) (manage-money-ways)) (0 :gist)
    1 (0)
       2 ((NIL Gist \: nothing found for a way to manage my money \.) (manage-money-ways)) (0 :gist)
 ))
       
       
 (READRULES '*thematic-answer-from-manage-money-ways-input*
  '(
  ))

 (READRULES '*unbidden-answer-from-manage-money-ways-input*
  '( 
  ))
		
 (READRULES '*question-from-manage-money-ways-input*
  '(1 (0 how 1 you 1 make money ?)
      ;;new question
      2 (how can you make money ?) (0 :gist)
    1 (0 how 2 you 1 manage 1 money 0)
      2 (What are some ways you manage your money ?) (0 :gist)
    1 (0 what 2 you 1 manage 1 money 0)
      2 (What are some ways you manage your money ?) (0 :gist)
    1 (0 wh_ 2 you 1 manage 1 money 0)
      2 (What are some ways you manage your money ?) (0 :gist)
  ))

(READRULES '*reaction-to-manage-money-ways-input*
  '(1 (0 budget 0)
      2 (It is brilliant to have a plan to manage my money\. It can help me to save money\.) (100 :out)
    1 (0 advisor 0)
      2 (I can get many professional suggestion from 2 \.) (100 :out)
    1 (0 credit credit 0)
      2 (Check 2 3 is a good habbit to manage my money\.) (100 :out)
    1 (0 software 0)
      2 (Sounds cool that I can use modern technology to manage my money\.) (100 :out)
    1 (0 family 0)
      2 (I manage my money with the help with 2 \.) (100 :out)
    1 (0 NIL Gist 0)
      2 (That is a good way to manage my money\.) (100 :out)
   ))
); end of eval-when
