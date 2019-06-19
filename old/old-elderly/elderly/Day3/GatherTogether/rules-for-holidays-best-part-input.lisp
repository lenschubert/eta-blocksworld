(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '((be being) 
    (talk talking conversation )
	(see seeing)
	(others family friends people everybody)
	(eating eat food delicious tasty yummy)
  ))
;; (What is the best part ?)
;;	(holidays-best-part)
;;		from-holidays-best-part-input
;;			(0 The holidays best part is 0)
;;			gist-question:(3 what 2 best part 0)

 (READRULES '*specific-answer-from-holidays-best-part-input*
   '(
     1 (0 be 3 others 0) 
        2 ((The holidays best part is being with 4 \.)  (holidays-best-part)) (0 :gist) 		
     1 (0 have 3 fun 0) 
        2 ((The holidays best part is having fun \.)  (holidays-best-part)) (0 :gist) 		
     1 (0 talk 0) 
        2 ((The holidays best part is talking with people \.)  (holidays-best-part)) (0 :gist) 		
     1 (0 see 3 others 0) 
        2 ((The holidays best part is seeing 4 \.)  (holidays-best-part)) (0 :gist) 		
     1 (0 eating 0) 
        2 ((The holidays best part is eating \.)  (holidays-best-part)) (0 :gist) 		
      1 (0)
       2 ((NIL Gist \: nothing found for the holidays best part is \.) (holidays-best-part)) (0 :gist)
))
       
       
 (READRULES '*thematic-answer-from-holidays-best-part-input*
    '())

 (READRULES '*unbidden-answer-from-holidays-best-part-input*
    '())
		
 (READRULES '*question-from-holidays-best-part-input*
    '())

(READRULES '*reaction-to-holidays-best-part-input*
   '(
     1 (0 being with others 0)
       2 (0 family 0)
         3 (It must be great to be with family \.) (100 :out)
       2 (0 friends 0)
         3 (It must be great to be with friends \.) (100 :out)
       2 (0)
         3 (It must be great to be with others \.) (100 :out)
     1 (0 seeing others 0)
       2 (0 family 0)
         3 (It must be great to see family \.) (100 :out)
       2 (0 friends 0)
         3 (It must be great to see friends \.) (100 :out)
       2 (0)
         3 (It must be great to see others \.) (100 :out)
     1 (0 having fun 0)
       2 (It\'s always good to have fun\. Staying positive helps\.) (100 :out)
     1 (0 talking 0)
       2 (Talking with people during the holidays is a great way to lift my spirits\.) (100 :out)
     1 (0 eating 0)
       2 (That\'s right\. Thanksgiving party is when you always get to eat a lot of delicious foods and desserts \.) (100 :out)
     1 (0 NIL Gist 0)
       2 (Holidays are always a happy time\, in your opinion\.) (100 :out)
	))
); end of eval-when
