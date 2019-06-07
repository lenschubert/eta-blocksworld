(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
    
  ;; MEETING WITH KIM NOTES (8/4/2017)

  ;; Younger people would focus more on activities and broad learning things
  ;; Older people tend to focus on more personally meaningful things, like relationships

  ;; Helping other people
  ;; Generous
  ;; Sharing their knowledge
  ;; Being a good partner
  ;; Take care of / Caregiver
  ;; Good parent

    ;; "I'm a good listener"
    (quality-types-archetypes listener encourager mediator joker helper conversationalist thinker
      communicator teacher motivator learner manager organizer leader speaker)

    ;; "I'm good at encouraging", "I enjoy helping", "one of my best qualities is listening"
    (quality-types-participle listening encouraging mediating joking helping conversing thinking
      communicating teaching motivating smiling engaging respecting learning understanding
      managing organizing leading socializing speaking creating focusing)

    ;; "I try to listen", "I like to help people"
    (quality-types-verb listen encourage mediate joke help converse communicate teach
      motivate engage respect learn manage organize lead socialize speak create
      concentrate)

    ;; "I have a good sense of humor", "my smile", "I like conversation"
    (quality-types-noun humor smile relationship relationships wisdom motivation confidence
      optimism strength courage character personality passion integrity knowledge
      ethics morality loyalty charisma humility discipline perspective organization maturity
      leadership speech honesty boldness empathy compassion responsbility flexibility
      intuition focus patience kindness concentration independence health experience)

    ;; "I'm very modest", "I just try to be happy"
    (quality-types-adj positive funny nice good pleasant intelligent smart comfortable friendly
      happy easygoing wise motivated confident optimistic strong courageous engaged
      passionate tall knowledgeable likable ethical moral loyal charismatic humble
      disciplined organized mature social honest reasonable bold authentic empathetic
      compassionate trustworthy creative responsible proactive flexible focused patient
      energetic concentrated independent healthy outgoing experienced resilient productive)

    (quality-two-types-archetypes hard worker)
    (quality-two-types-participle working hard getting along making friends helping other others)
    (quality-two-types-verb work hard get along make friends)
    (quality-two-types-noun hard work self control open mind social skills)
    (quality-two-types-adj hard working open minded easy going)

    (blur-types try maybe probably)
   ))
  

;;	What are your best qualities ?
;;	(your-best-quality)
;; 	from-your-best-quality-input
;;	(0 My best quality is 0)
;;		gist-question: (2 what 1 your best qualities 1)


 (READRULES '*specific-answer-from-your-best-quality-input*
   '(
    ;; Two word
    1 (0 quality-two-types-archetypes quality-two-types-archetypes 0)
       2 ((My best quality is being a 2 3 \.) (your-best-quality)) (0 :gist)
    1 (0 quality-two-types-participle quality-two-types-participle 0)
       2 ((My best quality is 2 3 \.) (your-best-quality)) (0 :gist)
    1 (0 quality-two-types-verb quality-two-types-verb 0)
       2 ((My best quality is trying to 2 3 \.) (your-best-quality)) (0 :gist)
    1 (0 quality-two-types-noun quality-two-types-noun 0)
       2 ((My best quality is having 2 3 \.) (your-best-quality)) (0 :gist)
    1 (0 quality-two-types-adj quality-two-types-adj 0)
       2 ((My best quality is being 2 3 \.) (your-best-quality)) (0 :gist)
    ;; One word
    1 (0 quality-types-archetypes 0)
       2 ((My best quality is being a 2 \.) (your-best-quality)) (0 :gist)
    1 (0 quality-types-participle 0)
       2 ((My best quality is 2 \.) (your-best-quality)) (0 :gist)
    1 (0 quality-types-verb 0)
       2 ((My best quality is trying to 2 \.) (your-best-quality)) (0 :gist)
    1 (0 quality-types-adj quality-types-noun 0)
       2 ((My best quality is having 2 3 \.) (your-best-quality)) (0 :gist)
    1 (0 quality-types-noun 0)
       2 ((My best quality is having 2 \.) (your-best-quality)) (0 :gist)
    1 (0 quality-types-adj 0)
	   2 (0 kind 0)
	      3 (0 be kind 0)
		     4 ((My best quality is being kind \.) (your-best-quality)) (0 :gist)
	   2 (0 nice 0)
	      3 (0 be nice 0)
		     4 ((My best quality is being nice \.) (your-best-quality)) (0 :gist)
	   2 ((My best quality is being 2 \.) (your-best-quality)) (0 :gist)
    1 (0 doing 1 independently 0)
       2 ((My best quality is being independent \.) (your-best-quality)) (0 :gist)

    ;; NOTE 1: Needs more handling of negative answers, e.g. "I'm not sure",
    ;; "I don't think I have one", etc.
    
    ;; Also there doesn't seem to be a supported gist clause matching these types of answers.

    1 (0 can NEG 1 think 0)
       2 ((I am not sure what my best quality is \.) (your-best-quality)) (0 :gist)
    1 (0 do NEG 1 think 0)
       2 ((I am not sure what my best quality is \.) (your-best-quality)) (0 :gist)
    1 (0 do NEG 1 introspect 0)
       2 ((I am not sure what my best quality is \.) (your-best-quality)) (0 :gist)
    1 (0 never 1 thought about 0)
       2 ((I am not sure what my best quality is \.) (your-best-quality)) (0 :gist)
    1 (0 not 1 sure 0)
       2 ((I am not sure what my best quality is \.) (your-best-quality)) (0 :gist)
     1 (0)
       2 ((NIL Gist \: nothing found for what my best quality is \.) (your-best-quality)) (0 :gist)
))
       
       
 (READRULES '*thematic-answer-from-your-best-quality-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-your-best-quality-input*
  '(
    
  ;; NOTE 2: Might be some unbidden answers here in the following form:
  ;; "I think I'm a good listener, but I need to work on my social skills a bit"
  ;; This would be an unbidden answer for want-change-about-you.

  ))
		
 (READRULES '*question-from-your-best-quality-input*
    '(1 (0 what 2 you 0)
        2 (what are your best qualities ?) (0 :gist)
      1 (0 how 2 you 0)
        2 (what are your best qualities ?) (0 :gist)
      1 (0 your best qualities 0)
        2 (what are your best qualities ?) (0 :gist)
      ))

(READRULES '*reaction-to-your-best-quality-input*
  '(
  ;; Two word
  1 (0 quality-two-types-archetypes quality-two-types-archetypes 0)
     2 (You think being a 2 3 is extremely important\. You are sure we would get along quite well\.) (100 :out)
  1 (0 quality-two-types-participle quality-two-types-participle 0)
     2 (You think being good at 2 3 is extremely important\. You are sure we would get along quite well\.) (100 :out)
  1 (0 quality-two-types-verb quality-two-types-verb 0)
    2 (0 get along 0)
      3 (You think being able to get along well with others is extremely important\. That is something that you should improve in you \.) (100 :out)
     2 (You think being able to 2 3 is extremely important\. You are sure we would get along quite well\.) (100 :out)
  1 (0 quality-two-types-noun quality-two-types-noun 0)
     2 (0 hard work 0)
       3 (You think doing hard work is extremely important\. You are sure we would get along quite well\.) (100 :out)
     2 (0 open mind 0)
       3 (You think having an open mind extremely important\. You are sure we would get along quite well\.) (100 :out)
     2 (You think having 2 3 is extremely important\. You are sure we would get along quite well\.) (100 :out)
  1 (0 quality-two-types-adj quality-two-types-adj 0)
     2 (You think being 2 3 is extremely important\. You are sure we would get along quite well\.) (100 :out)
  ;; One word
  1 (0 quality-types-archetypes 0)
     2 (You think being a 2 is extremely important\. You are sure we would get along quite well\.) (100 :out)
  1 (0 quality-types-participle 0)
     2 (You think being good at 2 is extremely important\. You are sure we would get along quite well\.) (100 :out)
  1 (0 quality-types-verb 0)
     2 (You think trying to 2 is extremely important\. You are sure we would get along quite well\.) (100 :out)
  1 (0 quality-types-adj quality-types-noun 0)
      2 (You think having 2 3 is extremely important\. You are sure we would get along quite well\.) (100 :out) 
  1 (0 quality-types-noun 0)
     2 (0 humor 0)
       3 (You think having a good sense of humor is extremely important\. You are sure we would get along quite well\.) (100 :out)
     2 (0 smile 0)
       3 (You think having a nice smile is extremely important\. You are sure we would get along quite well\.) (100 :out)
     2 (0 relationship 0)
       3 (You think having a good relationship with someone is extremely important\. You are sure we would get along quite well\.) (100 :out)
     2 (0 health 0)
       3 (You think having good health is extremely important\, especially in old age\.) (100 :out)
  1 (0 quality-types-adj 0)
     2 (You think being 2 is extremely important\. You are sure we would get along quite well\.) (100 :out)
   
  ;; NOTE 3: Need proper handling for "I'm not sure" answers
   1 (0 I am not sure 0)
     2 (You are sure I have a lot of nice qualities \.) (100 :out)
  1 (0 NIL Gist 0)
     2 (Thank me for telling you\. You are sure we would get along quite well\.) (100 :out)
	))
); end of eval-when
