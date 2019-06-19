(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
  (weather-types rain thunder storm snow sun wind weather-other weather-extreme)
  (rain rainy raining drizzling sprinkling pouring wetness)
  (thunder thunderstorm lightning)
  (storm stormy stormy hurricanes typhoon typhoons sandstorm tornado)
  (snow snowy snowing snowstorm cold freezing blizzard hail hailing sleet ice icy)
  (sun sunny warm hot pleasant sunshine clear)
  (wind windy breeze breezy gusty)
  (weather-other fog foggy humid cloudy drought dry mist)
  (weather-extreme thunder storm)
  (have take bring)
  ))

;;	How is the weather outside ?
;;	how-is-weather
;; (0 the weather outside is 0)
;;	gist question: (2 how 2 weather 3)

	
(READRULES '*specific-answer-from-how-is-weather-input*
  '(
  ; "If subject gives a descriptive answer" "If subject says only a few words" ?
  ; should I try to detect specific words, i.e. if it's raining out LISSA responds
  ; "good thing I brought an umbrella" ?
  1 (0 rain 0)
     2 ((The weather outside is 2 \.)  (how-is-weather)) (0 :gist)
  1 (0 weather-extreme 0)
     2 ((The weather outside is 2 \.)  (how-is-weather)) (0 :gist)
  1 (0 snow 0)
     2 ((The weather outside is 2 \.)  (how-is-weather)) (0 :gist)
  1 (0 sun 0)
     2 ((The weather outside is 2 \.)  (how-is-weather)) (0 :gist)
  1 (0 wind 0)
     2 ((The weather outside is 2 \.)  (how-is-weather)) (0 :gist)
  1 (0 weather-other 0)
     2 ((The weather outside is 2 \.)  (how-is-weather)) (0 :gist)
  1 (0 no 1 idea 0)
     2 ((I do not know what the weather outside is \.)  (how-is-weather)) (0 :gist)
  1 (0 not 1 really 0)
     2 ((I do not know what the weather outside is \.)  (how-is-weather)) (0 :gist)
  1 (0)
     2 ((NIL Gist \: nothing found for how the weather outside is \.) (how-is-weather)) (0 :gist)
))
       
       
 (READRULES '*thematic-answer-from-how-is-weather-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-how-is-weather-input*
  '(
  ;1 (0 weather-rain 2 favorite 0)
  ;   2 ((My favorite weather is rain \.)  (how-is-weather)) (0 :gist)
  ; "It's raining. That's my favorite type of weather" <-- favorite-weather

  ; "It's raining now, but it's supposed to be sunny later" <-- weather-forecast
  ))
		
 (READRULES '*question-from-how-is-weather-input*
    '(
    1 (0 how 2 you 1 have 1 umbrella)
      ;;new question
      2 (How can you have an umbrella ?) (0 :gist)
    1 (0 what 2 you 0)
       2 (How is the weather outside ?) (0 :gist)
    1 (0 how 2 you 0)
       2 (How is the weather outside ?) (0 :gist)
	  1 (0 ? 0)
       2 (How is the weather outside ?) (0 :gist)
    ))

(READRULES '*reaction-to-how-is-weather-input*
  '( 
  1 (0 weather outside is weather-types 0)
    2 (0 rain 0)
      3 (Oh\, here I should always have my umbrella with me \.) (100 :out)
    2 (0 weather-extreme 0)
      3 (Sounds terrible\. You hope this bad weather will be gone very soon\.) (100 :out)
    2 (0 snow 0)
      3 (So it must be very cold outside\. Just stay inside and try to stay warm\.) (100 :out)
    2 (0 sun 0)
      3 (Great\, that means we can spend more time enjoying the weather\. It\'s good to spend time outside on such a lovely day\.) (100 :out)
    2 (0 wind 0)
      3 (Sometimes wind is fine\, but you don\'t like strong wind because it scares you \.) (100 :out)
    2 (0 weather-other 0)
      3 (You think 2 is acceptable for you \. You don\'t need to worry the weather affecting my work\.) (100 :out)
  1 (0 NEG know 2 weather outside 0)
     2 (It\'s good to pay attention to the weather outside so I am not caught off guard\.) (100 :out)
  1 (0 NIL Gist 0)
     2 (It\'s good to pay attention to the weather outside so I am not caught off guard\.) (100 :out)
	))
); end of eval-when
