(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; MEETING WITH KIM NOTES (8/4/2017)

  ;; New question prompt: "Retirement is a common life transition. Tell me about the best parts of retirement that you've
  ;; experienced or that someone you know has experienced."

  ;; There aren't any good things / I hate retirement
    ;; Response: "Think about the most positive person you know. What would that person say?"

  ;; Hated their job
  ;; Really excited to spend more time with family
  ;; Time to relax
  ;; To travel
  ;; To learn new/more things
  ;; Sleep in
  ;; Spend time with grandkids / more time to be with grandkids
  ;; Time for volunteering

  (alt-hated hated disliked tired bored dislike disliked)
  (alt-work work working job)
  (alt-relax relax relaxing unwind)
  (alt-travel travel travelling vacation vacations)
  (alt-learn learn learning discover discovering experience experiencing)
  (alt-new new more)
  (alt-sleep sleep sleeping rest resting)
  (alt-sleep-in in more later better)

  ))
   
;;   Retirement is a common life transition\. Tell me about the best part of the retirement that you experienced or someone you know\.
;;	(0 best part 2 retirement 0)
;;	retirement-best-part
;;	(what is the best part of the retirement ?)
;;	(3 what 2 best part 2 retirement 3)
	

;; NOTE: Proposed new gist clause: "(0 best part of retirement is 0)"
;; Needs new tag

(READRULES '*specific-answer-from-retirement-best-part-input*
  '(
  1 (0 alt-hated 2 alt-work 0)
    2 ((The best part of retirement is that I hated working \.) (retirement-best-part)) (0 :gist)
  1 (0 alt-sleep 1 alt-sleep-in 0)
    2 ((The best part of retirement is that I can get more sleep \.) (retirement-best-part)) (0 :gist)
  1 (0 alt-sleep-in 1 alt-sleep 0)
    2 ((The best part of retirement is that I can get more sleep \.) (retirement-best-part)) (0 :gist)
  1 (0 alt-learn 1 alt-new 0)
    2 ((The best part of retirement is that I can learn new things \.) (retirement-best-part)) (0 :gist)
  1 (0 alt-relax 0)
    2 ((The best part of retirement is that I have time to relax \.) (retirement-best-part)) (0 :gist)
  1 (0 alt-travel 0)
    2 ((The best part of retirement is that I can travel more \.) (retirement-best-part)) (0 :gist)
  1 (0 time 3 relative-types 0)
    2 ((The best part of retirement is that I can spend more time with 4 \.) (retirement-best-part)) (0 :gist)
  1 (0 hang out 3 relative-types 0)
    2 ((The best part of retirement is that I can spend more time with 5 \.) (retirement-best-part)) (0 :gist)
  1 (0 time 3 friends 0)
    2 ((The best part of retirement is that I can spend more time with 4 \.) (retirement-best-part)) (0 :gist)
  1 (0 hang out 3 friends 0)
    2 ((The best part of retirement is that I can spend more time with 5 \.) (retirement-best-part)) (0 :gist)
  1 (0 alt-volunteer 0)
    2 ((The best part of retirement is that I can spend time volunteering \.) (retirement-best-part)) (0 :gist)
  1 (0)
       2 ((NIL Gist \: nothing found for the best part of retirement \.) (retirement-best-part)) (0 :gist)
 ))   
       
 (READRULES '*thematic-answer-from-retirement-best-part-input*
  '(
  ))

 (READRULES '*unbidden-answer-from-retirement-best-part-input*
  '( 
  ))
		
 (READRULES '*question-from-retirement-best-part-input*
  '(

  ;; NOTE: Proposed new question: "(What was the best part of retirement ?)"

  1 (0 are 2 you 2 working)
     2 (Are you still working ?) (0 :gist)
  1 (0 have 2 you 2 retired)
     2 (Are you still working ?) (0 :gist)
  1 (0 what 2 you 2 work)
     2 (Are you still working ?) (0 :gist)
  1 (0 what 2 you 0)
     2 (What was the best part of retirement ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (What was the best part of retirement ?) (0 :gist)
  ))

(READRULES '*reaction-to-retirement-best-part-input*
  '(
  1 (0 hated working 0)
    2 (Working can be very stressful sometimes\. It\'s always nice to have more free time\.) (100 :out)
  1 (0 get more sleep 0)
    2 (It\'s always a good feeling when I can sleep in and not feel tired\.) (100 :out)
  1 (0 learn new things 0)
    2 (You are sure retirement leaves plenty of free time to learn and experience new things\.) (100 :out)
  1 (0 time to relax 0)
    2 (Working can be very stressful sometimes\. It\'s always nice to be able to relax more\.) (100 :out)
  1 (0 travel more 0)
    2 (It\'s great to be able to have more free time to take vacations and travel more\.) (100 :out)
  1 (0 spend more time with relative-types 0)
    2 (Sometimes I can be so busy with work that I can\'t spend as much time with family\. It must be nice to finally have more time to spend with them\.) (100 :out)
  1 (0 spend time volunteering 0)
    2 (It\'s great to take some time helping with the community\, even after retiring from work\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (Working can be very stressful sometimes\. You are sure it must be nice to have some more free time\.) (100 :out)
  ))
); end of eval-when
