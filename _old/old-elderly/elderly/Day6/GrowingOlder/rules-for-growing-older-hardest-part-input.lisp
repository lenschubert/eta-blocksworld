(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; MEETING WITH KIM NOTES (8/4/2017)

  ;; Losing independence
  ;; Relying on my kids
  ;; "Burden"
  ;; Giving up driving
  ;; Vision loss / hearing loss / not being able to see as well / not being able to hear as well
  ;; Give up things they used to be able to do
  ;; Give up taking walks
  ;; Pain
  ;; Arthritis
  ;; Memory / forgetfulness
  ;; Death / loss / losing my husband / losing my wife
  ;; Being a caregiver
  ;; Stopping work
  ;; Living on a fixed income / money
  ;; Having to move out of house / give up home / move to another home

    (illness health ill medication medicine pills)
    (lonely alone loneliness) 
    (depend care)
    (disable deaf blind)
    (vision listening hearing watch listen)
    (worse bad)
    ))
   

;;	What is the hardest part of growing older?
;;	gist: What is the hardest part of growing older ?
;;	(0 hardest part 1 growing older 0)
;;	growing-older-hardest-part
;;	(2 What 2 hardest part 2 growing older 2)

	

(READRULES '*specific-answer-from-growing-older-hardest-part-input*
  '(1 (0 NEG 2 worse 0) 
      2 ((Do not have hardest part for growing older \.) (growing-older-hardest-part)) (0 :gist)
    1 (0 NEG 1 vision 0)
      2 ((The hardest part of growing older is bad 4 \.) (growing-older-hardest-part)) (0 :gist)
    1 (0 vision 1 worse 0)
      2 ((The hardest part of growing older is bad 2 \.) (growing-older-hardest-part)) (0 :gist)
    1 (0 illness 0)
      2 ((The hardest part of growing older is 2 \.) (growing-older-hardest-part)) (0 :gist)
    1 (0 lonely 0)
      2 ((The hardest part of growing older is loneliness \.) (growing-older-hardest-part)) (0 :gist)
    1 (0 depend 0)
      2 ((The hardest part of growing older is needing care \.) (growing-older-hardest-part)) (0 :gist)
    1 (0 disable 0)
      2 ((The hardest part of growing older is getting disable \.) (growing-older-hardest-part)) (0 :gist)
    1 (0)
       2 ((NIL Gist \: nothing found for what the hardest part of growing older is \.) (growing-older-hardest-part)) (0 :gist)
))
       
       
 (READRULES '*thematic-answer-from-growing-older-hardest-part-input*
  '(
  ))

 (READRULES '*unbidden-answer-from-growing-older-hardest-part-input*
  '(
  ))
		
 (READRULES '*question-from-growing-older-hardest-part-input*
  '(
    1 (0 what 4 you 0)
        2 (What is the hardest part when you growing older ?) (0 :gist)
    1 (0 wh_ 4 chore 1 enjoy 0)
        2 (What is the hardest part when you growing older ?) (0 :gist)
  ))

(READRULES '*reaction-to-growing-older-hardest-part-input*
  '( 

  ;; NOTE: These reactions are a bit too specific, some need to be rephrased in case
  ;; LISSA doesn't judge user input correctly.

    1 (0 not have hardest part 0)
      2 (You are happy to hear that I am happy with my life\.) (100 :out)
    1 (0 bad vision 0)
      2 (You are sorry to hear that I have problem with 3 \. Hopefully a doctor might be able to help me with that\.) (100 :out)
    1 (0 illness 0)
      2 (Hopefully exercise helps keep me healthy\, and medicine if I need it \!) (100 :out)
    1 (0 lonely 0)
      2 (Make sure to keep contact with my friends and family if I can\.) (100 :out)
    1 (0 depend 0)
      2 (Being dependent on others sounds a little bit upset\. But you think every one will go through this period\. 
        Just I treat it as a process of nature\.) (100 :out)
    1 (0 disable 0)
      2 (I should explore other interests of our life and do not just focus on the frustrated part\.) (100 :out)
    1 (0 NIL Gist 0)
      2 (You really hope I can get through that part\.) (100 :out)
  ))
); end of eval-when
