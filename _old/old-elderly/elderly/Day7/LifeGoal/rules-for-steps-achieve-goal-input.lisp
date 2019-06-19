(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; MEETING WITH KIM NOTES (8/4/2017)

  ;; New question prompt: "What steps have you taken to achieve this goal?"

  ;; See doctor
  ;; Support group
  ;; Take medicine / meds
  ;; Keeping reminders / checking calendar
  ;; Started an excersize routine
  ;; Started diet / watched my eating
  ;; Joining a gym
  ;; Joining Silver Sneakers (YMCA program)
  ;; Try to be more diligent
  ;; Priorities / effort
  ;; Commitment
  ;; Decide to do it / Make up my mind to do it

  (alt-see see seeing visit visiting go going talk talking appointment appointments)
  (alt-doctor doctor doctors nurse nurses physician physicians)
  (alt-keeping keeping keep checking check looking look writing write watching watch taking take)
  (alt-reminder reminder reminders notes note calendar schedule record records)
  (alt-routine routine routines plan plans procedure procedures pattern patterns schedule schedules method methods system systems)
  (alt-watch watch watching monitor monitoring track tracking record recording check checking decrease decreasing)
  (alt-eating eat eating food calories sugar intake consumption)
  (alt-diligence diligence diligent priorities priority effort commitment committed commitments discipline disciplined)

  ))
   
;; NOTE: Proposed new gist clause: "(0 step that I have taken to achieve my goal 0)"
;; New tag: steps-achieve-goal

;; 	What steps have you taken to achive this goal?
;; (0 step that I have taken to achieve my goal 0)
;; steps-achieve-goal
;; (What steps have you taken to achieve your goal ?)
;; (3 What steps 4 achieve your goal 3) 
	
(READRULES '*specific-answer-from-steps-achieve-goal-input*
  '(
  1 (0 alt-see 2 alt-doctor 0)
    2 ((A step that I have taken to achieve my goal is seeing a doctor \.) (steps-achieve-goal)) (0 :gist)
  1 (0 support group 0)
    2 ((A step that I have taken to achieve my goal is going to a support group \.) (steps-achieve-goal)) (0 :gist)
  1 (0 alt-taking 2 alt-pills 0)
    2 ((A step that I have taken to achieve my goal is taking medicine \.) (steps-achieve-goal)) (0 :gist)
  1 (0 alt-keeping 2 alt-reminder 0)
    2 ((A step that I have taken to achieve my goal is keeping reminders \.) (steps-achieve-goal)) (0 :gist)
  1 (0 alt-exercise 2 alt-routine 0)
    2 ((A step that I have taken to achieve my goal is starting an exercise routine \.) (steps-achieve-goal)) (0 :gist)
  1 (0 exercise-types-two exercise-types-two 0)
    2 ((A step that I have taken to achieve my goal is getting more exercise by 2 3 \.) (steps-achieve-goal)) (0 :gist)
  1 (0 exercise-types 0)
    2 ((A step that I have taken to achieve my goal is getting more exercise by 2 \.) (steps-achieve-goal)) (0 :gist)
  1 (0 alt-diet 0)
    2 ((A step that I have taken to achieve my goal is going on a diet \.) (steps-achieve-goal)) (0 :gist)
  1 (0 alt-watch 2 alt-eating 0)
    2 ((A step that I have taken to achieve my goal is going on a diet \.) (steps-achieve-goal)) (0 :gist)
  1 (0 alt-weight 1 alt-change 0)
    2 ((A step that I have taken to achieve my goal is changing my weight \.) (steps-achieve-goal)) (0 :gist)
  1 (0 alt-change 2 alt-weight 0)
    2 ((A step that I have taken to achieve my goal is changing my weight \.) (steps-achieve-goal)) (0 :gist)
  1 (0 alt-diligence 0)
    2 ((A step that I have taken to achieve my goal is being more diligent \.) (steps-achieve-goal)) (0 :gist)
  1 (0 working harder 0)
    2 ((A step that I have taken to achieve my goal is being more diligent \.) (steps-achieve-goal)) (0 :gist)
  1 (0 make up 1 mind 0)
    2 ((A step that I have taken to achieve my goal is making up my mind \.) (steps-achieve-goal)) (0 :gist)
  1 (0 set my mind 0)
    2 ((A step that I have taken to achieve my goal is making up my mind \.) (steps-achieve-goal)) (0 :gist)
  1 (0 decide 2 do 0)
    2 ((A step that I have taken to achieve my goal is making up my mind \.) (steps-achieve-goal)) (0 :gist)
  1 (0)
     2 ((NIL Gist \: nothing found for step that I have taken to achieve my goal \.) (steps-achieve-goal)) (0 :gist)
))
       
 (READRULES '*thematic-answer-from-steps-achieve-goal-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-steps-achieve-goal-input*
  '(
  
  ))

  ;; NOTE: Proposed new question: "What steps have you taken to achieve your goal ?"
		
 (READRULES '*question-from-steps-achieve-goal-input*
  '(
  1 (0 what 2 you 0)
     2 (What steps have you taken to achieve your goal ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (What steps have you taken to achieve your goal ?) (0 :gist)
  ))

(READRULES '*reaction-to-steps-achieve-goal-input*
  '( 
  1 (0 seeing a doctor 0)
    2 (Seeing my doctor frequently is an important step\! They can help me with things I may not know about myself\.) (100 :out)
  1 (0 going to a support group 0)
    2 (Support groups are great\. They help me with my problems while at the same time making me feel welcome and connected\.) (100 :out)
  1 (0 taking medicine 0)
    2 (It\'s good to remember my medicine without missing a day\. Otherwise I might get bad symptoms\.) (100 :out)
  1 (0 keeping reminders 0)
    2 (Reminders are a good way to keep track of important things in life\. Personally\, you use a calendar app on your phone to keep track of important dates\!) (100 :out)
  1 (0  starting an exercise routine 0)
    2 (It\'s great that I found the motivation to get regular exercise\! You are sure it will start paying off soon\.) (100 :out)
  1 (0 getting more exercise by exercise-types-two exercise-types-two 0)
    2 (It\'s great that I found the motivation to get regular exercise\! You are sure it will start paying off soon\.) (100 :out)
  1 (0 getting more exercise by exercise-types 0)
    2 (It\'s great that I found the motivation to get regular exercise\! You are sure it will start paying off soon\.) (100 :out)
  1 (0 going on a diet 0)
    2 (It\'s great that I found the motivation to go on a diet\! You are sure it will start paying off soon\.) (100 :out)
  1 (0 changing my weight 0)
    2 (Working on keeping a healthy weight is an important step to being generally healthy\. Plus\, it makes me feel better about myself\!) (100 :out)
  1 (0 being more diligent 0)
    2 (Diligence and hard work are necessary when trying to change myself for the better\.) (100 :out)
  1 (0 making up my mind 0)
    2 (Sometimes putting my mind to something and deciding to just do it is the most important step in achieving my goal\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (Sometimes the most important parts of achieving my health goals are to have a solid plan\, to be dedicated\, and to just set my mind to it\.) (100 :out)
  ))
); end of eval-when
