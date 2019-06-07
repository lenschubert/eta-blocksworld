(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '( (school university college course courses class classes)
    (parents father mother)
    (family-member grandparents grandmother grandfather parents father mother uncle aunt siblings brother brothers sister sisters)
    (book books recipes recipe)
    (myself internet)
    (learn-to-cook-two learn-to-cook-two-school learn-to-cook-two-book)
    (learn-to-cook-two-school middle high school cooking class classes course courses college university dorm)
    (learn-to-cook-two-book cooking book books)
    ;(learn-to-cook-two-self self learning)
   ))
  
;;	How did you learn to cook?
;;	(0 I learned cooking 0)  (0 I do not know 2 cook 0) 
;;	learn-to-cook
;;		gist-question:(1 how 2 learn to cook 4) 


 
	

(READRULES '*specific-answer-from-learn-to-cook-input*
   '(1 (1 NEG 2 know 2 cook 0) 
        2 ((I do not know how to cook \.)  (learn-to-cook)) (0 :gist) 
     1 (0 learn-to-cook-two learn-to-cook-two 0) 
        2 ((I learned cooking from my 2 3 \.)  (learn-to-cook)) (0 :gist) 
     1 (0 school 0) 
        2 ((I learned cooking from my 2 \.)  (learn-to-cook)) (0 :gist) 
     1 (0 family-member 0) 
        2 ((I learned cooking from my 2 \.)  (learn-to-cook)) (0 :gist)   
     1 (0 book 0) 
        2 ((I learned cooking from my 2 \.)  (learn-to-cook)) (0 :gist)
     1 (0 myself 0)
        2 ((I learned cooking by 2 \.)  (learn-to-cook)) (0 :gist)
     1 (0 roommate 0)
        2 ((I learned cooking from my roommate \.)  (learn-to-cook)) (0 :gist)
     1 (0 friend 0)
        2 ((I learned cooking from my friend \.)  (learn-to-cook)) (0 :gist)
     
	 1 (0)
       2 ((NIL Gist \: nothing found for whom I learned cooking \.) (learn-to-cook)) (0 :gist)
	 ))
        
       
 (READRULES '*thematic-answer-from-learn-to-cook-input*
    '())

 (READRULES '*unbidden-answer-from-learn-to-cook-input*
    '())
		
 (READRULES '*question-from-learn-to-cook-input*
    '(1 (0 what 2 you 0)
        2 (How do you learn to cook ?) (0 :gist)
      1 (0 how 2 you 0)
        2 (How do you learn to cook ?) (0 :gist)
      ))

(READRULES '*reaction-to-learn-to-cook-input*
   '(1 (1 NEG 0)
       2 (Okay\. You don\'t know cooking either\.) (100 :out)
     1 (0 learn-to-cook-two learn-to-cook-two 0)
       2 (0 learn-to-cook-two-school learn-to-cook-two-school 0) 
          3 (You learned making some mexican food from your roommate while in college\. It was so much fun\.) (100 :out)    
       2 (0 learn-to-cook-two-book learn-to-cook-two-book 0) 
          3 (You like cooking based on recipes from books because they are easy to follow\.) (100 :out)  
     1 (0 school 0)
       2 (You learned making some mexican food from your roommate while in college\. It was so much fun\.) (100 :out)
     1 (0 family-member 0)
       2 (Many people that you know learned cooking from their 2 \.) (100 :out)
     1 (0 book 0)
       2 (You like cooking based on recipes from books because they are easy to follow\.) (100 :out)
     1 (0 myself 0)
       2 (I seem like a very independent person\.) (100 :out) 
	 1 (0 roommate 0)
       2 (You learned making some mexican food from your roommate while in college\. It was so much fun\.) (100 :out) 
	 1 (0 friend 0)
       2 (You learned making some mexican food from a mexican neighbor who used to live in neighborhood when you was young\. It was so much fun\.) (100 :out) 
	1 (0 NIL Gist 0)
	  2 (You think the internet is very helpful for finding good recipes\.) (100 :out) 
	
	))
); end of eval-when
