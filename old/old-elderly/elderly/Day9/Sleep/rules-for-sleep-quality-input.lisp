(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; MEETING WITH KIM NOTES (8/8/2017)

  ;; Notice they need less sleep
  ;; Sleep getting worse
  ;; Poor sleep
  ;; Need to use the bathroom
  ;; In pain
  ;; Insomnia / trouble sleeping
  ;; Trouble falling / staying asleep
  ;; Waking early
  
  ;; Response types:
  ;; Not getting enough sleep is tough, isn't it?

  (alt-less less worse worsening poor trouble)
  (alt-sleep sleep sleeping asleep)
  (alt-need need have)
  (alt-bathroom bathroom toilet pee)
  (alt-pain pain painful hurt hurts hurting)
  (alt-well well good great)
  (alt-deepsleep rock stone log) ;; I sleep like a rock

  ))
   
;;  How well do you sleep at night? Has this changed as you’ve gotten older?
;;	(0 I do not sleep well at night 0) 
;;	(0 I sleep well at night 0)
;;	(0 My sleep quality has gotten 3 as I have gotten older 0)
;;	sleep-quality
;;	(How do you sleep at night ?)
;;	(3 how 2 sleep 2 night 3) 


(READRULES '*specific-answer-from-sleep-quality-input*
  '(
  1 (0 alt-need 4 alt-bathroom 0)
    2 ((I do not sleep well at night because I need to use the bathroom \.) (sleep-quality)) (0 :gist)
  1 (0 alt-pain 0)
    2 ((I do not sleep well at night because I am in pain \.) (sleep-quality)) (0 :gist)
  1 (0 insomnia 0)
    2 ((I do not sleep well at night because I have insomnia \.) (sleep-quality)) (0 :gist)
  1 (0 waking 2 early 0)
    2 ((I do not sleep well at night because I wake up too early \.) (sleep-quality)) (0 :gist)
  1 (0 alt-less 2 alt-sleep 0)
    2 ((I do not sleep well at night \.) (sleep-quality)) (0 :gist)
  1 (0 alt-sleep 2 alt-less 0)
    2 ((I do not sleep well at night \.) (sleep-quality)) (0 :gist)
  1 (0 alt-sleep 2 alt-well 0)
    2 ((I sleep well at night \.) (sleep-quality)) (0 :gist)
  1 (0 like 1 alt-deepsleep 0)
    2 ((I sleep well at night \.) (sleep-quality)) (0 :gist)
  1 (0)
       2 ((NIL Gist \: nothing found for if my sleep quality has gotten better or worse as I have gotten older \.) (sleep-quality)) (0 :gist)
))    
       
 (READRULES '*thematic-answer-from-sleep-quality-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-sleep-quality-input*
  '( 
  
  ))
		
 (READRULES '*question-from-sleep-quality-input*
  '(
  1 (0 what 2 you 0)
     2 (How do you sleep at night ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (How do you sleep at night ?) (0 :gist)
  ))

(READRULES '*reaction-to-sleep-quality-input*
  '(
  1 (0 NIL Gist 0)
    2 (You wish me luck in getting enough sleep in the future\.) (100 :out)
  1 (0 NEG sleep well at night 2 need 3 bathroom 0)
    2 (It sounds very annoying to have to use the bathroom in the middle of the night\.) (100 :out)
  1 (0 NEG sleep well at night 2 am in pain 0)
    2 (Being in pain while trying to sleep sounds awful\. Perhaps a doctor may be able to help me feel better\.) (100 :out)
  1 (0 NEG sleep well at night 2 have insomnia 0)
    2 (Having insomnia must be tough to deal with\. I should try sleeping medication\, if I haven\'t yet\.) (100 :out)
  1 (0 NEG sleep well at night 2 wake up too early 0)
    2 (Waking up earlier than I planned to is quite annoying\. Maybe try going to bed a bit earlier as well\.) (100 :out)
  1 (0 NEG sleep well at night 0)
    2 (Not getting enough sleep sounds tough\. You hate the feeling of being tired\.) (100 :out)
  1 (0 sleep well at night 0)
    2 (It\'s awesome that you are able to sleep comfortably at night\.) (100 :out)

  ))
); end of eval-when
