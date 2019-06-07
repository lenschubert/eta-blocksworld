(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
  
  ;; MEETING WITH KIM NOTES (8/4/2017)

  ;; It doesn't help
    ;; Response: "Tell me about someone you know who uses art this way. / Use your imagination, tell me what you think someone who uses art this way might think."

  ;; Offering art lessons at senior living community
  ;; Gets them out of the house
  ;; Relaxation
  ;; Creativity / Imagination
  ;; Helps give you a purpose
  ;; Is fun

  (per-ref me us we you them people person artist artists)
  (verb-make make makes making cause causes causing help helps helping keep keeps keeping get gets getting)
  (verb-show show shows showing give gives giving)
  (syn-happiness happiness wellness pleasure delight gladness satisfaction contentness joy fun)
  (syn-problems problems troubles)
  (syn-creativity creativity creative imagination imaginative express expression)
  (syn-teach teach teaching lesson lessons)

  ))
   

;;	Tell me about ways art helps you cope with stress or negative emotions. 
;;	(0 art helps one cope with stress 0)
;;	ways-art-helps
;;	(How does art help you cope with negative emotions ?)
;;	(3 How 2 art help 2 cope 2 negative emotions 3)

	

(READRULES '*specific-answer-from-ways-art-helps-input*
  '(
  1 (0 verb-make 1 per-ref 2 active 0)
    2 ((Art helps one cope with stress by keeping them active \.) (ways-art-helps)) (0 :gist)
  1 (0 verb-make 1 per-ref 2 out of 2 house 0)
    2 ((Art helps one cope with stress by keeping them active \.) (ways-art-helps)) (0 :gist)
  1 (0 syn-creativity 0)
    2 ((Art helps one cope with stress by letting them be creative \.) (ways-art-helps)) (0 :gist)
  1 (0 RELAXATION 0)
    2 ((Art helps one cope with stress by being relaxing \.) (ways-art-helps)) (0 :gist)
  1 (0 verb-make 1 per-ref 2 noun-purpose 0)
    2 ((Art helps one cope with stress by giving them a purpose \.) (ways-art-helps)) (0 :gist)
  1 (0 verb-show 1 per-ref 2 noun-purpose 0)
    2 ((Art helps one cope with stress by giving them a purpose \.) (ways-art-helps)) (0 :gist)
  1 (0 verb-make 1 per-ref 2 GOODSTATE 0)
    2 ((Art helps one cope with stress by making them happy \.) (ways-art-helps)) (0 :gist)
  1 (0 verb-make 1 per-ref 2 less BADSTATE 0)
    2 ((Art helps one cope with stress by making them happy \.) (ways-art-helps)) (0 :gist)
  1 (0 verb-show 1 per-ref 2 noun-happiness 0)
    2 ((Art helps one cope with stress by making them happy \.) (ways-art-helps)) (0 :gist)
  1 (0 forget 3 noun-problems 0)
    2 ((Art helps one cope with stress by making them happy \.) (ways-art-helps)) (0 :gist)
  1 (0 syn-teach 2 at 0)
    2 ((Art helps one cope with stress by letting them teach \.) (ways-art-helps)) (0 :gist)
  1 (0)
    2 ((NIL Gist \: nothing found for how art helps one cope with stress \.) (ways-art-helps)) (0 :gist)
))
          
 (READRULES '*thematic-answer-from-ways-art-helps-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-ways-art-helps-input*
  '(
  
  ))
		
 (READRULES '*question-from-ways-art-helps-input*
  '(
  1 (0 what 2 you 0)
     2 (How does art help you cope with negative emotions ?) (0 :gist)
  1 (0 how 1 art 1 you 0)
     2 (How does art help you cope with negative emotions ?) (0 :gist)
  ))

(READRULES '*reaction-to-ways-art-helps-input*
  '(
  1 (0 keeping them active 0)
    2 (It\'s good to have a hobby like art to keep me busy\! Otherwise\, life can get quite boring\.) (100 :out)
  1 (0 letting them be creative 0)
    2 (You think everyone should have a creative outlet of some sort\. People are naturally creative\, they just have to find which art they\'re talented in\.) (100 :out)
  1 (0 being relaxing 0)
    2 (You love the relaxed feeling you get when making art\. Focusing on just that one thing helps you forget about all your worries\.) (100 :out)
  1 (0 giving them a purpose 0)
    2 (The sense of purpose that comes from creating art and contributing to the world is a great feeling\.) (100 :out)
  1 (0 making them happy 0)
    2 (Making art can be a lot of fun\! It\'s good to have things like that to entertain me \.) (100 :out)
  1 (0 letting them teach 0)
    2 (It\'s cool that there are so many opportunities available for learning or giving lessons on art\. It\'s important for artists to pass on their skill\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (You personally think one of the most important ways art helps is just giving you a fun and creative thing to look forward to every day\.) (100 :out)
  ))
); end of eval-when
