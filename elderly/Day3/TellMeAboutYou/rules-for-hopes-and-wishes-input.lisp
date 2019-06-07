(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; MEETING WITH KIM NOTES (8/4/2017)

  ;; Don't want to end up in a nursing home / assisted living
  ;; Want to stay in their home as long as possible
  ;; Stay independent
  ;; Seeing granddaughter graduate from high school/college
  ;; Seeing granddaughter/kid getting married
  ;; See new places
  ;; Learn a new language
  ;; Peaceful death / control over death
      ;; Response: (Sounds like autonomy is important to you / Sounds like you have some clear ideas as to where you want your end of life to go / Have you thought about discussing your end of life thoughts more with your family/doctor/etc. ?)

  (wishes-health health healthy healthier weight active exercise productive engaged)
  (wishes-travel travel traveling move moving)
  (wishes-happy happy happiness joy relax relaxed relaxing successful content contented)

  (wishes-two-spendtime spend spending time being with)
  (wishes-two-money make making get getting money)
  (wishes-two-experience new experiences experience living live life)

  (wishes-object children child daughter son boy girl parents father husband wife
    mother friends family granddaughter grandson grandchild grandchildren)
  (move moving)
  (spend spending)
  (retire retires)
  ))

;;	What are your hopes and wishes ?
;; 	(hopes-and-wishes)
;; 	from-hopes-and-wishes-input 
;;	(0 my wish is 0)
;;	gist-question: (1 what 2 hopes and wishes 1)


(READRULES '*specific-answer-from-hopes-and-wishes-input*
  '(   
  1 (0 wishes-two-spendtime 2 wishes-two-spendtime 2 wishes-object 0)
     2 ((My wish is to spend time with my 6 \.) (hopes-and-wishes)) (0 :gist)
  1 (0  meet 2 wishes-object 0)
     2 ((My wish is to spend time with my 4 \.) (hopes-and-wishes)) (0 :gist)
  1 (0 wishes-two-money 1 wishes-two-money 0)
     2 ((My wish is to make more money \.) (hopes-and-wishes)) (0 :gist)
  1 (0 wishes-two-experience 1 wishes-two-experience 0)
     2 ((My wish is to get new experiences \.) (hopes-and-wishes)) (0 :gist)
  1 (0 wishes-travel 2 wishes-object 0)
     2 ((My wish is to travel with my 4 \.) (hopes-and-wishes)) (0 :gist)
  1 (0 wishes-travel 0)
     2 (0 move 0)
       3 ((My wish is to move to a new place \.) (hopes-and-wishes)) (0 :gist)
     2 ((My wish is to travel \.) (hopes-and-wishes)) (0 :gist)
  1 (0 wishes-health 0)
     2 ((My wish is to be healthy \.) (hopes-and-wishes)) (0 :gist)
  1 (0 wishes-happy 0)
     2 ((My wish is to be happy \.) (hopes-and-wishes)) (0 :gist)
  1 (0 learn 0)
     2 ((My wish is to learn something \.) (hopes-and-wishes)) (0 :gist)
  1 (0 I 2 retire 0)
     2 ((My wish is to retire and do stuff \.) (hopes-and-wishes)) (0 :gist)
  1 (0 my spouse 2 retire 0)
     2 ((My wish is that my husband retires and we do stuff \.) (hopes-and-wishes)) (0 :gist)
  1 (0 I 2 NEG 2 know 0)
     2 ((I do not know what my wish is \.) (hopes-and-wishes)) (0 :gist)
  1 (0 I 2 NEG 2 sure 0)
     2 ((I do not know what my wish is \.) (hopes-and-wishes)) (0 :gist)
   1 (0)
       2 ((NIL Gist \: nothing found for what my wish is \.) (hopes-and-wishes)) (0 :gist)
 ))
       
       
 (READRULES '*thematic-answer-from-hopes-and-wishes-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-hopes-and-wishes-input*
  '(

  ))
		
 (READRULES '*question-from-hopes-and-wishes-input*
  '(
  1 (0 what 2 you 0)
     2 (what are your hopes and wishes ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (what are your hopes and wishes ?) (0 :gist)
  1 (0 wh_ 3 your hopes 0)
     2 (what are your hopes and wishes ?) (0 :gist)
  1 (0 wh_ 3 your wishes 0)
     2 (what are your hopes and wishes ?) (0 :gist)
  ))

(READRULES '*reaction-to-hopes-and-wishes-input*
  '( 
  1 (0 spend time 2 wishes-object 0)
     2 (Hopefully\, I will be able to spend plenty of time in the future being with my 5 \!) (100 :out)
  1 (0 make more money 0)
     2 (If making more money will make me happier\, you hope I can do just that\!) (100 :out)
  1 (0 get more experiences 0)
     2 (Well\, it\'s never too late to experience new things\!) (100 :out)
  1 (0 travel 2 wishes-object 0)
     2 (Travelling with my 4 sounds fun\, you hope I can do that soon\.) (100 :out)
  1 (0 travel 0) 
     2 (Travelling is always nice\, you hope I can do that soon\.) (100 :out)
  1  (0 move 0)
     2 (Moving to a new place is always exciting \. You hope I can do that soon \.) (100 :gist)
  1 (0 be healthy 0)
     2 (You hope I can be healthy and get good exercise in the future\!) (100 :out)
  1 (0 be happy 0)
     2 (You hope I can be happy and content with my future\.) (100 :out)
  1 (0 learn 0)
     2 (It would be great to keep my brain active by learning new things\, especially in senior age \.) (100 :out)
  1 (0 retire 0)
     2 (Retirement is great\. I would get to do a lot of fun stuff that I have always wished to \.) (100 :out)
  
  1 (0 NIL Gist 0)
     2 (You hope my wishes come true\.) (100 :out)
	))
); end of eval-when
