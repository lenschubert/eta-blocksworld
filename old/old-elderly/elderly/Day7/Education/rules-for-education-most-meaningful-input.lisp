(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
    (knowledge academics academic rearch intellectual intelligence) 
    (skill skills tool tools)
    (interests interest desires passion passions )
    (growth experience)
    (class classes courses curricula curriculas curriculum)
    (people friends friend friendship social community)
    (cooperation cooperative collaborate)
    (compete competitive competitiveness)
    (stress disappointed disappointing)
    ))
   

;; What part of your education has been most meaningful to you?
;; (0 The most meaningful part 3 education 0)   
;; education-most-meaningful
;; (What part of your education has been most meaningful to you ?)
;; (3 what part 3 education 2 most meaningful 3)
	
(READRULES '*specific-answer-from-education-most-meaningful-input*
  '(
  1 (0 knowledge 0)
    2 ((The most meaningful part of education is the gain of knowledge \.) (education-most-meaningful)) (0 :gist)
  1 (0 knowledge 0)
    2 ((The most meaningful part of education is the gain of skills \.) (education-most-meaningful)) (0 :gist)
  1 (0 interests 0)
    2 ((The most meaningful part of education is finding 2 \.) (education-most-meaningful)) (0 :gist)
  1 (0 growth 0)
    2 ((The most meaningful part of education is growth \.) (education-most-meaningful)) (0 :gist)
  1 (0 class 0)
    2 ((The most meaningful part of education is taking classes\.) (education-most-meaningful)) (0 :gist)
  1 (0 people 0)
    2 ((The most meaningful part of education is people \.) (education-most-meaningful)) (0 :gist)
  1 (0 cooperation 0)
    2 ((The most meaningful part of education is learning cooperation \.) (education-most-meaningful)) (0 :gist)
  1 (0 stress 0)
    2 ((The most meaningful part of education is learning to deal with stress \.) (education-most-meaningful)) (0 :gist)
  1 (0)
       2 ((NIL Gist \: nothing found for the most meaningful part of education \.) (education-most-meaningful)) (0 :gist)
 ))
       
       
 (READRULES '*thematic-answer-from-education-most-meaningful-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-education-most-meaningful-input*
  '(
  ))
		
 (READRULES '*question-from-education-most-meaningful-input*
  '(
  1 (0 what 2 you 0)
     2 (What part of your education has been most meaningful to you ?) (0 :gist)
  1 (0 how 2 you think of 0)
     2 (What part of your education has been most meaningful to you ?) (0 :gist)
  ))

(READRULES '*reaction-to-education-most-meaningful-input*
  '( 
  1 (0 knowledge 0)
    2 (You learned a lot of knowledge from school\. Those skills help you a lot\.) (100 :out)
 1 (0 skill 0)
    2 (A big part of skills that helped you throughout your life were those you learned in primary and high school \.) (100 :out)
  1 (0 interests 0)
    2 (It is great that I found my interests from the education I received\.) (100 :out)
  1 (0 growth 0)
    2 (You can growth and learn a lot from the experience in schoool\.) (100 :out)
  1 (0 classes 0)
    2 (That is sweet to hear that I still remember the courses I took\. It must help me learn a lot\.) (100 :out)
  1 (0 people 0)
    2 (That is great that I meet good people in your school life\. Friendship is a treasure of my life\.) (100 :out)
  1 (0 cooperation 0)
    2 (Learning how to cooperate with other people is very meaningful\.) (100 :out)
  1 (0 stress 0)
    2 (Knowing how to deal with stress is useful for your life\.) (100 :out)
  1 (0)
    2 (It\'s good to find meaning in what I learn\.) (100 :out)
  ))
); end of eval-when
