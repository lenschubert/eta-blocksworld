(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
  (forecast-types weather-types beautiful)
  
  (family husband wife daughter son boy girl child children parent parents)

  (forecast-source news web)
  (news paper radio family TV)
  (web online phone app)

  (watch vision search)
  (listen hearing)
  (walk)
  (way watch listen walk) ;; different ways to get the forcast
  (bad worse terrible frustrating frustrate)
  (nice beautiful great pleasant)
  ))
   
;;	How is the weather forecast for this evening ?
;;	(0 the weather forecast for this evening is 0)
;;	weather-forecast
;;		gist question: (1 how 3 weather forecast 4)   
		
	

(READRULES '*specific-answer-from-weather-forecast-input*
  '(
  1 (0 nice 0)
     2 ((The weather forecast for this evening is nice \.)  (weather-forecast)) (0 :gist)
  1 (0 rain 0)
     2 ((The weather forecast for this evening is 2 \.)  (weather-forecast)) (0 :gist)
  1 (0 weather-extreme 0)
     2 ((The weather forecast for this evening is 2 \.)  (weather-forecast)) (0 :gist)
  1 (0 snow 0)
     2 ((The weather forecast for this evening is 2 \.)  (weather-forecast)) (0 :gist)
  1 (0 sun 0)
     2 ((The weather forecast for this evening is 2 \.)  (weather-forecast)) (0 :gist)
  1 (0 wind 0)
     2 ((The weather forecast for this evening is 2 \.)  (weather-forecast)) (0 :gist)
  1 (0 NEG 1 know 0)
    2 ((I do not know what the weather forecast for this evening is \.) (weather-forecast)) (0 :gist)
  1 (0 NEG 1 way 0)
    2 ((I do not know what the weather forecast for this evening is \.) (weather-forecast)) (0 :gist)
  1 (0)
       2 ((NIL Gist \: nothing found for what the weather forecast for this evening is \.) (weather-forecast)) (0 :gist)
))
       
       
 (READRULES '*thematic-answer-from-weather-forecast-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-weather-forecast-input*
  '(

  ))
		
 (READRULES '*question-from-weather-forecast-input*
    '(
    1 (0 what 2 you 0)
       2 (How is the weather forecast for this evening ?) (0 :gist)
    1 (0 how 2 you 0)
       2 (How is the weather forecast for this evening ?) (0 :gist)
    1 (0 you tell me 0)
       2 (How is the weather forecast for this evening ?) (0 :gist)
    ))

(READRULES '*reaction-to-weather-forecast-input*
  '( 
  1 (0 weather forecast 3 is forecast-types 0)
    2 (0 nice 0)
      3 (That\'s great\. Going out for walk is a good choice for tonight\.) (100 :out)
    2 (0 rain 0)
      3 (Sounds like it will be wet tonight\. Hopefully I have an umbrella\!) (100 :out)
    2 (0 weather-extreme 0)
      3 (That\'s scary\. Make sure to stay indoors\!) (100 :out)
    2 (0 snow 0)
      3 (It must be very cold outside\. You hope tomorrow will be warmer\.) (100 :out)
    2 (0 sun 0)
      3 (That\'s great\. That means you can open the window and enjoy the fresh air at night\.) (100 :out)
    2 (0 wind 0)
      3 (A light breeze is comfortable\, but you don\'t like strong wind\. That\'s terrible\.) (100 :out)
  1 (0 do not know 0)
    2 (You personally try to make it a habit to check the forecast\. You recommend I do too\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (Hopefully the weather this evening will turn out nice\.) (100 :out)
	))
); end of eval-when
