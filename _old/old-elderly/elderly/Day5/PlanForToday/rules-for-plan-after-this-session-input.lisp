(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; MEETING WITH KIM NOTES (8/4/2017)

  ;; Question prompt: "We mean things you do to relax, to help you go to sleep. For example, some people have a cup of tea. Do you do anything like that?"
  
  ;; Meditate
  ;; Pray
  ;; Breathing excersizes
  ;; Read
  ;; Watch TV
  ;; Knit
  ;; Spend time / snuggle with pets
  ;; Might have a drink (cocktail, wine)
  ;; Take medicine / melatonin

    (dinner lunch)
    (exercise walk walking run running jog jogging)
    (shopping mall plaza market supermarket)
    (watch watching TV read reading book newspapar listen listening radio)
    (cook cooking)
    (chat chatting)
(friends friend)
    (rest sleep sleeping relax relaxing)
  ))
   
;; 	What do you have planned for when you are done with our conversation?
;;  gist: What is your plan after this session?
;;  (0 my plan after this session 0)
;;  plan-after-this-session
;;  (2 What 2 plan after this session 2)

	

(READRULES '*specific-answer-from-plan-after-this-session-input*
  '(1 (0 dinner 0)
      2 ((My plan after this session is have 2 \.) (plan-after-this-session)) (0 :gist)
    1 (0 exercise 0)
      2 ((My plan after this session is have 2 \.) (plan-after-this-session)) (0 :gist)
    1 (0 shopping 0)
      2 ((My plan after this session is 2 \.) (plan-after-this-session)) (0 :gist)
    1 (0 watch watch 0)
      2 ((My plan after this session is 2 3 \.) (plan-after-this-session)) (0 :gist)
    1 (0 cook 0)
      2 ((My plan after this session is 2 \.) (plan-after-this-session)) (0 :gist)
    1 (0 chat 0)
      2 ((My plan after this session is 2 \.) (plan-after-this-session)) (0 :gist)
    1 (0 rest 0)
      2 ((My plan after this session is 2 \.) (plan-after-this-session)) (0 :gist)
    1 (0 read 0)
      2 ((My plan after this session is to read something \.) (plan-after-this-session)) (0 :gist)
    1 (0 friends 0)
      2 ((My plan after this session is to hang out with friends \.) (plan-after-this-session)) (0 :gist)
    1 (0 library 0)
      2 ((My plan after this session is to go to the library \.) (plan-after-this-session)) (0 :gist)
    1 (0)
       2 ((NIL Gist \: nothing found for what  my plan after this session is \.) (plan-after-this-session)) (0 :gist)
))
       
       
 (READRULES '*thematic-answer-from-plan-after-this-session-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-plan-after-this-session-input*
  '(
  ))
		
 (READRULES '*question-from-plan-after-this-session-input*
  '(
    1 (0 how 2 your plan 0)
        2 (What is your plan after this session ?) (0 :gist)
    1 (0 wh_ 4 plan 0)
        2 (What is your plan after this session ?) (0 :gist)
  ))

(READRULES '*reaction-to-plan-after-this-session-input*
  '( 
    1 (0 dinner 0)
      2 (Great\! You hope I enjoy the delicious food\.) (100 :out)    
    1 (0 exercise 0)
      2 (You hope I get good exercise after\! It\'s good for my health\.) (100 :out)
    1 (0 shopping 0)
      2 (Oh\, you need to go shopping sometime this week to buy a birthday gift for a friend \. You are just too lazy to go out \.) (100 :out)
    1 (0 watch watch 0)
      2 (I will 7 8 after this session\. It\'s a good way to relax\.) (100 :out) 
    1 (0 cook 0)
      2 (You are sure whatever I make will be very delicious\.) (100 :out)
    1 (0 chat 0)
      2 (Sounds like a fun afternoon\!) (100 :out) 
    1 (0 rest 0)
      2 (You hope I can get some nice relaxation in after the session\.) (100 :out) 
    1 (0 friends 0)
      2 (Hanging out with friends is always a joy\.) (100 :out) 
    1 (0 library 0)
      2 (You hope I enjoy my time with books\!) (100 :out) 
    1 (0 read 0)
      2 (You hope I enjoy my time reading\!) (100 :out) 
    1 (0 NIL Gist 0)
      2 (Well\, you hope I have a relaxing evening\.) (100 :out)

  ))
); end of eval-when
