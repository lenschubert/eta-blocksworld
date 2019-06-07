(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '((Num a one two three four five six seven eight nine ten eleven couple)
    (many twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
    (lots twenty thirty forty fifty sixty seventy eighty ninety hundred)
	(month-name January February March April May June July August September October November December)))
;; (How long have you lived there ?)
;;	(how-long-lived-there)
;;		from-how-long-lived-there-input
;;			(0 I lived there for 0)
;;			gist-question:(3 how long 1 you lived 0)

 (READRULES '*specific-answer-from-how-long-lived-there-input*
   '(1 (0 since 1 month-name 0)
        2 ((I lived there for a few months \.) (how-long-lived-there)) (0 :gist)
     
   1 (0 years 0)
        2 (0 lots 1 years 0)
          3 ((I lived there for more than 2 years \.)  (how-long-lived-there)) (0 :gist) 
        2 (0 many years 0)
          3 ((I lived there for 2 years \.)  (how-long-lived-there)) (0 :gist) 				  
        2 (0 Num years 0)
          3 ((I lived there for 2 years \.)  (how-long-lived-there)) (0 :gist) 				   
        2 ((I lived there for some years \.)  (how-long-lived-there)) (0 :gist) 
	 1 (0 Num months 0)
        2 ((I lived there for some months \.) (how-long-lived-there)) (0 :gist)
     1 (0 whole life 0)
        2 ((I lived there my whole life \.) (how-long-lived-there)) (0 :gist)
     1 (0 NEG 2 long 0)
        2 ((I lived there for not a long time \.) (how-long-lived-there)) (0 :gist)
     1 (0 long 0)
        2 ((I lived there for long time \.) (how-long-lived-there)) (0 :gist)
	 1 (0)
       2 ((NIL Gist \: nothing found for how long I lived there for \.) (how-long-lived-there)) (0 :gist)
))
       
       
 (READRULES '*thematic-answer-from-how-long-lived-there-input*
    '())

 (READRULES '*unbidden-answer-from-how-long-lived-there-input*
    '())
		
 (READRULES '*question-from-how-long-lived-there-input*
    '())

(READRULES '*reaction-to-how-long-lived-there-input*
   '(1 (0 whole life 0)
       2 (Wow\, that\'s amazing! It must really be my home\.) (100 :out)
     1 (0 few months 0)
       2 (Oh\, okay\. So I am new in this place \.) (100 :out)
     1 (0 many 0)
       2 (That\'s a long time\. You haven\'t lived anywhere that long\.) (100 :out)
     1 (0 lots 0)
       2 (Wow! I must really feel at home there\, having lived there for so long\.) (100 :out)
     1 (0 some years 0)
       2 (Oh\, okay\. So I should have been feeling like home after some years \.) (100 :out)
     1 (0 some months 0)
       2 (Oh\, okay\. So I still need time to feel like home there \.) (100 :out)
     1 (0 long time 0)
       2 (0 not long 0)
         3 (Oh\, okay\, you never have been in a place for a long time\. You have moved a lot during your life\.) (100 :out) 
       2 (Wow! I must really feel at home there\, having lived there for so long\.) (100 :out)
	1 (0 NIL Gist 0)
     2 (Okay\.) (100 :out)
	))
); end of eval-when
