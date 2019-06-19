(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '( (autumn fall)
    (degree-serious too over strong very really)
    (warm mild)
    (cold chilly)
    (snow snowy)
    (wind winds windy)
    (rains rain raining rainy)
  ))
   
;; 	What is your favorite season to be outdoors?
;;	(0 favorite season 2 outdoors is 0)  (0 I do not like to be outdoors 0)
;;   favorite-season-outdoors
;;	(2 What 2 favorite season 2 outdoors 2)
	

(READRULES '*specific-answer-from-favorite-season-outdoors-input*
  '(
     1 (0 spring 0) 
        2 ((My favorite season to be outdoors is 2 \.)  (favorite-season-outdoors)) (0 :gist) 
     1 (0 summer 0) 
        2 ((My favorite season to be outdoors is 2 \.)  (favorite-season-outdoors)) (0 :gist) 
     1 (0 autumn 0) 
        2 ((My favorite season to be outdoors is fall \.)  (favorite-season-outdoors)) (0 :gist) 
     1 (0 winter 0) 
        2 ((My favorite season to be outdoors is 2 \.)  (favorite-season-outdoors)) (0 :gist) 
     1 (0 is warm 0) 
        2 ((My favorite season to be outdoors is 3 \.)  (favorite-season-outdoors)) (0 :gist) 
     1 (1 NEG 1 hot 0)  ;; is not very hot
        2 ((My favorite season to be outdoors 1 not 4 \.)  (favorite-season-outdoors)) (0 :gist) 
     1 (1 NEG 1 cold 0) 
        2 ((My favorite season to be outdoors 1 not 4 \.)  (favorite-season-outdoors)) (0 :gist) 
     1 (1 NEG 1 dry 0) 
        2 ((My favorite season to be outdoors 1 not 4 \.)  (favorite-season-outdoors)) (0 :gist) 
     1 (1 NEG 1 wet 0) 
        2 ((My favorite season to be outdoors 1 not 4 \.)  (favorite-season-outdoors)) (0 :gist) 
     1 (1 NEG 1 extreme 0) 
        2 ((My favorite season to be outdoors 1 not 4 \.)  (favorite-season-outdoors)) (0 :gist) 
     1 (1 NEG 2 wind 0) ;; don't have much winds/snow
        2 ((My favorite season to be outdoors 1 not 4 \.)  (favorite-season-outdoors)) (0 :gist) 
     1 (1 NEG 2 snow 0) 
        2 ((My favorite season to be outdoors 1 not 4 \.)  (favorite-season-outdoors)) (0 :gist) 
     1 (1 NEG 2 rain 0) 
        2 ((My favorite season to be outdoors 1 not 4 \.)  (favorite-season-outdoors)) (0 :gist)
     1 (1 NEG 5 spring 0) ;; I don't like to be outdoors in spring
        2 ((My favorite season to be outdoors is not 4 \.)  (favorite-season-outdoors)) (0 :gist) 
     1 (1 NEG 5 summer 0) 
        2 ((My favorite season to be outdoors is not 4 \.)  (favorite-season-outdoors)) (0 :gist) 
     1 (1 NEG 5 autumn 0) 
        2 ((My favorite season to be outdoors is not 4 \.)  (favorite-season-outdoors)) (0 :gist) 
     1 (1 NEG 5 winter 0) 
        2 ((My favorite season to be outdoors is not 4 \.)  (favorite-season-outdoors)) (0 :gist) 
     1 (1 NEG 1 like 2 outdoors 0) 
        2 ((I do not like to be outdoors \.)  (favorite-season-outdoors)) (0 :gist) 
    1 (0)
       2 ((NIL Gist \: nothing found for what my favorite season to be outdoors is \.) (favorite-season-outdoors)) (0 :gist)
))
       
       
 (READRULES '*thematic-answer-from-favorite-season-outdoors-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-favorite-season-outdoors-input*
  '(
  ))
		
 (READRULES '*question-from-favorite-season-outdoors-input*
  '(
    1 (0 what 2 you 0)
     2 (What is your favorite season to be outdoors ?) (0 :gist)
    1 (0 how 2 you 0)
     2 (What is your favorite season to be outdoors ?) (0 :gist)
    1 (2 What 2 favorite season 2 outdoors 2)
     2 (What is your favorite season to be outdoors ?) (0 :gist)
  ))

(READRULES '*reaction-to-favorite-season-outdoors-input*
  '(
     1 (0 spring 0)
       2 (Spring in Rochester is kind of chilly\, but you generally like the weather and would go outdoors\. ) (100 :out)
     1 (0 summer 0)
       2 (Rochester\'s summer can be hot in the end of August\, but it\'s generally nice\. ) (100 :out)
     1 (0 autumn 0)
       2 (Leaves turn red and yellow in fall\. They are gorgeous\. You enjoy the scene a lot when you are exercising\.) (100 :out)
     1 (0 winter 0)
       2 (The weather can get very snowy and cold in Rochester\, so in winter you don\'t go out as much as you do in summer or autumn\.) (100 :out)
     1 (0 NEG hot 0)
       2 (You like weather that isn\'t very hot because you don\'t want to be sweaty\. ) (100 :out)
     1 (0 warm 0)
       2 (Warm weather makes it so tempting to go outdoors\. ) (100 :out)
     1 (0 NEG cold 0)
       2 (Weathers that are not too cold are good for doing outdoor activities\. ) (100 :out)
     1 (0 NEG dry 0)
       2 (You need to drink a lot of water if you go outdoors in dry weather\. ) (100 :out)
     1 (0 NEG wet 0)
       2 (It will be difficult to go outdoors in wet weather\. ) (100 :out)
     1 (0 NEG extreme 0)
       2 (Going out in an extreme weather might trigger potential dangers\. ) (100 :out)
     1 (0 NEG winds 0)
       2 (Walking in windy weathers are nice\, but you don\'t want to do strenuous exercises when it is windy\. ) (100 :out)
     1 (0 NEG snow 0)
       2 (Rochester's snow can be very heavy sometimes\. You just want to stay indoors when that happens\.) (100 :out)
     1 (0 NEG rain 0)
       2 (Raining can make outdoor exercises very hard\. ) (100 :out)
     1 (0 NEG 1 like 2 outdoors 0)
       2 (Oh\, You love to spend time outdoors\, especially during Summer\!) (100 :out)
     1 (0 NIL Gist 0)
       2 (okay\.) (100 :out)
  ))
); end of eval-when
