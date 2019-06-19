(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
  
  ;; Yes, they're relaxing
  ;; Yes, they make me feel less tired

  ;; No, they don't help

  (alt-groggy groggy tired bad disoriented worse)

  ))
   

;; 	Do you think that naps during the day are helpful? 
;;	(0 I think that naps 0)
;;	opinion-about-nap
;;	(Do you think that naps during the day are helpful ?) 
;;	(3 do you think 2 naps 5 helpful 3) 
	
(READRULES '*specific-answer-from-opinion-about-nap-input*
  '(
  1 (0 POS 4 RELAXING 0)
    2 ((I think that naps are relaxing \.) (opinion-about-nap)) (0 :gist)
  1 (0 POS 6 less 1 TIRED 0)
    2 ((I think that naps make me less tired \.) (opinion-about-nap)) (0 :gist)
  1 (0 NEG 4 feel 1 alt-groggy 0)
    2 ((I think that naps make me feel worse \.) (opinion-about-nap)) (0 :gist)
  1 (0 POS 0)
    2 ((I think that naps are helpful \.) (opinion-about-nap)) (0 :gist)
  1 (0 NEG 0)
    2 ((I think that naps are not helpful \.) (opinion-about-nap)) (0 :gist)
  1 (0)
    2 ((NIL Gist \: nothing found for if I think that naps are helpful \.) (opinion-about-nap)) (0 :gist)
))    
       
 (READRULES '*thematic-answer-from-opinion-about-nap-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-opinion-about-nap-input*
  '( 
  
  ))
		
 (READRULES '*question-from--input*
  '(
  1 (0 what 2 you 0)
     2 (Do you think that naps during the day are helpful ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (Do you think that naps during the day are helpful ?) (0 :gist)
  ))

(READRULES '*reaction-to-opinion-about-nap-input*
  '(
  1 (0 think that naps 2 relaxing 0)
    2 (Naps can be very relaxing\. They\'re a good way to calm down if I am feeling stressed\.) (100 :out)
  1 (0 think that naps 2 less tired 0)
    2 (Naps definitely help with exhaustion\, especially if I didn\'t get enough sleep the night before\.) (100 :out)
  1 (0 think that naps 2 feel worse 0)
    2 (It sounds weird that a nap would make someone feel worse\. You kind of get it though\, it disrupts my sleep schedule\.) (100 :out)
  1 (0 think that naps 2 NEG helpful 0)
    2 (I don\'t think naps are helpful? That\'s too bad\.) (100 :out)
  1 (0 think that naps 2 helpful 0)
    2 (You don\'t have to nap very often\, but it\'s very refreshing when you do\.) (100 :out)
  1 (0)
    2 (You don\'t have to nap very often\, but it\'s very refreshing when you do\.) (100 :out)
  ))
); end of eval-when
