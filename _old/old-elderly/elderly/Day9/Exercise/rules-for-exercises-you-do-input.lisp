(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; MEETING WITH KIM NOTES (8/8/2017)

  ;; None
    ;; Response: "What have you done in the past?"

  ;; Silver Sneakers (exercise program)
  ;; Exercise programs at senior living center
  ;; JCC / YMCA
  ;; Going for walks / runs
  ;; Treadmill
  ;; Swimming
  ;; Don't like exercising in winter / afraid of falling
  ;; Yoga / chair yoga
  ;; Weights

  (alt-facility JCC YMCA)
  (alt-weights weights weightlifting)
  (cold cool windy wind)
  (health-condition heart lung feet foot knee knees)
  (excercise excercises)
  ))
   
;;  What kinds of exercise do you do these days?
;;	(0 I do not do any exercise 0)
;;	(0 As exercise I 0) 
;;	exercises-you-do
;;	(What kinds of exercise do you do ?)
;;	(3 what 2 exercises 2 you do 3) 
	

(READRULES '*specific-answer-from-exercises-you-do-input*
  '(
   1 (0 NEG 2 exercise 4 winter 0)
    2 ((I do not do any exercise because it is winter \.) (exercises-you-do)) (0 :gist)
   1 (0 NEG 2 exercise 4 cold 0)
    2 ((I do not do any exercise because it is cold \.) (exercises-you-do)) (0 :gist)
   1 (0 NEG 2 exercise 4 time 0)
    2 ((I do not do any exercise because I do not have time \.) (exercises-you-do)) (0 :gist)
   1 (0 NEG 2 exercise 4 weak 0)
    2 ((I do not do any exercise because I am too weak to do that \.) (exercises-you-do)) (0 :gist)
   1 (0 NEG 2 exercise 4 NEG 3 gym 0)
    2 ((I do not do any exercise because there is no gym nearby \.) (exercises-you-do)) (0 :gist)
   1 (0 NEG 2 exercise 4 doctor 0)
    2 ((I do not do any exercise because my doctor said so \.) (exercises-you-do)) (0 :gist)
   1 (0 NEG 6 health-condition 0)
    2 ((I do not do any exercise because of my health condition \.) (exercises-you-do)) (0 :gist)
   1 (0 NEG 8 alt-falling 0)
    2 ((I do not do exercise because I am afraid of falling \.) (exercises-you-do)) (0 :gist)
   1 (0 NEG 2 exercise 0)
    2 ((I do not do any exercise \.) (exercises-you-do)) (0 :gist)
   
  1 (0 yoga 0)
    2 ((As exercise I do yoga \.) (exercises-you-do)) (0 :gist)
  1 (0 treadmill 0)
    2 ((As exercise I use the treadmill \.) (exercises-you-do)) (0 :gist)
  1 (0 alt-running 0)
    2 ((As exercise I go for a run \.) (exercises-you-do)) (0 :gist)
  1 (0 alt-walking 0)
    2 ((As exercise I go for a walk \.) (exercises-you-do)) (0 :gist)
  1 (0 alt-swimming 0)
    2 ((As exercise I go for a swim \.) (exercises-you-do)) (0 :gist)
  1 (0 water aerobics 0)
    2 ((As exercise I go for a swim \.) (exercises-you-do)) (0 :gist)
  1 (0 alt-weights 0)
    2 ((As exercise I use weight machines \.) (exercises-you-do)) (0 :gist)
  1 (0 living center 0)
    2 ((As exercise I go to an exercise program at a senior living center \.) (exercises-you-do)) (0 :gist)
  1 (0 program 0)
    2 ((As exercise I go to a recreation facility \.) (exercises-you-do)) (0 :gist)
  1 (0 silver sneakers 0)
    2 ((As exercise I go to Silver Sneakers \.) (exercises-you-do)) (0 :gist)
  1 (0)
    2 ((NIL Gist \: nothing found for what I do as exercise I \.) (exercises-you-do)) (0 :gist)
))
        
 (READRULES '*thematic-answer-from-exercises-you-do-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-exercises-you-do-input*
  '( 
  
  ))
		
 (READRULES '*question-from-exercises-you-do-input*
  '(
  1 (0 what 2 you 0)
     2 (What kinds of exercise do you do ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (What kinds of exercise do you do ?) (0 :gist)
  1 (0 do 2 you 2 do 0)
     2 (What kinds of exercise do you do ?) (0 :gist)
  ))



(READRULES '*reaction-to-exercises-you-do-input*
  '( 
  1 (0 NEG do any exercise 0)
   2 (0 winter 0)
    3 (It is more difficult to exercise in the winter\. It cuts out a lot of options\.) (100 :out)
   2 (0 afraid of falling 0)
    3 (Being afraid of falling is understandable\. Safety is important\! Maybe try exercise such as yoga though\.) (100 :out)
  
   2 (0 cold 0)
    3 (It is more difficult to exercise in the winter\. It cuts out a lot of options\.) (100 :out)
   2 (0 not have time 0)
    3 (You try to do at least some light exercises everyday\. We need it even more considering our age\.) (100 :out)
   2 (0 weak 0)
    3 (You also find it hard to be as active as you was before\.) (100 :out)
   2 (0 no gym nearby 0)
    3 (You know a lot of exercise activities that one can do indoors\. ) (100 :out)
   2 (0 doctor said so 0)
    3 (You understand\. I should be more careful about the kind of exercises I do if I have specific health issus\.) (100 :out)
   2 (0 health-condition 0)
    3 (You understand\. I should be more careful about the kind of exercises I do if I have specific health issus\.) (100 :out)
   2 (0)
    3 (It is important to spend some time in the day doing exercise\. We need it even more considering our age\.) (100 :out)
  
  1 (0 do yoga 0)
    2 (Yoga seems like a great way to get exercise in my own home\, if I want to\.) (100 :out)
  1 (0 use the treadmill 0)
    2 (It\'s nice to be able to set my own pace on the treadmill\.) (100 :out)
  1 (0 go for a run 0)
    2 (It\'s awesome that I still have the endurance to go running\!) (100 :out)
  1 (0 for a walk 0)
    2 (Going for a walk is great\. Being able to be outside in nice weather helps motivate you to go for walks\.) (100 :out)
  1 (0 go for a swim 0)
    2 (You hate getting wet\! But going for a swim does sound nice\, if I enjoy it\.) (100 :out)
  1 (0 use weight machines 0)
    2 (Still using weights at this point is pretty impressive\. I must be quite strong\.) (100 :out)
  1 (0 go to an exercise program 2 senior living center 0)
    2 (It\'s very nice of the living center to offer exercise programs\!) (100 :out)
  1 (0 go to a recreation facility 0)
    2 (You have been to such places a couple times before\. They offer a lot of great resources\.) (100 :out)
  1 (0 go to Silver Sneakers 0)
    2 (You have heard of that before but don\'t know much about it\. It sounds nice though\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (There\'s a lot of interesting ways people figure out to get exercise\. It\'s pretty important to staying healthy\!) (100 :out)
  ))
); end of eval-when
