(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '( (walk walking)
    (social musical concert fireworks picnic social-a craft crafts car performance 
      performances show shows market markets sport game party)
    (social-a art artwork artworks)
    (run running bike biking)
    (flying kite kites)
    (sport sports badminton tennis volleyball frisbee golf golfing soccer football baseball)
    (nature-related hike hiking boat boating fishing bird birds watching birdwatching botanical garden zoo
      berry strawberry picking scavenger hunt)
    (garden gardening)
    (swimming swim)
    (friend friends)
    (spouse husband wife)
    (grandchild grandchildren granddaugher granddaughter grandson grandsons)
    (child children daughter daughters son sons girl girls boy boys)
  ))
   
;; What is a recent outdoor activity you have done?
;; (0 recent outdoor activity 0) (0 have not done any recent outdoor activty 0)
;; recent-outdoor-activity
;; (2 what 2 recent outdoor activity 4)
	

(READRULES '*specific-answer-from-recent-outdoor-activity-input*
  '(  
     1 (0 social social 0) 
       2 (0 social-a social 0) 
         3 ((My recent outdoor activty is going to an 2 3 \.)  (recent-outdoor-activity)) (0 :gist) 
       2 (0 social social 0) 
         3 ((My recent outdoor activty is going to a 2 3 \.)  (recent-outdoor-activity)) (0 :gist) 
     1 (0 flying kite 0) 
       2 ((My recent outdoor activty is 2 3 \.)  (recent-outdoor-activity)) (0 :gist) 
     1 (0 nature-related nature-related 0) 
       2 ((My recent outdoor activty is 2 3 \.)  (recent-outdoor-activity)) (0 :gist) 
     1 (0 nature-related 0) 
       2 ((My recent outdoor activty is 2 \.)  (recent-outdoor-activity)) (0 :gist) 
     1 (0 walking 0) 
       2 ((My recent outdoor activty is 2 \.)  (recent-outdoor-activity)) (0 :gist) 
     1 (0 running 0) 
       2 ((My recent outdoor activty is 2 \.)  (recent-outdoor-activity)) (0 :gist)
     1 (0 sport 0) 
       2 ((My recent outdoor activty is 2 \.)  (recent-outdoor-activity)) (0 :gist) 
     1 (0 swimming 0) 
       2 ((My recent outdoor activty is 2 \.)  (recent-outdoor-activity)) (0 :gist)
     1 (0 friend 0) 
       2 ((My recent outdoor activity is with my 2 \.)  (recent-outdoor-activity)) (0 :gist)
     1 (0 spouse 0) 
       2 ((My recent outdoor activity is with my 2 \.)  (recent-outdoor-activity)) (0 :gist)
     1 (0 grandchild 0) 
       2 ((My recent outdoor activity is with my 2 \.)  (recent-outdoor-activity)) (0 :gist)
     1 (0 child 0) 
       2 ((My recent outdoor activity is with my 2 \.)  (recent-outdoor-activity)) (0 :gist)
     1 (1 NEG 2 outdoor 0) 
       2 ((I have not done any recent outdoor activty \.)  (recent-outdoor-activity)) (0 :gist)
     1 (0)
       2 ((NIL Gist \: nothing found for recent outdoor activity  \.) (recent-outdoor-activity)) (0 :gist)

    ))
       
       
 (READRULES '*thematic-answer-from-recent-outdoor-activity-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-recent-outdoor-activity-input*
  '( 
  ))
		
 (READRULES '*question-from-recent-outdoor-activity-input*
  '( 1 (2 what 2 recent outdoor activity 4)
        2 (What is a recent outdoor activity you have done ?) (0 :gist)
     1 (0 what 2 outdoor activtiy 2 like 0) ; What is the outdoor activity you would like to do?
        2 (What is a recent outdoor activity you have done ?) (0 :gist)
     1 (0 what 2 you )
        2 (What is a recent outdoor activity you have done ?) (0 :gist)
     1 (0 how 2 you )
        2 (What is a recent outdoor activity you have done ?) (0 :gist)
     1 (0 how 2 you 3 outdoor 0 )
        2 (How can you go outside ?) (0 :gist)
  ))

(READRULES '*reaction-to-recent-outdoor-activity-input*
  '(
     1 (0 social social 0)
       2 (0 social-a social 0) 
         3 (You love art history and are more than willing to spend your afternoon appreciating artworks\.) (100 :out)
       2 (0 musical 0) 
         3 (Listening live music and recorded one are never the same experience\. The sounds and voice are so powerful\.) (100 :out)
       2 (0 sport game 0) 
         3 (You used to watch baseball game with my children\. That was really fun\.) (100 :out)
       2 (0 social social 0) 
         3 (Sounds nice that I have went to the 2 3 \.) (100 :out)
     1 (0 flying kite 0)
       2 (You rarely fly kites\, but that sounds like a good way to get some sunshine\.) (100 :out)
     1 (0 nature-related nature-related 0)
       2 (0 watching 0) ;; bird watching
         3 (Observing animals helps me to appreciate the beauty of mother nature\.) (100 :out)
       2 (0 garden 0) 
         3 (You are horrible at keeping plants\, but you enjoy wandering around a beautiful garden\.) (100 :out)
       2 (0 picking 0) 
         3 (You went for berry picking in summer\! It was wonderful\.) (100 :out)
       2 (0 nature-related nature-related 0)
         3 (It is good to be back to nature from time to time\.) (100 :out)
     1 (0 nature-related 0)
       2 (0 hiking 0) 
         3 (You have been hiking at the Adirondack Park last August\. Feels good to be back to nature sometimes\.) (100 :out)
       2 (0 fishing 0) 
         3 (You have never tried\, But fishing looks very interesting\.) (100 :out)
       2 (0 nature-related 0) 
         3 (It is good to be back to nature from time to time\.) (100 :out)
     1 (0 walking 0)
       2 (Yeah\, your parents also used to walk together after dinner\. We knew other senior people in their community through this\,
         because we would chat along our way\.) (100 :out)
     1 (0 running 0)
       2 (Running is hard exercise\. I must be in good shape\.) (100 :out)
     1 (0 swimming 0)
       2 (You still go swimming sometimes\. You love being in water\, despite having to be more careful than when you was young\. ) (100 :out)
     1 (0 sport 0)
       2 (You dropped 2 a year ago\. Maybe you should pick it back up\.) (100 :out)
     1 (0 friend 0)
       2 (You love going out with friends\! They keep you happy\.) (100 :out)
     1 (0 spouse 0)
       2 (Going outdoor with your 2 sounds lovely\. Wish I will have more good time together\.) (100 :out)
     1 (0 grandchildren 0)
       2 (You love to keep in touch with young lives and stay up-to-date\.) (100 :out)
     1 (0 child 0)
       2 (You love to keep in touch with my children and stay up-to-date\.) (100 :out)
     1 (1 NEG 2 outdoor 0)
       2 (Sometimes people just need to spend some time indoors\.) (100 :out)
     1 (0 NIL Gist 0)
       2 (It\'s healthy to spend some time outdoors every day\.) (100 :out)
  ))
); end of eval-when
