(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; MEETING WITH KIM NOTES (8/4/2017)

  ;; Be more outgoing
  ;; Excersize more
  ;; Eat healthy
  ;; Spend more time with my grandchildren/spouse/kids
  ;; They isolate and want to get out of their house more
  ;; Negative outlook; being pessimistic
  ;; Lose weight
  ;; Manage money better

  ;; Might get confused and interpret as "what you would want to be different about your life"
  ;; hear better, better health, not need a wheelchare, have better hearing, not live in a nursing home, be able to drive, see better, etc.

  (syn-more more better higher good gain)
  (syn-less less lose)
  (syn-doing do be doing being)

  (quality-types-comparative funnier kinder smarter friendlier happier wiser stronger
  taller humbler bolder healthier)

  (change-from-isolated isolate isolated introverted introvert lonely alone)
  (change-from-procrastinator procrastinate procrastinating procrastination distracted)
  (change-from-unhealthy weight overweight underweight unhealthy fat heavy chubby skinny thin)
  (change-from-comm-skills conversation speaking communicating communication interacting interaction talking)
  (skill skills ability)
  (negative negatively pessimistic pessimist pessimism)
  
  ;; BADSTATE
  ;; BADHEALTH

  (change-to-independent independent independently alone myself)
  (change-to-two-learning learn learning improve improving experiences experience skill skills)
  (experience experiences)
  ))

;;	what are things you want to change about yourself ?
;;	(want-change-about-you)
;; 	from-want-change-about-you-input
;;	(0 thing 3 change about myself is 0) 	(0 nothing 3 change about myself 0) 
;;		gist-question: (1 what 2 things 3 change about yourself 1) 
   
(READRULES '*specific-answer-from-want-change-about-you-input*
  '(

  ;; Two word
  1 (0 syn-more 2 quality-two-types-archetypes quality-two-types-archetypes 0)
    2 ((The thing that I would change about myself is being a 4 5 \.) (want-change-about-you)) (0 :gist)
  1 (0 syn-more 2 quality-two-types-participle quality-two-types-participle 0)
    2 ((The thing that I would change about myself is 4 5 \.) (want-change-about-you)) (0 :gist)
  1 (0 quality-two-types-verb quality-two-types-verb 2 syn-more 0)
    2 ((The thing that I would change about myself is trying to 2 3 \.) (want-change-about-you)) (0 :gist)
  1 (0 syn-more 2 quality-two-types-noun quality-two-types-noun 0)
    2 ((The thing that I would change about myself is having 4 5 \.) (want-change-about-you)) (0 :gist)
  1 (0 syn-more 2 quality-two-types-adj quality-two-types-adj 0)
    2 ((The thing that I would change about myself is being 4 5 \.) (want-change-about-you)) (0 :gist)
  ;; One word
  1 (0 syn-more 2 quality-types-archetypes 0)
    2 ((The thing that I would change about myself is being a 4 \.) (want-change-about-you)) (0 :gist)
  1 (0 syn-more 2 quality-types-participle 0)
    2 ((The thing that I would change about myself is 4 \.) (want-change-about-you)) (0 :gist)
  1 (0 quality-types-verb 2 syn-more 0)
    2 ((The thing that I would change about myself is trying to 2 \.) (want-change-about-you)) (0 :gist)
  1 (0 syn-more 2 quality-types-noun 0)
    2 ((The thing that I would change about myself is having 4 \.) (want-change-about-you)) (0 :gist)
  1 (0 syn-more 2 quality-types-adj 0)
    2 ((The thing that I would change about myself is being 4 \.) (want-change-about-you)) (0 :gist)
  1 (0 quality-types-comparative 0)
    2 ((The thing that I would change about myself is being 2 \.) (want-change-about-you)) (0 :gist)
  ;; Specific changes
  1 (0 syn-less 2 change-from-isolated 0)
    2 ((The thing that I would change about myself is being less alone \.) (want-change-about-you)) (0 :gist)
  1 (0 NEG 2 be 2 change-from-isolated 0)
    2 ((The thing that I would change about myself is being less alone \.) (want-change-about-you)) (0 :gist)
  1 (0 syn-less 2 change-from-procrastinator 0)
    2 ((The thing that I would change about myself is procrastinating less \.) (want-change-about-you)) (0 :gist)
  1 (0 NEG 2 be NEG change-from-procrastinator 0)
    2 ((The thing that I would change about myself is procrastinating less \.) (want-change-about-you)) (0 :gist)
  1 (0 change-from-unhealthy 0)
    2 ((The thing that I would change about myself is being more healthy \.) (want-change-about-you)) (0 :gist)
  1 (0 BADHEALTH 0)
    2 ((The thing that I would change about myself is being more healthy \.) (want-change-about-you)) (0 :gist)
  1 (0 BADSTATE 0)
    2 ((The thing that I would change about myself is being more happy \.) (want-change-about-you)) (0 :gist)
  1 (0 negative 0)
    2 ((The thing that I would change about myself is being less negative \.) (want-change-about-you)) (0 :gist)
  1 (0 syn-doing 3 change-to-independent 0)
    2 ((The thing that I would change about myself is being more independent \.) (want-change-about-you)) (0 :gist)
  1 (0 change-to-two-learning 2 change-to-two-learning 0)
    2 ((The thing that I would change about myself is learning new skills \.) (want-change-about-you)) (0 :gist)
  1 (0 new change-to-two-learning 0)
    2 (0 experience 0) 
      3 ((The thing that I would change about myself is having new experiences \.) (want-change-about-you)) (0 :gist)
    2 ((The thing that I would change about myself is learning new skills \.) (want-change-about-you)) (0 :gist)
  1 (0 change-from-comm-skills 0)
    2 ((The thing that I would change about myself is improving my communication skills \.) (want-change-about-you)) (0 :gist)
  ;1 (0 do things alone 0)
   ; 2 ((The thing that I would change about myself is to be able to do things alone \.) ()) (0 :gist)
   ;1 (0 live 1 alone 0)
    ;2 ((The thing that I would change about myself is to be able to live alone \.) ()) (0 :gist)

  1 (0 can not 1 think 0)
    2 ((There is nothing that I would change about myself \.) (want-change-about-you)) (0 :gist)
  1 (0 not 1 sure 0)
    2 ((There is nothing that I would change about myself \.) (want-change-about-you)) (0 :gist)
  1 (0 not really 0)
    2 ((There is nothing that I would change about myself \.) (want-change-about-you)) (0 :gist)
   1 (0)
       2 ((NIL Gist \: nothing found for the thing change about myself is \.) (want-change-about-you)) (0 :gist)

  ))
       
       
 (READRULES '*thematic-answer-from-want-change-about-you-input*
    '())

 (READRULES '*unbidden-answer-from-want-change-about-you-input*
    '())
		
 (READRULES '*question-from-want-change-about-you-input*
    '(
    1 (0 what 2 you 0)
       2 (what are things you want to change about yourself ?) (0 :gist)
    1 (0 how 2 you 0)
       2 (what are things you want to change about yourself ?) (0 :gist)
    ))

(READRULES '*reaction-to-want-change-about-you-input*
  '( 
  ;; Two word
  1 (0 quality-two-types-archetypes quality-two-types-archetypes 0)
     2 (Being a 2 3 is a good trait to work on\! Personally\, you are trying to work on being a better listener\.) (100 :out)
  1 (0 quality-two-types-participle quality-two-types-participle 0)
     2 (2 3 is a good trait to work on\! Personally\, you are trying to work on being a better listener\.) (100 :out)
  1 (0 quality-two-types-verb quality-two-types-verb 0)
     2 (Knowing how to 2 3 is a good trait to work on\! Personally\, you are trying to work on being a better listener\.) (100 :out)
  1 (0 quality-two-types-noun quality-two-types-noun 0)
     2 (0 hard work 0)
       3 (Being a hard worker is a good trait to work on\! Personally\, you are trying to work on being a better listener\.) (100 :out)
     2 (0 open mind 0)
       3 (Having an open mind is a good trait to work on\! Personally\, you are trying to work on being a better listener\.) (100 :out)
     2 (Having 2 3 is a good trait to work on\! Personally\, you are trying to work on being a better listener\.) (100 :out)
  1 (0 quality-two-types-adj quality-two-types-adj 0)
     2 (Being more 2 3 is a good trait to work on\! Personally\, you are trying to work on being a better listener\.) (100 :out)
  ;; One word
  1 (0 quality-types-archetypes 0)
     2 (Being a 2 is a good trait to work on\! Personally\, you are trying to work on being a better listener\.) (100 :out)
  1 (0 quality-types-participle 0)
     2 (2 is a good trait to work on\! Personally\, you are trying to work on being a better listener\.) (100 :out)
  1 (0 quality-types-verb 0)
     2 (Knowing how to 2 is a good trait to work on\! Personally\, you are trying to work on being a better listener\.) (100 :out)
  1 (0 quality-types-noun 0)
     2 (0 humor 0)
       3 (Having a good sense of humor is a good trait to work on\! Personally\, you are trying to work on being a better listener\.) (100 :out)
     2 (0 smile 0)
       3 (Having a nice smile is a good thing to work on\! Personally\, you are trying to work on being a better listener\.) (100 :out)
     2 (0 relationship 0)
       3 (Having better relationships is a good thing to work on\! Personally\, you are trying to work on being a better listener\.) (100 :out)
     2 (0 health 0)
       3 (Having good health is pretty important\! You hope I stay healthy in the future\.) (100 :out)
     2 (Having 2 is a good trait to work on\! Personally\, you are trying to work on being a better listener\.) (100 :out)
  1 (0 quality-types-adj 0)
     2 (Being more 2 is a good trait to work on\! Personally\, you are trying to work on being a better listener\.) (100 :out)
  ;; Specific changes
  1 (0 less alone 0)
     2 (It\'s always good to have friends to keep me company\. You hope I am successful with that\!) (100 :out)
  1 (0 procrastinating less 0)
     2 (You know what it\'s like to get distracted too easily\. You hope I can improve\.) (100 :out)
  1 (0 more healthy 0)
     2 (Having good health is pretty important\! You hope I stay healthy in the future\.) (100 :out)
  1 (0 more happy 0)
     2 (You hope I can find something to keep me happy in the future\.) (100 :out)
  1 (0 less negative 0)
     2 (It is important to be able to stay positive and optimistic about me and my life \.) (100 :out)
  1 (0 more independent 0)
     2 (Being more independent is always good\, you hope I have success with that\.) (100 :out)
  1 (0 learning new skills 0)
     2 (You think there\'s possibilities to learn new skills every day\. You hope I am successful with that\!) (100 :out)
  1 (0 having new experience 0)
     2 (You think there\'s possibilities to have new experiences every day\. You hope I am successful with that\!) (100 :out)
 1 (0 change-from-comm-skills  0)
     2 (You think improving communication and social skills would be great\, since it helps me have more effective relations with other people \.) (100 :out)
  ;; Nothing/not sure
  1 (0 there is nothing 3 change about myself 0)
     2 (It\'s great to be comfortable with myself\! You hope I can continue to do so in the future\.) (100 :out)
  1 (0 NIL Gist 0)
     2 (We all have traits we could improve on\. Something to keep in mind for the future\!) (100 :out)
	))
); end of eval-whena
