(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
    (family grandchildren grandchild children child daughter daughters son sons spouse wife husband siblings brother brothers sister sisters
      parents mother father grandparents grandmother grandfather cousin cousins uncle aunt)
    (friend friends)
    (university course courses school advisor advisors consultant consultants accountant) 
    (video TV shows show radio web online) 
    (life experience)
    (read reading book books magazine article articles paper newspapers)
    ))
   

;;	How did you learn about managing money?
;;	gist: How did you learn about managing money ?
;;	(0 learned 2 managing money 0)
;;	manage-money-learn
;;	(2 How 2 learn 2 managing 2 money 2) (2 how 2 you make money 2)

	

(READRULES '*specific-answer-from-manage-money-learn-input*
  '(1 (0 family 0)
      2 ((I learned managing money from 2 \.) (manage-money-learn)) (0 :gist)
    1 (0 friend 0)
      2 ((I learned managing money from 2 \.) (manage-money-learn)) (0 :gist)
    1 (0 university 0)
      2 ((I learned managing money from 2 \.) (manage-money-learn)) (0 :gist)
    1 (0 read 0)
      2 ((I learned managing money from 2 \.) (manage-money-learn)) (0 :gist)
    1 (0 video 0)
      2 ((I learned managing money from 2 \.) (manage-money-learn)) (0 :gist)
    1 (0 life 0)
      2 ((I learned managing money from experience \.) (manage-money-learn)) (0 :gist)
    1 (0)
       2 ((NIL Gist \: nothing found for how I learned about managing money \.) (manage-money-learn)) (0 :gist)
))
       
       
 (READRULES '*thematic-answer-from-manage-money-learn-input*
  '(
  ))

 (READRULES '*unbidden-answer-from-manage-money-learn-input*
  '(
  ))
		
 (READRULES '*question-from-manage-money-learn-input*
  '(
    ;;new question
    1 (0 how 1 you 1 make money ?)
      2 (How can you make money ?) (0 :gist)
    1 (0 how 2 you 1 managing money ?)
      2 (How did you learn about making money ?) (0 :gist)
    1 (0 what 2 travel 2 you 1 enjoy 0)
      2 (How did you learn about making money ?) (0 :gist)
    1 (0 wh_ 2 travel 2 you 1 enjoy 0)
      2 (How did you learn about making money ?) (0 :gist)
  ))

(READRULES '*reaction-to-manage-money-learn-input*
  '( 
    1 (0 family 0)
      2 (Right\, most people learned how to manage their money from family\. 
        It is reasonable that you learned it from 2\.) (100 :out)
    1 (0 friend 0)
      2 (Right\, friends affect us in many ways\. 
        When your friend told me the way he deals with his money\, you decided to try it too\.) (100 :out)
    1 (0 university 0)
      2 (Learning from 2 is convincing\. You think it is a credible way to get information\.) (100 :out)
    1 (0 video 0)
      2 (Learning from 2 is convenient\. But I should distinguish whether it is credible\.) (100 :out)
    1 (0 read 0)
      2 (Learning from 2 is convenient\. But I should distinguish whether it is credible\.) (100 :out)
    1 (0 life 0)
      2 (Right\, actually\, most people learn to manage their money from their daily life\.) (100 :out) 
    1 (0 NIL Gist 0) 
      2 (Okay\. Sounds like a good way to learn managing money\.) (100 :out)
  ))
); end of eval-when
