(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
   (transportation bus taxi uber lyft bike map navigator)
   (social facetime facebook messenger massage text call touch contact)
   (network news event events information)
   (medical medicine treatment)
   (game entertain entertainment music video videos appliction applictions)
   (camera pictures photos photo)
   (convenient fast independent assistive assist)
   (save money time)
   (map maps)
  ))
   

;;  What is the best part of advances in technology these days? 
;;	(0 the best part of advances in technology is 0)   (0 no good in advances in technology 0)
;;	technology-best-part
;;	(What is the best part of advances in technology ?) 
;;	(3 what 3 best part of advances in technology 3) 
	
(READRULES '*specific-answer-from-technology-best-part-input*
  '(
  1 (0 transportation 0)
    2 ((The best part of advances in technology is 2 \.) (technology-best-part)) (0 :gist)
  1 (0 social 0)
    2 ((The best part of advances in technology is 2 \.) (technology-best-part)) (0 :gist)
  1 (0 network 0)
    2 ((The best part of advances in technology is 2 \.) (technology-best-part)) (0 :gist)
  1 (0 medical 0)
    2 ((The best part of advances in technology is 2 \.) (technology-best-part)) (0 :gist)
  1 (0 game 0)
    2 ((The best part of advances in technology is 2 \.) (technology-best-part)) (0 :gist)
  1 (0 camera 0)
    2 ((The best part of advances in technology is 2 \.) (technology-best-part)) (0 :gist)
  1 (0 convenient 0)
    2 ((The best part of advances in technology is 2 \.) (technology-best-part)) (0 :gist)
  1 (0 save save 0)
    2 ((The best part of advances in technology is save 3 \.) (technology-best-part)) (0 :gist)
  1 (0 map 0)
    2 ((The best part of advances in technology is mobile maps \.) (technology-best-part)) (0 :gist)
  1 (0 NEG 1 think 0)
    2 ((There is no good in advances in technology \.) (technology-best-part)) (0 :gist)
  1 (0 NEG 1 like 0)
    2 ((There is no good in advances in technology \.) (technology-best-part)) (0 :gist)

  1 (0)
       2 ((NIL Gist \: nothing found for what the best part of advances in technology is  \.) (technology-best-part)) (0 :gist)
))
          
 (READRULES '*thematic-answer-from-technology-best-part-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-technology-best-part-input*
  '(
  
  ))
		
 (READRULES '*question-from-technology-best-part-input*
  '(
  1 (0 what 3 best part of advances in technology 0) 
    2 (What is the best part of advances in technology ?) (0 :gist)
  1 (0 how do you think 3 best part of advances in technology 0)
    2 (What is the best part of advances in technology ?) (0 :gist)
  1 (0 what 2 you 0)
    2 (What is the best part of advances in technology ?) (0 :gist)
  1 (0 how 2 you 0)
    2 (What is the best part of advances in technology ?) (0 :gist) 
  ))

(READRULES '*reaction-to-technology-best-part-input*
  '( 
  1 (0 transportation 0)
    2 (Technology definitely makes transporation much easier\. You remember when people had to use paper maps\, now you can just use my smartphone\!) (100 :out)
  1 (0 social 0)
    2 (It\'s great to be able to talk with friends more easily\, even if they\'re currently somewhere far away\.) (100 :out)
  1 (0 network 0)
    2 (You think sometimes news can be overwhelming with current technology\. But it definitely is helpful to know of events immediately\.) (100 :out)
  1 (0 medical 0)
    2 (People seem to be living longer and healthier lives than ever due to better medical technology\.) (100 :out)
  1 (0 game 0)
    2 (You don\'t spend a lot of time playing video games\, but it\'s a fun activity for many\.) (100 :out)
  1 (0 camera 0)
    2 (You love looking at pictures from around the world\. This probably wouldn\'t be possible without technology\!) (100 :out)
  1 (0 convenient 0)
    2 (You think it\'s great that people can live more convenient and independent lives\.) (100 :out)
  1 (0 save save 0)
    2 (The free time people have today due to technology can allow them to use their mind for even better tasks\.) (100 :out)
  1 (0 map 0)
    2 (You love to use the map on your phone\. You never get lost using it\.) (100 :out)
  1 (0 no good 0)
    2 (You understand that\. You think I should try to think of the helpful things that technology does for us too though\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (Technology seems to have done a lot to make our lives easier\. Sometimes it\'s hard to adjust\, but you hope I can find it helpful too\.) (100 :out) 
  ))
); end of eval-when
