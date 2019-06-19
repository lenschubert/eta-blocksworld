(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
    (solo alone)
    (friend friends)
    (family grandchildren grandchild children child daughter daughters son sons spouse wife husband siblings brother brothers sister sisters 
      parents mother father grandparents grandmother grandfather cousin cousins uncle aunt)
    (short weekend multiday days)
    (long months years)
    (term time period)
    (package group)
    (backpacking hiking camping camp adventure)
    (event bussiness)
    (sightseeing tourism relaxing tour)
  ))
   
;; 	What types of travel do you enjoy?
;;	(0 enjoy 2 travel 0)
;;	travel-enjoy
;;	(2 What types of travel 2 enjoy 2)
	

(READRULES '*specific-answer-from-travel-enjoy-input*
  '(
    1 (0 NEG solo 0)
      2 ((I do not enjoy to travel alone \.) (travel-enjoy)) (0 :gist)
    1 (0 solo 0)
      2 ((I enjoy travel alone \.) (travel-enjoy)) (0 :gist)
    1 (0 with friend 0)
      2 ((I enjoy travel with 3 \.) (travel-enjoy)) (0 :gist)
    1 (0 visiting friend 0)
      2 ((I enjoy travel to visit friends \.) (travel-enjoy)) (0 :gist)
    1 (0 with family 0)
      2 ((I enjoy travel with 3 \.) (travel-enjoy)) (0 :gist)
    1 (0 visiting family 0)
      2 ((I enjoy travel to visit family \.) (travel-enjoy)) (0 :gist)
    1 (0 short term 0)
      2 ((I enjoy travel in 2 time \.) (travel-enjoy)) (0 :gist)
    1 (0 long 0)
      2 ((I enjoy travel in 2 time \.) (travel-enjoy)) (0 :gist)
    1 (0 package 0)
      2 ((I enjoy 2 travel \.) (travel-enjoy)) (0 :gist)
    1 (0 backpacking 0)
      2 ((I enjoy 2 travel \.) (travel-enjoy)) (0 :gist)
    1 (0 event 0)
      2 ((I enjoy 2 travel \.) (travel-enjoy)) (0 :gist)
    1 (0 sightseeing 0)
      2 ((I enjoy travel for 2 \.) (travel-enjoy)) (0 :gist)
    1 (0 NEG like 2 road trip 0)
      2 ((I do not enjoy road trip travel \.) (travel-enjoy)) (0 :gist)
    1 (0 road trip 0)
      2 ((I enjoy road trip travel \.) (travel-enjoy)) (0 :gist)

    1 (0 NEG 2 like 2 travel 0)
      2 ((I do not enjoy to travel \.) (travel-enjoy)) (0 :gist)
    1 (0)
       2 ((NIL Gist \: nothing found for if I enjoy travel \.) (travel-enjoy)) (0 :gist)
	   ))
       
       
 (READRULES '*thematic-answer-from-travel-enjoy-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-travel-enjoy-input*
  '(
  ))
		
 (READRULES '*question-from-travel-enjoy-input*
  '(
    ;;new question
    1 (0 how 2 you 1 travel ?)
      2 (How can you take a vacation ?) (0 :gist)
    1 (0 how 2 you 1 have 1 vacation 0)
      2 (How can you take a vacation ?) (0 :gist)
    1 (0 how 2 you 1 take 1 vacation 0)
      2 (How can you take a vacation ?) (0 :gist)
    1 (0 what 2 travel 2 you 1 enjoy 0)
      2 (What types of travel do you enjoy ？) (0 :gist)
    1 (0 how 2 travel 2 you 1 enjoy 0)
      2 (What types of travel do you enjoy ?) (0 :gist)
  ))

(READRULES '*reaction-to-travel-enjoy-input*
  '(1 (0 NEG like to travel 0)
      2 (Well\, some people do not really enjoy traveling \.) (100 :out)
    1 (0 NEG 3 travel alone 0) 
      2 (You\, personally\, prefer silence but you understand if I like to have people around to travel with\.) (100 :out)
    1 (0 enjoy travel solo 0) 
      2 (Solo travel is cool\. I don\’t need to consult anyone else and can go any place I want\.) (100 :out)
    1 (0 friend 0) 
      2 (Traveling with friends is sweet\.) (100 :out)
    1 (0 visiting friends 0) 
      2 (It is great to visiting friends \. Also they can help I to have a great time\.) (100 :out)
    1 (0 family 0) 
      2 (Traveling with 5 is sweet\.) (100 :out)
    1 (0 visiting family 0) 
      2 (It is great to visiting family \. Also they can help I to have a great time\.) (100 :out)
    1 (0 short 0) 
      2 (It relax yourself to have a trip for several days\.) (100 :out)
    1 (0 long 0) 
      2 (Staying in a place for a long term helps me to experience the local culture\.) (100 :out)
    1 (0 package 0) 
      2 (I don\'t need to arrange everything in my trip when I travel with others\.) (100 :out)
    1 (0 backpacking 0) 
      2 (It sounds like you love nature\, that\'s pretty cool\.) (100 :out)
    1 (0 event 0) 
      2 (Travelling for a specific target is meaningful\.) (100 :out)
    1 (0 sightseeing 0) 
      2 (Travelling for 5 is great\. what I need to do is relaxing yourself and enjoying a happy time\.) (100 :out)
    1 (0 road trip 0) 
      2 (Road trip means much more freedom\. I can decide the time and the desitination by myself \.) (100 :out)
    1 (0 NIL Gist 0)
      2 (That sounds like a fun way to travel\. You like seeing other cities with friends\.) (100 :out)
  ))
); end of eval-when
