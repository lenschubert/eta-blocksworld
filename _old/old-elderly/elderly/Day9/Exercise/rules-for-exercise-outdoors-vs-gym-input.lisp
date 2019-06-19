(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; MEETING WITH KIM NOTES (8/8/2017)

  ;; Weather outside / winter
  ;; JCC / YMCA
  ;; Swimming / water aerobics
  ;; Treadmill
  ;; Walking
  ;; Don't like exercising in winter / afraid of falling

  (alt-falling falling trip tripping slip slipping)
  (alt-weather-hot hot heat humid sunny sun warm warmth muggy)
  (alt-weather-cold cold chilly freezing cool icy ice snowy snow frigid)
  (alt-outdoors outdoors outdoor outside nature)
  (alt-gym gym indoor indoors)
  (alt-like like enjoy typically usually prefer)
  (alt-swimming swimming swim pool)
  (alt-walking walking walk walks hiking hike hikes)
  (alt-running running run runs)
  (alt-walk-run alt-walking alt-running)

  ))
   

;;	Do you like to exercise outdoors or in a gym? 
;;	(0 I like to exercise outdoors 0) ;; one can extend the gist clause by adding some reason and make the appropriate reaction
;;	(0 I like to exercise in gym 0)
;;	exercise-outdoors-vs-gym
;;	(Do you like to exercise outdoors or in a gym ?)
;;	(3 Do you 2 exercise outdoors or 2 gym 3)


	

(READRULES '*specific-answer-from-exercise-outdoors-vs-gym-input*
  '(
  1 (0 alt-gym 5 alt-falling 0)
    2 ((I like to exercise in the gym because I am afraid of slipping outside \.) (exercise-outdoors-vs-gym)) (0 :gist)
  1 (0 alt-gym 5 alt-weather-cold 0)
    2 ((I like to exercise in the gym because it is cold outside \.) (exercise-outdoors-vs-gym)) (0 :gist)
  1 (0 alt-gym 5 alt-weather-hot 0)
    2 ((I like to exercise in the gym because it is hot outside \.) (exercise-outdoors-vs-gym)) (0 :gist)
  1 (0 alt-outdoors 5 alt-weather-cold 0)
    2 ((I like to exercise outdoors because it is cool outside \.) (exercise-outdoors-vs-gym)) (0 :gist)
  1 (0 alt-outdoors 5 alt-weather-hot 0)
    2 ((I like to exercise outdoors because it is warm outside \.) (exercise-outdoors-vs-gym)) (0 :gist)
  1 (0 alt-swimming 0)
    2 ((I like to exercise in the gym because I use the swimming pool \.) (exercise-outdoors-vs-gym)) (0 :gist)
  1 (0 water aerobics 0)
    2 ((I like to exercise in the gym because I use the swimming pool \.) (exercise-outdoors-vs-gym)) (0 :gist)
  1 (0 treadmill 0)
    2 ((I like to exercise in the gym because I use the treadmill \.) (exercise-outdoors-vs-gym)) (0 :gist)
  1 (0 alt-walk-run 2 alt-outdoors 0)
    2 ((I like to exercise outdoors because I go for outdoor walks \.) (exercise-outdoors-vs-gym)) (0 :gist)
  1 (0 alt-outdoors 4 alt-walk-run 0)
    2 ((I like to exercise outdoors because I go for outdoor walks \.) (exercise-outdoors-vs-gym)) (0 :gist)
  1 (0 alt-walk-run 2 alt-gym 0)
    2 ((I like to exercise in the gym because I go for indoor walks \.) (exercise-outdoors-vs-gym)) (0 :gist)
  1 (0 alt-gym 4 alt-walk-run 0)
    2 ((I like to exercise in the gym because I go for indoor walks \.) (exercise-outdoors-vs-gym)) (0 :gist)
  1 (0 alt-like 4 alt-gym 0)
    2 ((I like to exercise in the gym \.) (exercise-outdoors-vs-gym)) (0 :gist)
  1 (0 alt-like 4 alt-outdoors 0)
    2 ((I like to exercise outdoors \.) (exercise-outdoors-vs-gym)) (0 :gist)
  1 (0)
    2 ((NIL Gist \: nothing found for if I like to exercise outdoors \.) (exercise-outdoors-vs-gym)) (0 :gist)
))
            
 (READRULES '*thematic-answer-from-exercise-outdoors-vs-gym-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-exercise-outdoors-vs-gym-input*
  '(
  
  ))
		
 (READRULES '*question-from-exercise-outdoors-vs-gym-input*
  '(
  1 (0 what 2 you 0)
     2 (Do you like to exercise outdoors or in a gym ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (Do you like to exercise outdoors or in a gym ?) (0 :gist)
  ))

(READRULES '*reaction-to-exercise-outdoors-vs-gym-input*
  '(
  1 (0 like to exercise 2 gym 3 afraid of slipping outside 0)
    2 (It seems much safer to exercise inside\. Less likely to slip and fall\.) (100 :out)
  1 (0 like to exercise 2 gym 3 cold outside 0)
    2 (You personally hate exercising when it\'s cold outside\, it makes you get a bad cough\.) (100 :out)
  1 (0 like to exercise 2 gym 3 hot outside 0)
    2 (Exercising when it\'s too hot and humid out can make me feel like I am suffocating\.) (100 :out)
  1 (0 like to exercise 2 outdoors 3 cool outside 0)
    2 (You don\'t like exercising when it\'s cold out\, but it is nice to not worry about being overheated\.) (100 :out)
  1 (0 like to exercise 2 outdoors 3 warm outside 0)
    2 (Exercising when it\'s warm and sunny outside can be very pleasant\.) (100 :out)
  1 (0 like to exercise 2 gym 4 swimming pool 0)
    2 (Swimming indoors is convenient\, though going in an outdoor pool is nice once in a while\.) (100 :out)
  1 (0 like to exercise 2 gym 4 treadmill 0)
    2 (Using the treadmill is a good way to exercise my legs no matter the weather outside\.) (100 :out)
  1 (0 like to exercise 2 outdoors 4 outdoor walks 0)
    2 (You love going for walks outside\, it\'s very pleasant\.) (100 :out)
  1 (0 like to exercise 2 gym 4 indoor walks 0)
    2 (Going for a walk indoors\, like on an indoor track\, is very convenient if there\'s bad weather outside\.) (100 :out)
  1 (0 like to exercise 2 gym 0)
    2 (Going to the gym is very convenient\, it\'s nice to have everything I need to exercise available in one place\.) (100 :out)
  1 (0 like to exercise 2 outdoors 0)
    2 (Going outside to exercise is nice\, it feels very refreshing to exercise and enjoy nature at the same time\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (You like to exercise outside whenever you can\, though the weather is often bad in Rochester so you end up exercising in the gym most of the time\.) (100 :out)
  ))
); end of eval-when
