(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
    (family grandchildren grandchild children child daughter daughters son sons spouse wife husband siblings brother brothers sister sisters
      niece nephew parents mother father grandparents grandmother grandfather)
    (siblings brother sister brothers sisters)
    (travel travels trip trips)
	  (first-per-poss-pron my our)
    (first-per-pron I we)
    (syn-home home house place apartment)
    (meal dinner lunch brunch breakfast)
  ))

;; (What do you usually do for holidays ?)
;;	(holidays-activities)
;;		from-holidays-activities-input
;;			(0 On holidays 0)
;;			gist-question:(3 what 2 you 3 holidays 0)

 (READRULES '*specific-answer-from-holidays-activities-input*
   '(
     1 (0 get together 0) 
        2 ((On holidays we get together \.)  (holidays-activities)) (0 :gist) 		
     1 (0 first-per-pron 2 gather 0) 
        2 ((On holidays we get together \.)  (holidays-activities)) (0 :gist) 		
     1 (0 first-per-poss-pron 4 siblings 0) 
        2 ((On holidays we get together with my siblings \.)  (holidays-activities)) (0 :gist) 		
     1 (0 first-per-poss-pron 4 family 0) 
        2 ((On holidays we get together with my 4 \.)  (holidays-activities)) (0 :gist) 
     1 (0 join 2 family 0) 
        2 ((On holidays we get together with my 4 \.)  (holidays-activities)) (0 :gist) 	
     1 (0 first-per-poss-pron syn-home 0) 
        2 ((On holidays we get together in my home \.)  (holidays-activities)) (0 :gist) 
     1 (0 have 2 family over 0) 
        2 ((On holidays we get together in my home \.)  (holidays-activities)) (0 :gist) 
     1 (0 invite 2 family over 0) 
        2 ((On holidays we get together in my home \.)  (holidays-activities)) (0 :gist) 
     1 (0 family 2 come over 0) 
        2 ((On holidays we get together in my home \.)  (holidays-activities)) (0 :gist) 

     1 (0 first-per-pron 3 invite 2 family 0) 
        2 ((On holidays I invite family members \.)  (holidays-activities)) (0 :gist) 		
     1 (0 first-per-pron 3 invite 2 friends 0) 
        2 ((On holidays I invite friends \.)  (holidays-activities)) (0 :gist) 

     1 (0 first-per-pron 3 meal 0)
        2 ((On holidays I have a meal \.)  (holidays-activities))  (0 :gist)

     1 (0 first-per-pron 2 travel 0) 
        2 ((On holidays I travel \.)  (holidays-activities)) (0 :gist) 						
      1 (0)
       2 ((NIL Gist \: nothing found for what I do on holidays \.) (holidays-activities)) (0 :gist)
))
       
       
 (READRULES '*thematic-answer-from-holidays-activities-input*
    '())

 (READRULES '*unbidden-answer-from-holidays-activities-input*
    '())
		
 (READRULES '*question-from-holidays-activities-input*
    '(1 (0 what 2 you 0)
        2 (what do you do for holidays ?) (0 :gist)
      1 (0 how 2 you 0)
        2 (what do you do for holidays ?) (0 :gist)
	  1 (0 what do 4 holidays 0)
        2 (what do you do for holidays ?) (0 :gist)
      1 (0 what do 4 thanksgiving 0)
        2 (what do you do for holidays ?) (0 :gist)
      ))

(READRULES '*reaction-to-holidays-activities-input*
   '(
    1 (0 on holidays 1 get together 3 0)
       2 (0 siblings 0)
         3 (That sounds fun\. It\'s always good to reuinite with family\.) (100 :out)
       2 (0 home 0)
         3 (That sounds fun\. It\'s nice to be able to have events at my own home and not have to go anywhere\.) (100 :out)
       2 (0 family 0)
         3 (0 grandchildren 0)
           4 (Oh\, That\'s so sweet to have my grandchildren around for holidays \.) (100 :out)
         3 (0)
           4 (It\'s always nice to get together with the family members\.)
       2 (0)
         3 (It\'s always nice to get together with the people I love\.) (100 :out)
    1 (0 on holidays 1 travel 0)
       2 (Travelling over the holidays sounds like a nice thing to look forward to\.) (100 :out)
    1 (0 on holidays 1 invite friends 0)
       2 (Having friends over is always fun\.) (100 :out)
    1 (0 on holidays 1 invite family 0)
       2 (Having family over is always fun\.) (100 :out)
    1 (0 on holidays 3 meal 0)
       2 (Having a tasty meal is always a good way to spend a holiday\!) (100 :out)
    1 (0 NIL Gist 0)
       2 (You think the holidays are a great time to do things outside of the usual routine\.) (100 :out)
  ))
); end of eval-when
