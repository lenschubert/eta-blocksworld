(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; MEETING WITH KIM NOTES (8/4/2017)

  ;; Grandson getting married
  ;; Spouse going into nursing home
  ;; Spouse might die
  ;; Might get remarried
  ;; Daughter/son getting divorced
  ;; One of their kids is having a child / will have a grandchild

  ;; They're going to change their diet / manage their blood sugar better
  ;; Get off some of their medicines; taking too many
  ;; Health getting worse / losing sight/hearing / alzheimers
  
  ;; Moving out of their home
  ;; Moving to retirement community / senior living / assisted living / long term care / nursing home
  ;; Move in with kids
  ;; Might retire
  ;; Might get part time job
  ;; Might start volunteering

    (move moving)
    (tour tourism travel trip visit)
    (body-parts listen ear vision eye shoulder arm finger knee leg foot feet ankle wrist teeth elbow)
    (worse bad)
    (better good)
    (retire freetime time spare)
    ))
   

;; 	What kind of changes or life transitions might happen for you in the next year? For example, changes with your family, your health, or your living situation?
;; 	gist: What changes might happen for you in the next few years ?
;;	(0 change 2 happen 3 next few years 0)
;;	life-changes-next-years
;;	(2 What changes 1 happen 1 you 2 next few years 2)
	
(READRULES '*specific-answer-from-life-changes-next-years-input*
  '(1 (0 NEG 2 change 0)
      2 ((No change will happen in the next few years \.) (life-changes-next-years)) (0 :gist)
    1 (0 stay same 0)
      2 ((No change will happen in the next few years \.) (life-changes-next-years)) (0 :gist)
    1 (0 move to 0)
      2 ((Change will happen in the next few years is moving to a new place \.) (life-changes-next-years)) (0 :gist)
    1 (0 tour 0)
      2 ((Change will happen in the next few years is having a trip \.) (life-changes-next-years)) (0 :gist)
    1 (0 body-parts 3 worse 0)
      2 ((Change will happen in the next few years is 2 getting worse \.) (life-changes-next-years)) (0 :gist)
    1 (0 body-parts 3 better 0)
      2 ((Change will happen in the next few years is 2 getting better \.) (life-changes-next-years)) (0 :gist)
    1 (0 retire 0)
      2 ((Change will happen in the next few years is have more time \.) (life-changes-next-years)) (0 :gist)
    1 (0)
       2 ((NIL Gist \: nothing found for the change that might happen in the next few years \.) (life-changes-next-years)) (0 :gist)
))
       
       
 (READRULES '*thematic-answer-from-life-changes-next-years-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-life-changes-next-years-input*
  '(
  ))
		
 (READRULES '*question-from-life-changes-next-years-input*
  '(
    1 (0 what 4 you 0)
        2 (What changes might happen for you in the next few years ?) (0 :gist)
    1 (0 wh_ 4 chore 1 enjoy 0)
        2 (What changes might happen for you in the next few years ?) (0 :gist)
  ))

(READRULES '*reaction-to-life-changes-next-years-input*
  '(
    1 (0 move 2 a new place 0)
      2 (Moving to a new place is like starting a new life\. A lot of things to explore and be busy with\!) (100 :out)
    1 (0 have a trip 0)
      2 (It is great to hear that I planning to have a trip\. Hope I have a nice time\.) (100 :out)
    1 (0 body-parts getting worse 0)
      2 (You are sorry to hear that my 2 condition bothers me \. You think I need to see a doctor\.) (100 :out)
    1 (0 body-parts getting better 0)
      2 (That is great to hear that my 2 condition is becoming better\.) (100 :out)
    1 (0 retire 0)
      2 (Then I will have time to do things I am interested in\.) (100 :out)
    1 (0 No change 0)
      2 (Okay\, sounds my life is stable\.) (100 :out)
    1 (0 NIL Gist 0)
      2 (Thank me for telling you \, you hope everything turns out well\.) (100 :out)
  ))
); end of eval-when
