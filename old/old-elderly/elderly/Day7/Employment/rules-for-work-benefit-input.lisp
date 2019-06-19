(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; MEETING WITH KIM NOTES (8/4/2017)

  ;; New question prompt: "Think about work you've done. It might be in the home, a career, or volunteer work.
  ;; How did that work benefit you?"

  ;; It paid the bills
  ;; Source of income
  ;; Supporting their family
  ;; Money for retirement
  ;; Sense of meaning / purpose
  ;; Travel
  ;; Learning new things
  ;; Being around other people / making friends/connections
  ;; Keeping busy

  (alt-paid paid pay handled handle took source) ;; "took care of the bills" "source of income"
  (alt-retirement retirement retiring)
  (alt-purpose purpose meaning)
  (alt-make-friend being be making make finding find talking talk)
  (alt-friend friend friends people connections relationship relationships acquaintances others)
  (alt-keep keep keeping stay staying help helping make making)
  (alt-busy busy occupied entertained engaged involved)

  )) 

;; 	Think about work you have done\, it might be in the home\, a career or a volunteer work\. How did that work benefit you?
;;	(0 work benefited me 0)
;;	work-benefit
;;	(How could work benefit you ?)
;;	(3 How 2 work benefit 3)
	
;; NOTE: Proposed new gist clause: "(0 work benefited me by 0)"
;; Needs new tag

(READRULES '*specific-answer-from-work-benefit-input*
  '(
  1 (0 alt-paid 3 alt-money 0)
    2 ((My work benefited me by paying the bills \.) (work-benefit)) (0 :gist)
  1 (0 alt-volunteer 2 relative-types 0)
    2 ((My work benefited me by supporting my family \.) (work-benefit)) (0 :gist)
  1 (0 alt-money 2 alt-retirement 0)
    2 ((My work benefited me by giving me money for retirement \.) (work-benefit)) (0 :gist)
  1 (0 alt-learn 1 alt-new 0)
    2 ((My work benefited me by letting me learn new things \.) (work-benefit)) (0 :gist)
  1 (0 alt-purpose 0)
    2 ((My work benefited me by giving me a sense of purpose \.) (work-benefit)) (0 :gist)
  1 (0 alt-travel 0)
    2 ((My work benefited me by letting me travel \.) (work-benefit)) (0 :gist)
  1 (0 alt-make-friend 2 alt-friend 0)
    2 ((My work benefited me by letting me be around friends \.) (work-benefit)) (0 :gist)
  1 (0 alt-keep 2 alt-busy 0)
    2 ((My work benefited me by keeping me busy \.) (work-benefit)) (0 :gist)
   1 (0)
       2 ((NIL Gist \: nothing found for how my work benefited me \.) (work-benefit)) (0 :gist)
 ))
          
 (READRULES '*thematic-answer-from-work-benefit-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-work-benefit-input*
  '(
  
  ))
		
 (READRULES '*question-from-work-benefit-input*
  '(

  ;; NOTE: Proposed new question: "(How did work benefit you ?)"

  1 (0 are 2 you 2 working)
     2 (Are you still working ?) (0 :gist)
  1 (0 have 2 you 2 retired)
     2 (Are you still working ?) (0 :gist)
  1 (0 what 2 you 2 work)
     2 (Are you still working ?) (0 :gist)
  1 (0 what 2 you 0)
     2 (How did work benefit you ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (How did work benefit you ?) (0 :gist)
  ))

(READRULES '*reaction-to-work-benefit-input*
  '( 
  1 (0 paying the bills 0)
    2 (Being a source of income is a very practical way of looking at work\. But it\'s the truth\.) (100 :out)
  1 (0 supporting my family 0)
    2 (It\'s great that my work helped support the important people in my life as well as me \.) (100 :out)
  1 (0 money for retirement 0)
    2 (You are sure all the hard work I put in is worth it once I am able to retire\.) (100 :out)
  1 (0 learn new things 0)
    2 (Work can be an excellent way to learn and master life skills\.) (100 :out)
  1 (0 a sense of purpose 0)
    2 (It\'s cool that work made me feel some sense of purpose\. You hope that feeling can stay with me \.) (100 :out)
  1 (0 travel 0)
    2 (It must be very lucky to have a job that lets me go on nice vacations\.) (100 :out)
  1 (0 be around friends 0)
    2 (Work can be quite the social hub sometimes\. It\'s cool that I were able to have friends through work\.) (100 :out)
  1 (0 keeping me busy 0)
    2 (Sometimes when I stop working I realize just how nice it was to have something to occupy me \.) (100 :out)
  1 (0 NIL Gist 0)
    2 (Work can be a valuable experience for many people\, even if it can be stressful at times\.) (100 :out)
  ))
); end of eval-when
