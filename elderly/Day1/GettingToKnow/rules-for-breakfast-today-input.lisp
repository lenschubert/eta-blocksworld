(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
  (breakfast-healthy-one-word fruit vegetable vegetables tofu vitamins) 
  (fruit fruits yogurt clementine clementines apple apples banana bananas grape grapes berries blueberry blueberries strawberry strawberries) 
  (breakfast-light-one-word cereal bagel bagels oatmeal toast bread almond almonds
    nut nuts granola muffin muffins cheerios)
  (breakfast-heavy-one-word egg eggs omelette waffle waffles pancake pancakes
    sausage sausages bacon ham)
  (breakfast-drinks-one-word milk juice coffee tea)
  (breakfast-light-two-word bran apple cinnamon blueberry chocolate muffin muffins vitamin pills corn flakes)
  (breakfast-heavy-two-word scrambled egg eggs belgian waffle waffles)
  (breakfast-drinks-two-word fruit orange apple juice black coffee herbal green tea)
  (butter-1 peanut almond)  ))

;; (what did you have for breakfast ?)
;; (breakfast-today)
;; from-breakfast-today-input
;; (0 I had 4 for breakfast 0) 
;;     gist-question: (2 what 1 you have 2 breakfast 1)


 (READRULES '*specific-answer-from-breakfast-today-input*
  '(
  1 (0 breakfast-light-two-word breakfast-light-two-word 0)
     2 ((I had 2 3 for breakfast \.)  (breakfast-today)) (0 :gist)
  1 (0 breakfast-heavy-two-word breakfast-heavy-two-word 0)
     2 ((I had 2 3 for breakfast \.)  (breakfast-today)) (0 :gist)
  1 (0 breakfast-drinks-two-word breakfast-drinks-two-word 0)
     2 ((I had 2 3 for breakfast \.)  (breakfast-today)) (0 :gist)
  1 (0 breakfast-healthy-one-word 0)
     2 ((I had 2 for breakfast \.)  (breakfast-today)) (0 :gist)
  1 (0 breakfast-light-one-word 0)
     2 ((I had 2 for breakfast \.)  (breakfast-today)) (0 :gist)
  1 (0 breakfast-heavy-one-word 0)
     2 ((I had 2 for breakfast \.)  (breakfast-today)) (0 :gist)
  1 (0 breakfast-drinks-one-word 0)
     2 ((I had 2 for breakfast \.)  (breakfast-today)) (0 :gist)
  1 (0 skipped breakfast 0)
     2 ((I had nothing for breakfast \.)  (breakfast-today)) (0 :gist)
  1 (0 did not 3 breakfast 0)
     2 ((I had nothing for breakfast \.)  (breakfast-today)) (0 :gist)
  1 (0 butter-1 butter 0)
     2 ((I had 2 3 for breakfast \.) ()) (0 :gist)
  1 (1 nothing 0)
     2 ((I had nothing for breakfast \.)  (breakfast-today)) (0 :gist)
  1 (0 did not have  0)
     2 ((I had nothing for breakfast \.)  (breakfast-today)) (0 :gist)
   1 (0 did not eat 0)
     2 ((I had nothing for breakfast \.)  (breakfast-today)) (0 :gist)
    1 (0 had 1 nothing 0)
     2 ((I had nothing for breakfast \.)  (breakfast-today)) (0 :gist)
  1 (0)
     2 ((NIL Gist \: nothing found for what I had for breakfast \.)  (breakfast-today)) (0 :gist)
  
  ))
       
       
 (READRULES '*thematic-answer-from-breakfast-today-input*
    '())

 (READRULES '*unbidden-answer-from-breakfast-today-input*
    '())
		
 (READRULES '*question-from-breakfast-today-input*
    '(
    1 (0 what 2 you 0)
       2 (What did you have for breakfast ?) (0 :gist)
    1 (0 how 2 you 0)
       2 (What did you have for breakfast ?) (0 :gist)
    1 (0 do you 2 eat 0)
       2 (What did you have for breakfast ?) (0 :gist)
    1 (0 can you 2 eat 0)
       2 (What did you have for breakfast ?) (0 :gist)
    ))

(READRULES '*reaction-to-breakfast-today-input*
  '(
  1 (0 NIL Gist 0)
     2 (That sounds nice\.) (100 :out)
  1 (0 breakfast-light-two-word breakfast-light-two-word 0)
     2 (Sounds like a nice breakfast\. You like 2 3 as well \.) (100 :out)
  1 (0 breakfast-heavy-two-word breakfast-heavy-two-word 0)
     2 (You really like 2 3 \, however it is a very heavy breakfast so you can\'t have it often\.) (100 :out)
  1 (0 breakfast-drinks-two-word breakfast-drinks-two-word 0)
     2 (0 breakfast-drinks-two-word tea 0)
        3 (You really like 2 tea\, it\'s very refreshing\.) (100 :out)
     2 (0 breakfast-drinks-two-word breakfast-drinks-two-word 0)	
        3 (Personally\, you prefer tea to 2 3 \.) (100 :out)
  1 (0 breakfast-healthy-one-word 0)
    2 (0 fruit 0)
      3 (You try to have fruit for every breakfast\, it\'s very healthy for you \.) (100 :out)
    2 (You try to have 2 for every breakfast\, it\'s very healthy for you \.) (100 :out)
  1 (0 breakfast-light-one-word 0)
     2 (Sounds like a nice breakfast\. You like 2 as well \.) (100 :out)
  1 (0 breakfast-heavy-one-word 0)
     2 (You really like 2 \, however it is a very heavy breakfast so you can\'t have it often\.) (100 :out)
  1 (0 breakfast-drinks-one-word 0)
     2 (0 tea 0)
        3 (You really like tea\, it\'s very refreshing\.) (100 :out)
     2 (0 breakfast-drinks-one-word 0)
        3 (Personally\, I prefer tea to 2 \.) (100 :out)
  1 (0 butter-1 butter 0)
     2 (Sounds like a nice breakfast\. You like 2 3 as well\, though it is a little bit too fatty for you \.) (100 :out)	
  1 (0 NIL Gist 0)
     2 (I must be hungry\. I should try to eat at least something small for breakfast\.) (100 :out)
  ))
); end of eval-when
