(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; MEETING WITH KIM NOTES (8/8/2017)

  ;; I don't know
    ;; Response: "Tell me about something that helps you get to sleep"

  ;; Nothing helps them
    ;; Response: "Is there something new you were thinking of trying?"

  ;; Reading a book
  ;; Medicine (melatonin)
  ;; Night cap
  ;; Drink
  ;; Not being on the computer
  ;; Tea
  ;; Meditation

  (alt-medicine medicine medication medicine pill pills melatonin)
  (alt-mask mask cover screen)
  (alt-face face eye)
  (alt-computer computer phone)
  (alt-meditate meditate meditation reflection reflecting prayer praying breathing)
  (alt-alcohol wine champagne cocktail)

  ))
   

;;	Tell me about something you do to improve your sleep. 
;;	(0 I improve my sleep 0)
;;	improve-sleep
;;	(What do you do to improve your sleep ?)
;;	(3 What 4 improve your sleep 3)


(READRULES '*specific-answer-from-improve-sleep-input*
  '(
  1 (0 read 0)
    2 ((I improve my sleep by reading a book \.) (improve-sleep)) (0 :gist)
  1 (0 book 0)
    2 ((I improve my sleep by reading a book \.) (improve-sleep)) (0 :gist)
  1 (0 alt-medicine 0)
    2 ((I improve my sleep by using medicine \.) (improve-sleep)) (0 :gist)
  1 (0 night cap 0)
    2 ((I improve my sleep by using a night cap \.) (improve-sleep)) (0 :gist)
  1 (0 alt-face alt-mask 0)
    2 ((I improve my sleep by using an eye mask \.) (improve-sleep)) (0 :gist)
  1 (0 NEG 3 alt-computer 0)
    2 ((I improve my sleep by not using the computer \.) (improve-sleep)) (0 :gist)
  1 (0 tea 0)
    2 ((I improve my sleep by drinking tea \.) (improve-sleep)) (0 :gist)
  1 (0 alt-meditate 0)
    2 ((I improve my sleep by meditating \.) (improve-sleep)) (0 :gist)
  1 (0 alt-alcohol 0)
    2 ((I improve my sleep by having a drink \.) (improve-sleep)) (0 :gist)
  1 (0 a drink 0)
    2 ((I improve my sleep by having a drink \.) (improve-sleep)) (0 :gist)
  1 (0)
       2 ((NIL Gist \: nothing found for how I improve my sleep \.) (improve-sleep)) (0 :gist)
))    
       
 (READRULES '*thematic-answer-from-improve-sleep-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-improve-sleep-input*
  '( 
  
  ))
		
 (READRULES '*question-from-improve-sleep-input*
  '(
  1 (0 what 2 you 0)
     2 (What do you do to improve your sleep ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (What do you do to improve your sleep ?) (0 :gist)
  ))

(READRULES '*reaction-to-improve-sleep-input*
  '(
  1 (0 improve my sleep 2 reading 1 book 0)
    2 (Reading a book before going to bed sounds like a great idea\. I get to learn new things and relax at the same time\.) (100 :out)
  1 (0 improve my sleep 2 using medicine 0)
    2 (Medicine is a good idea if I have bad problems with insomnia\.) (100 :out)
  1 (0 improve my sleep 2 using 1 night cap 0)
    2 (You have never used a night cap\, you have only seen it in pictures\. It seems very comfortable though\.) (100 :out)
  1 (0 improve my sleep 2 using 1 eye mask 0)
    2 (An eye mask can be very helpful if I am sensitive to light\.) (100 :out)
  1 (0 improve my sleep 2 NEG using 1 computer 0)
    2 (It\'s actually scientifically proven that the light from a computer hurts your ability to sleep\. Not using it before bedtime is a good idea\.) (100 :out)
  1 (0 improve my sleep 2 drinking tea 0)
    2 (Drinking tea is very soothing\, you love how it warms you up inside\.) (100 :out)
  1 (0 improve my sleep 2 meditating 0)
    2 (You think it\'s important to meditate and reflect on my day regardless of whether it helps me sleep or not\.) (100 :out)
  1 (0 improve my sleep 2 having 1 drink 0)
    2 (That\'s an interesting way to relax before bedtime\. Good for me if it works though\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (Part of falling asleep well is just gradually putting myself into a relaxed state of mind\.) (100 :out)
  ))
); end of eval-when
