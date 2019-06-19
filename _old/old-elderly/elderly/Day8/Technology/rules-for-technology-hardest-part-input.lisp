(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; MEETING WITH KIM NOTES (8/4/2017)

  ;; Keeping up with it
  ;; How quickly it changes
  ;; Don't know how to use it / hard to use
  ;; Don't know what it's for
  ;; Grandkids have to teach them
  ;; People not going outside as much / texting too much
  
  ;; It's exciting (Unbidden answer - best part)
  (catch keep)
  (develop development developed change improve blossom evolve)
  (fast quickly quick)
  (difficult difficulty hard trouble)
  (depend teach help)
  (learn learned)
  (get getting gotten got)

  ))
   
;;  What is the hardest part about advances in technology these days? 
;;	(0 the hardest part of advances in technology is 0)
;;	technology-hardest-part
;;	(What is the hardest part about advances in technology ?)
;;	(3 What 3 hardest part of advances in technology 3)

	

(READRULES '*specific-answer-from-technology-hardest-part-input*
  '(
  1 (0 catch up with 0)
    2 ((The hardest part of advances in technology is to catch up with new things \.) (technology-hardest-part)) (0 :gist)
  1 (0 develop 1 fast 0)
    2 ((The hardest part of advances in technology is that it developed so fast \.) (technology-hardest-part)) (0 :gist)  
  1 (0 difficult 0)
    2 ((The hardest part of advances in technology is that it is hard to learn \.) (technology-hardest-part)) (0 :gist)
  1 (0 depend 0)
    2 ((The hardest part of advances in technology is that I need help to learn it \.) (technology-hardest-part)) (0 :gist)
  1 (0 learn 0)
    2 ((The hardest part of advances in technology is that it is hard to learn \.) (technology-hardest-part)) (0 :gist)
  1 (0 get used 0)
    2 ((The hardest part of advances in technology is to get used to it \.) (technology-hardest-part)) (0 :gist)
  1 (0)
    2 ((NIL Gist \: nothing found for what the hardest part of advances in technology is \.) (technology-hardest-part)) (0 :gist)
 
))
          
 (READRULES '*thematic-answer-from-technology-hardest-part-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-technology-hardest-part-input*
  '( 
  
  ))
		
 (READRULES '*question-from-technology-hardest-part-input*
  '(
  1 (0 what 4 hardest part 0)
      2 (What is the hardest part about advances in technology these days ?) (0 :gist)
  1 (0 wh_ 2 hardest part 0)
      2 (What is the hardest part about advances in technology these days ?) (0 :gist)
  ))

(READRULES '*reaction-to-technology-hardest-part-input*
  '(
  1 (0 catch up with 0)
    2 (Technology definitely evolves very fast\. It\'s even hard for you to keep up sometimes\! But the effort in learning new technology does pay off\.) (100 :out)
  1 (0 developed 2 fast 0)
    2 (Technology definitely evolves very fast\. It\'s even hard for you to keep up sometimes\! But the effort in learning new technology does pay off\.) (100 :out)
  1 (0 hard to learn 0)
    2 (Many types of technology can be very difficult to learn\. You like to look for easy tutorials or ask a friend when this happens\.) (100 :out)
  1 (0 need help to learn 0)
    2 (Asking for help from a friend or family is normal\! It helps save time and effort when learning to use new technology\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (You think technology evolves too fast sometimes\. It\'s understandable that many people have trouble with it\.) (100 :out)
  ))
); end of eval-when
