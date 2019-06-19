(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '( (read reading)
    (meditate meditating meditation)
    (gratitude grateful)
    (shower)
    (reflect reflecting reflection)
    (stretch stretching)
    (family grandchildren grandchild children child daughter daughters son sons spouse wife husband siblings brother brothers sister sisters
      parents mother father grandparents grandmother grandfather)
    (chatting talking chat talk)
    (write diary diaries)
    (plan planning)
    (sleep bed)
  ))
   
;; What do you like to do to wind down before bed? 
;; gist:What do you do to wind down before bed? 
;; (0 I 4 to wind down before bed 0) 
;; wind-down-before-bed
;; (2 What 2 do 3 wind down before bed 2)
	

(READRULES '*specific-answer-from-wind-down-before-bed-input*
  '( 1 (0 read 0) 
        2 ((I like to 2 to wind down before bed \.)  (wind-down-before-bed)) (0 :gist) 
     1 (0 meditate 0) 
        2 ((I like to 2 to wind down before bed \.)  (wind-down-before-bed)) (0 :gist)
     1 (0 shower 0) 
        2 ((I like to 2 to wind down before bed \.)  (wind-down-before-bed)) (0 :gist)
     1 (0 reflect 0) 
        2 ((I like to 2 to wind down before bed \.)  (wind-down-before-bed)) (0 :gist) 
     1 (0 stretch 0) 
        2 ((I like to 2 to wind down before bed \.)  (wind-down-before-bed)) (0 :gist)
     1 (0 family 0) ;; e.g. I like to talk to family to wind down before bed (but don't have enough space for that)
        2 ((I like to 2 to wind down before bed \.)  (wind-down-before-bed)) (0 :gist)
     1 (0 chat 0) 
        2 ((I like to 2 to wind down before bed \.)  (wind-down-before-bed)) (0 :gist)
     1 (0 plan 0) 
        2 ((I like to 2 to wind down before bed \.)  (wind-down-before-bed)) (0 :gist)
     1 (0 write diary 0) 
        2 ((I like to 2 3 to wind down before bed \.)  (wind-down-before-bed)) (0 :gist)
     1 (0 gratitude 0) 
        2 ((I like to practice gratitude to wind down before bed \.)  (wind-down-before-bed)) (0 :gist)
     1 (0)
       2 ((NIL Gist \: nothing found for what I like to do to wind down before bed  \.) (wind-down-before-bed)) (0 :gist)
))
       
       
 (READRULES '*thematic-answer-from-wind-down-before-bed-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-wind-down-before-bed-input*
  '(
  ))
		
 (READRULES '*question-from-wind-down-before-bed-input*
  '( 1 (0 what 2 you 0)
        2 (What do you like to do to wind down before bed ?) (0 :gist)
      1 (0 how 2 you 2 sleep 0) ;; e.g. how can you go to bed
        2 (How can you sleep ?) (0 :gist)
      1 (0 wh_ 4 wind down 2 bed 0)
        2 (What do you like to do to wind down before bed ?) (0 :gist)
  ))

(READRULES '*reaction-to-wind-down-before-bed-input*
  '( 1 (0 read 0) 
        2 (Reading is a wonderful habit\. You personally love reading a light novel in bed \.) (100 :out)
     1 (0 meditate 0) 
        2 (Nice to hear that I practice mediation\. Meditating can really calm me down and improve my sleep quality\.) (100 :out)
     1 (0 shower 0) 
        2 (Showering can relax me quickly\, especially after a busy day\.) (100 :out)
     1 (0 reflect 0) 
        2 (Not many people reflect their day before sleep\. That is a helpful little habbit to have\.) (100 :out)
     1 (0 stretch 0) 
        2 (Stretching will definitely prepare my body for a good sleep\.) (100 :out)
     1 (0 family 0)
        2 (Spending time with family before bed warms my heart\. You might want to do that sometimes too\.) (100 :out)
     1 (0 chat 0) 
        2 (You remember talking to your best friend until late night\. Not your best activty to do to wind down\, but sounds a wonderful thing to do\.) (100 :out)
     1 (0 plan 0) 
        2 (It is great to plan beforehand so that I don\'t have to worry about it the next day\.) (100 :out)
     1 (0 write diary 0) 
        2 (It is nice to keep records of events that have happened to me \. ) (100 :out)
     1 (0 gratitude 0) 
        2 (Practicing gratitude sounds lovely\. We should always be grateful to people who have been good to us\. ) (100 :out)
	1 (0 NIL Gist 0)
	    2 (okay\.) (100 :out)
  ))
); end of eval-when
