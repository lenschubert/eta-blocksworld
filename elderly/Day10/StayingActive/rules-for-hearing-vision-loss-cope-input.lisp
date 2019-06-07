(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

    ;; MEETING WITH KIM NOTES (8/8/2017)

    ;; Have their glasses
    ;; Not go to noisy environments
    ;; Accepting that it is part of growing older
    ;; Focusing on the positives
    ;; Get several glasses
    ;; Ask other people for help

  (alt-environments environments places venues areas)
  (alt-focus focus focusing looking)
  (alt-positives positives positive good)
  (alt-have have having get getting buy buying)
  (alt-aid aid aids)

  ))
   
;;  What ways have you, or someone close to you, coped with hearing or vision loss? For example some people ask for help or put their glasses in their purse.
;;	(0 to cope with hearing or vision loss 0)
;;	hearing-vision-loss-cope 
;;	(How one can cope with hearing or vision loss ?)
;;	(3 how 2 cope with hearing 2 vision loss 3)

(READRULES '*specific-answer-from-hearing-vision-loss-cope-input*
  '(
  1 (0 alt-have 2 glasses 0)
    2 ((To cope with hearing or vision loss I have my glasses \.) (hearing-vision-loss-cope)) (0 :gist)
  1 (0 hearing 1 alt-aid 0)
    2 ((To cope with hearing or vision loss I have my hearing aids \.) (hearing-vision-loss-cope)) (0 :gist)
  1 (0 NEG 2 noisy alt-environments 0)
    2 ((To cope with hearing or vision loss I avoid noisy environments \.) (hearing-vision-loss-cope)) (0 :gist)
  1 (0 avoid 2 noisy alt-environments 0)
    2 ((To cope with hearing or vision loss I avoid noisy environments \.) (hearing-vision-loss-cope)) (0 :gist)
  1 (0 stay away 2 noisy alt-environments 0)
    2 ((To cope with hearing or vision loss I avoid noisy environments \.) (hearing-vision-loss-cope)) (0 :gist)
  1 (0 accepting 5 growing older 0)
    2 ((To cope with hearing or vision loss I accept that it is part of growing older \.) (hearing-vision-loss-cope)) (0 :gist)
  1 (0 alt-focus 2 alt-positives 0)
    2 ((To cope with hearing or vision loss I focus on the positives \.) (hearing-vision-loss-cope)) (0 :gist)
  1 (0 ask 2 for 1 help 0)
    2 ((To cope with hearing or vision loss I ask for help \.) (hearing-vision-loss-cope)) (0 :gist)
  1 (0 NEG 2 have 2 hearing or vision loss 0)
    2 ((I do not need to cope with hearing or vision loss \.) (hearing-vision-loss-cope)) (0 :gist)
  1 (0 NEG 3 cope 0)
    2 ((To cope with hearing or vision loss I do not do anything \.) (hearing-vision-loss-cope)) (0 :gist)
  1 (0 NEG 2 do anything 0)
    2 ((To cope with hearing or vision loss I do not do anything \.) (hearing-vision-loss-cope)) (0 :gist)
  1 (0)
    2 ((NIL Gist \: nothing found for how to cope with hearing or vision loss \.) (hearing-vision-loss-cope)) (0 :gist)
))
            
 (READRULES '*thematic-answer-from-hearing-vision-loss-cope-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-hearing-vision-loss-cope-input*
  '(
  
  ))
		
 (READRULES '*question-from-hearing-vision-loss-cope-input*
  '(
  1 (0 what 2 you 0)
     2 (How one can cope with hearing or vision loss ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (How one can cope with hearing or vision loss ?) (0 :gist)
  ))

(READRULES '*reaction-to-hearing-vision-loss-cope-input*
  '(
  1 (0 to cope with hearing or vision loss 2 have my glasses 0)
    2 (Glasses are a very easy fix to vision loss\. They can be quite stylish too\!) (100 :out)
  1 (0 to cope with hearing or vision loss 2 have my hearing aids 0)
    2 (It seems like hearing aids can help very much with hearing loss\.) (100 :out)
  1 (0 to cope with hearing or vision loss 2 avoid noisy environments 0)
    2 (You hate noisy environments yourself\, they give you headaches\.) (100 :out)
  1 (0 to cope with hearing or vision loss 2 accept 3 part of growing older 0)
    2 (It\'s true that there are some things that are unavoidable with growing older\. Hopefully I can make the best of it though\.) (100 :out)
  1 (0 to cope with hearing or vision loss 2 focus on the positives 0)
    2 (It\'s always good to focus on the positives of anything that happens\.) (100 :out)
  1 (0 to cope with hearing or vision loss 2 ask for help 0)
    2 (It\'s good that I understand that people are happy to help me if I need it\.) (100 :out)
  1 (0 to cope with hearing or vision loss 2 NEG do anything 0)
    2 (Sometimes coping with changes can be difficult\. If I have problems with hearing or vision loss\, you hope I can find a way to cope successfully\.) (100 :out)
  1 (0 NEG need to cope with hearing or vision loss 0)
    2 (That\'s awesome that I don\'t have any major problems with hearing or vision loss\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (Sometimes coping with changes can be difficult\. If I have problems with hearing or vision loss\, you hope I can find a way to cope successfully\.) (100 :out)
  ))
); end of eval-when
