(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
  ;; See how-is-weather-input for weather categories

  (rain rains rainy raining drizzles drizzle drizzling sprinkle sprinkles sprinkling pours pour pouring wetness)
  (thunder thunderstorm lightning)
  (storm stormy stormy hurricanes typhoon typhoons sandstorm tornado)
  (snow snowy snowing snowstorm cold freezing blizzard hail hailing sleet ice icy)
  (sun sunny warm hot pleasant sunshine clear)
  (wind windy breeze breezy gusty)
  (foggy fog mist misty)
  (weather-other foggy humid cloudy drought dry)
  (weather-extreme thunder storm)
  (like love favorite)
  ))
  
;;	What is your favorite weather ?
;;	(0 my favorite weather is 0) (0 The weather I do not like is 0) 
;;	favorite-weather
;;		gist-question: (1 what 2 favorite weather 3)
  
	

(READRULES '*specific-answer-from-favorite-weather-input*
  '(
  1 (0 NEG 1 like 1 rain 0)
     2 ((The weather I do not like is 6 \.)  (favorite-weather)) (0 :gist)
  1 (0 NEG 1 like 1 thunder 0)
     2 ((The weather I do not like is 6 \.)  (favorite-weather)) (0 :gist)
  1 (0 NEG 1 1 like storm 0)
     2 ((The weather I do not like is 6 \.)  (favorite-weather)) (0 :gist)
  1 (0 NEG 1 like 1 snow 0)
     2 ((The weather I do not like is 6 \.)  (favorite-weather)) (0 :gist)
  1 (0 NEG 1 like 1 sun 0)
     2 ((The weather I do not like is 6 \.)  (favorite-weather)) (0 :gist)
  1 (0 NEG 1 like 1 wind 0)
     2 ((The weather I do not like is 6 \.)  (favorite-weather)) (0 :gist)
  1 (0 NEG 1 like 1 weather-other 0)
     2 ((The weather I do not like is 6 \.)  (favorite-weather)) (0 :gist)
  1 (0 NEG 1 like 1 weather-extreme 0)
     2 ((The weather I do not like is 6 \.)  (favorite-weather)) (0 :gist)
  1 (0 like 3 rain 0)
     2 ((My favorite weather is 4 \.)  (favorite-weather)) (0 :gist)
  1 (0 like 3 thunder 0)
     2 ((My favorite weather is 4 \.)  (favorite-weather)) (0 :gist)
  1 (0 like 3 storm 0)
     2 ((My favorite weather is 4 \.)  (favorite-weather)) (0 :gist) 
  1 (0 like 3 snow 0)
     2 ((My favorite weather is 4 \.)  (favorite-weather)) (0 :gist)
  1 (0 like 3 sun 0)
     2 ((My favorite weather is 4 \.)  (favorite-weather)) (0 :gist)
  1 (0 like 3 wind 0)
     2 ((My favorite weather is 4 \.)  (favorite-weather)) (0 :gist) 
  1 (0 like 3 weather-other 0)
     2 ((My favorite weather is 4 \.)  (favorite-weather)) (0 :gist)  
  1 (0 like 3 weather-extreme 0)
     2 ((My favorite weather is 4 \.)  (favorite-weather)) (0 :gist)
  1 (0)
       2 ((NIL Gist \: nothing found for what my favorite weather is \.) (favorite-weather)) (0 :gist)
))
       
       
 (READRULES '*thematic-answer-from-favorite-weather-input*
   '(

   ))
  
 (READRULES '*unbidden-answer-from-favorite-weather-input*
   '(
  
   ))
		
 (READRULES '*question-from-favorite-weather-input*
    '(
    1 (0 how 2 you 1 go out 0)
      ;;new question
      2 (How can you go out ?) (0 :gist)
    1 (0 what 2 you 0)
       2 (What is your favorite weather ?) (0 :gist)
    1 (0 how 2 you 0)
       2 (What is your favorite weather ?) (0 :gist)
    ))

(READRULES '*reaction-to-favorite-weather-input*
  '( 
  1 (0 favorite weather is 0)
    2 (0 sun 0)
      3 (You love sunshine\. It means we can do lots of activities outside\.) (100 :out)
    2 (0 raining 0)
      3 (Rain always means the atmosphere is moist\. It\'s good for skin\.) (100 :out)
    2 (0 weather-extreme 0)
      3 (0 thunder 0)
        4 (Actually\, you think 2 sounds terrible\. It is interesting to know that I like it\.) (100 :out)
      3 (0 storm 0)
        4 (Actually\, you think 2 sounds terrible\. It is interesting to know that I like it\.) (100 :out)
    2 (0 snow 0)
      3 (You think snow is great\. You like the beautiful scene that it creates\.) (100 :out)
    2 (0 wind 0)
      3 (That makes sense\. But strong wind is still annoying\.) (100 :out)
    2 (0 weather-other 0)
	  3 (0 foggy 0)
	     4 (You love fog\. You could spend hours walking in a foggy road\.) (100 :out)
      3 (That sounds reasonable that I like 2 \.) (100 :out)
  1 (0 NEG 1 like 0)
    2 (0 raining 0)
      3 (rain is sometimes annoying\. I cannot go out when it is raining\.) (100 :out)
    2 (0 weather-extreme 0)
      3 (0 thunder 0)
        4 (2 sounds terrible\. You think it is dangerous\.) (100 :out)
      3 (0 storm 0)
        4 (It\'s very dangerous when they meet 2 \. You think you cannot stay on ground if go out \. It\'s much safer to stay at home\.) (100 :out)
    2 (0 snow 0)
      3 (Snow always comes with cold\. You feel bad when you must stay at home to keep warm\.) (100 :out)
    2 (0 sun 0)
      3 (Sometimes it can be too warm\. You don\'t like being sweaty\.) (100 :out)
    2 (0 wind 0)
      3 (It makes sense that I don\'t like 2 \.) (100 :out)
    2 (0 weather-other 0)
	  3 (That sounds reasonable that I don\'t like 2 \.) (100 :out)
  1 (0 NIL Gist 0)
    2 (You personally like when it gets really foggy outside\.) (100 :out)
	))
); end of eval-when
