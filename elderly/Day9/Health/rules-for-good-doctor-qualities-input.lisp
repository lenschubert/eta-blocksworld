(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(


  ))
   

;; 	What are the qualities of a good doctor? 
;; (0 a good doctor 0)
;; good-doctor-qualities
;; (What are the qualities of a good doctor ?) 
;; (3 what 2 qualities of a good doctor 3) 
	
(READRULES '*specific-answer-from-good-doctor-qualities-input*
  '(
  1 (0 concerns 2 seriously 0)
    2 ((A good doctor takes my concerns seriously \.) (good-doctor-qualities)) (0 :gist)
  1 (0 VERY 2 HELPFUL 0)
    2 ((A good doctor is very helpful \.) (good-doctor-qualities)) (0 :gist)
  1 (0 GOODPROP 0)
    2 ((A good doctor is 2 \.) (good-doctor-qualities)) (0 :gist)
  1 (0 GOODREL 0)
    2 ((A good doctor is one that 2 \.) (good-doctor-qualities)) (0 :gist)
  1 (0 QUICK 0)
    2 ((A good doctor is quick \.) (good-doctor-qualities)) (0 :gist)
  1 (0 LISTEN 0)
    2 ((A good doctor is a good listener \.) (good-doctor-qualities)) (0 :gist)
  1 (0)
    2 ((NIL Gist \: nothing found for what are the qualities of a good doctor \.) (good-doctor-qualities)) (0 :gist)
  ))    
       
 (READRULES '*thematic-answer-from-good-doctor-qualities-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-good-doctor-qualities-input*
  '( 
  
  ))
		
 (READRULES '*question-from-good-doctor-qualities-input*
  '(
  1 (0 what 2 you 0)
     2 (What are the qualities of a good doctor ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (What are the qualities of a good doctor ?) (0 :gist)
  1 (0 do 1 you 1 have 2 doctor 0)
     2 (Do you have a doctor ?) (0 :gist)
   ))

(READRULES '*reaction-to-good-doctor-qualities-input*
  '(
  1 (0 good doctor takes my concerns seriously 0)
    2 (It\'s always important to feel like I\'m being taken seriously when discussing my own health\.) (100 :out)
  1 (0 good doctor is very helpful 0)
    2 (It\'s super helpful to have a doctor who always knows just the right treatments\.) (100 :out)
  1 (0 good doctor is GOODPROP 0)
    2 (You would love to have a doctor that\'s 5 \, one day\.) (100 :out)
  1 (0 good doctor is one that GOODREL 0)
    2 (Respect and support are extremely important in the relationship with my doctor\.) (100 :out)
  1 (0 good doctor is quick 0)
    2 (It\'s convenient to not spend too long on annoying treatments\. A good doctor gets it over with quickly\.) (100 :out)
  1 (0 good doctor is a good listener 0)
    2 (Having a doctor who can listen to my concerns is important\, since it\'s the very first step in solving a problem\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (You would like to have a doctor with those good qualities\.) (100 :out)
  ))
); end of eval-when
