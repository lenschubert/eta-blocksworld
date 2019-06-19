(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '( (friend friends)
    (family grandchildren grandchild children child daughter daughters son sons spouse wife husband siblings brother brothers sister sisters
      niece nephew parents mother father grandparents grandmother grandfather)
    (neighbour neighbours)
    (colleague colleagues coworker coworkers partner partners cofounder cofounders)
    (stranger strangers)
    (unforgettable amazing enjoyable happy incredible hospitable best good nice memorable lovely wonderful welcoming)
   ))
  
;;	How have you shared cooking with people in your life? 
;;	(0 I have shared cooking with 0)
;;	share-cooking-with-others
;;		gist-question:	(1 how 2 shared cooking 1 people 3)
	

(READRULES '*specific-answer-from-share-cooking-with-others-input*
   '(1 (0 family 0) ;; I think the gist clause format doesn't correspond with the question here
        2 ((I have shared cooking with my 2 \.)  (share-cooking-with-others)) (0 :gist)     
     1 (0 friend 0) 
        2 ((I have shared cooking with my 2 \.)  (share-cooking-with-others)) (0 :gist)
     1 (0 neighbour 0) 
        2 ((I have shared cooking with my 2 \.)  (share-cooking-with-others)) (0 :gist)
     1 (0 colleague 0) 
        2 ((I have shared cooking with my 2 \.)  (share-cooking-with-others)) (0 :gist)
     1 (0 stranger 0) 
        2 ((I have shared cooking with 2 \.)  (share-cooking-with-others)) (0 :gist)
     1 (0 NEG 2 unforgettable 0) 
        2 ((My experiences of shared cooking is not 3 4 \.)  (share-cooking-with-others)) (0 :gist)
     1 (0 unforgettable 0) 
        2 ((My experiences of shared cooking is 2 \.)  (share-cooking-with-others)) (0 :gist)
     1 (0)
       2 ((NIL Gist \: nothing found for whom I have shared cooking with \.) (share-cooking-with-others)) (0 :gist)))
       
       
 (READRULES '*thematic-answer-from-share-cooking-with-others-input*
    '())

 (READRULES '*unbidden-answer-from-share-cooking-with-others-input*
    '())
		
 (READRULES '*question-from-share-cooking-with-others-input*
    '(1 (0 how 2 you shared cooking 0)
        2 (How have you shared cooking with people in your life ?) (0 :gist)
      1 (0 who 2 you shared cooking 0)
        2 (How have you shared cooking with people in your life ?) (0 :gist)
	    1 (0 wh_ 4 shared cooking 0)
        2 (How have you shared cooking with people in your life ?) (0 :gist)
      ))

(READRULES '*reaction-to-share-cooking-with-others-input*
   '(1 (0 NEG 3 unforgettable 0) ; it's risky to cover words describing emotions, but I feel like it's necessary since if they talk about
                                 ; some bad memories then it is strange to respond something like "I'm glad that you had fun".
       2 (You are sorry to hear that I didn\'t particularly like my meal\.) (100 :out)
     1 (0 unforgettable 0)
       2 (It sounds adorable that I shared an 2 meal\. You have had some wonderful meals with your best friend\. Her name is Sarah\.) (100 :out)
     1 (0 family 0)
       2 (You used to cook for your family at weekends\. It feels good to spend time with family after work\.) (100 :out)
     1 (0 friend 0)
       2 (You are glad to hear that I had fun\.) (100 :out)
     1 (0 neighbour 0)
       2 (You remember cooking with your neighbour\. We used to have barbecue together\.) (100 :out)
     1 (0 colleague 0)
       2 (You used to eat with your work friends\. It\'s a great way to enhance relationships\.) (100 :out)
     1 (0 stranger 0)
       2 (Sharing cooking with 2 sounds great\! Talking to people I don\'t know before can always give me a fresh perspective\.) (100 :out) 
     1 (0 NIL Gist 0)
       2 (You find cooking to be a pretty good way to hang out with people\.) (100 :out)
	))
); end of eval-when
