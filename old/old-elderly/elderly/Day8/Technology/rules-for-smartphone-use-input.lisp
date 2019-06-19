(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; MEETING WITH KIM NOTES (8/4/2017)

  ;; Don't want to have one
    ;; Response: "What do your kids/grandkids use it for?"

  ;; Kids have them
  ;; Grandkids use them all the time
  ;; Staying/keeping in touch with family & friends
  ;; Skype / facetime
  ;; Text people
  ;; Have one but don't know how to use it
  ;; Kids wanted them to have it
  ;; No idea how to use it, just make phone calls
  ;; Games / apps
  ;; Watch videos (youtube)
  ;; Facebook (usually look at photos)
  ;; Take pictures
  ;; Helps keep independent (assistive technology)
  (kid kids son daughter grandchild grandchildren grandkids grandkid grandson granddaughter family friends friends)
  (contact touch)
  (call-apps skype skyping Facetime) 
  (social-networks twitter facebook instagram messenger)
  (game entertain entertainment music video videos applictions appliction)
  (camera picture pictures photos photo video videos)
  (text texting call calling message messaging)
  (independent assistive assist)
  
  ))
   

;;	Do you have a smartphone? What do you use it for?
;;	(0 I do not have a smartphone 0) 
;;	(0 I have a smartphone 0)
;;	(0 I use my smartphone for 0)
;;	smartphone-use
;;	(What do you use your smartphone if you have one ?)
;;	(3 What 2 use your smartphone 6) 


	

(READRULES '*specific-answer-from-smartphone-use-input*
  '(
  1 (0 call-apps 0)
    2 ((I use my smartphone for 2 \.) (smartphone-use)) (0 :gist)
  1 (0 social-networks 0)
    2 ((I use my smartphone for 2 \.) (smartphone-use)) (0 :gist)
  1 (0 contact 2 kid 0)
    2 ((I use my smartphone for contact with 4 \.) (smartphone-use)) (0 :gist)
  1 (0 game 0)
    2 ((I use my smartphone for 2 \.) (smartphone-use)) (0 :gist)
  1 (0 camera 0)
    2 ((I use my smartphone for taking or seeing pictures \.) (smartphone-use)) (0 :gist)
  1 (0 text 0)
    2 ((I use my smartphone for calling and texting \.) (smartphone-use)) (0 :gist)
  1 (0 independent 0)
    2 ((I use my smartphone for 2 \.) (smartphone-use)) (0 :gist)
  1 (0 NEG 3 idea 3 use 0)
    2 ((I have a smartphone but do not know how to use it \.) (smartphone-use)) (0 :gist)
  1 (0 NEG 1 know 3 use 0)
    2 ((I have a smartphone but do not know how to use it \.) (smartphone-use)) (0 :gist)
  1 (0 NEG 1 have 0)
    2 ((I do not have a smartphone \.) (smartphone-use)) (0 :gist) 
  1 (0)
       2 ((NIL Gist \: nothing found for if I have a smartphone \.) (smartphone-use)) (0 :gist)
))      
       
 (READRULES '*thematic-answer-from-smartphone-use-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-smartphone-use-input*
  '(
  
  ))
		
 (READRULES '*question-from-smartphone-use-input*
  '(
  1 (0 What 2 use your smartphone 0)
    2 (What do you use your smartphone if you have one ?) (0 :gist)
  1 (0 how 2 use your smartphone 0)
    2 (What do you use your smartphone if you have one ?) (0 :gist)
  1 (0 Do 2 need 2 smartphone 0)
    2 (Do you need a smartphone ?) (0 :gist)
  ))

(READRULES '*reaction-to-smartphone-use-input*
  '(
  1 (0 call-apps 0)
    2 (You like to use Skype because being able to see the other person\'s face makes the conversation more personal\.) (100 :out)
  1 (0 social-networks 0)
    2 (That\'s great that you\'re well connected\! It\'s good to be informed about family and friends\.) (100 :out)
  1 (0 contact with kid 0)
    2 (It\'s great that I\'m able to stay well connected to my 8 \.) (100 :out)
  1 (0 game 0)
    2 (Smartphone games can be entertaining\. You use them to pass the time when you have to wait for something\.) (100 :out)
  1 (0 camera 0)
    2 (You think it\'s really nice that people have the ability to save memories easily just by taking pictures\.) (100 :out)
  1 (0 text 0)
    2 (It sounds like I just use the most basic smartphone features\. That\'s okay though\, it\'s all I really need to communicate with friends and family\.) (100 :out)
  1 (0 independent 0)
    2 (You think it\'s awesome that my smartphone is helping me be more independent\.) (100 :out)
  1 (0 do not know how to use 0)
    2 (Perhaps I can talk to friends or family one day to figure out how to use it one day\. I might find it to be extremely helpful\!) (100 :out)
  1 (0 do not have a smartphone 0)
    2 (You think it\'s very important to have a smartphone these days\. Of course\, the most important thing is that I\'m happy\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (Although learning how to use a smartphone can be very confusing\, knowing how to use one helps a lot in daily life\.) (100 :out)
  ))
); end of eval-when
