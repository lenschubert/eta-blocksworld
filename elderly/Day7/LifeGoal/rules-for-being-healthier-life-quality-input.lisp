(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; MEETING WITH KIM NOTES (8/4/2017)

  ;; New question prompt: "How can being healthier improve your life quality?"

  ;; Feel better about myself / happier
  ;; Feel more confident / gives me more confidence
  ;; Self esteem
  ;; Get my doctor off my back
  ;; Get my husband/wife/kids off my back
  ;; Do things I like to do (taking walks, exercise)
  ;; Helping memory
  ;; Staying independent longer / not going to nursing home
  ;; Living longer
  ;; Not having a stroke
  ;; Not needing surgery
  ;; Not needing to take medicine / as much medicine
  ;; Keeping blood sugar stable

  (alt-feel feel feeling think thinking be being make makes making get getting give gives giving)
  (alt-better GOODPROP happier happiness confident confidence)
  (alt-person alt-friend alt-doctor husband wife kid kids child children son sons daughter daughters)
  (alt-stop stop stopping quit)
  (alt-nagging nagging nag pestering pester bothering bother hassle hassling badger badgering hound hounding harass harassing)
  (alt-activities activities activity exersize things stuff)
  (alt-like like enjoy fun love)
  (alt-improve improve improving help helping benefit benefitting enhance enhancing polish polishing)
  (alt-memory memory memorization remember remembering mind mental)
  (alt-staying staying stay remaining remain keeping keep being be)
  (alt-nursing-home nursing home assisted living retirement facility elderly)
  (alt-living living live alive survive)
  (alt-having having have needing need getting get)
  (alt-medical-issue stroke failure heart liver kidney diabetes imbalance surgery treatment treatments medicine pill pills)

  ))
   
;;  What makes this goal important to you? How can it improve your life quality?
;; (0 being healthier improves my life quality 0)
;; being-healthier-life-quality
;; (How can being healthier improve your life quality ?)
;; (3 how 2 being healthier 2 improve your life quality 4)
	
;; NOTE: Proposed new gist clause: "(0 being healthier improves my life quality by 0)"
;; New tag: being-healthier-life-quality

(READRULES '*specific-answer-from-being-healthier-life-quality-input*
  '(
  1 (0 alt-feel 2 alt-better 0)
    2 ((Being healthier improves my life quality by making me feel happier about myself \.) (being-healthier-life-quality)) (0 :gist)
  1 (0 self 1 esteem 0)
    2 ((Being healthier improves my life quality by making me feel happier about myself \.) (being-healthier-life-quality)) (0 :gist)
  1 (0 alt-stop 1 alt-person 2 alt-nagging 0)
    2 ((Being healthier improves my life quality by getting people to stop nagging \.) (being-healthier-life-quality)) (0 :gist)
  1 (0 alt-person 1 alt-stop 2 alt-nagging 0)
    2 ((Being healthier improves my life quality by getting people to stop nagging \.) (being-healthier-life-quality)) (0 :gist)
  1 (0 alt-person 2 off 2 back 0)
    2 ((Being healthier improves my life quality by getting people to stop nagging \.) (being-healthier-life-quality)) (0 :gist)
  1 (0 alt-person 2 leave 2 alone 0)
    2 ((Being healthier improves my life quality by getting people to stop nagging \.) (being-healthier-life-quality)) (0 :gist)
  1 (0 do 2 alt-activities 3 alt-like 0)
    2 ((Being healthier improves my life quality by letting me do activities I like \.) (being-healthier-life-quality)) (0 :gist)
  1 (0 alt-improve 2 alt-memory 0)
    2 ((Being healthier improves my life quality by helping my memory \.) (being-healthier-life-quality)) (0 :gist)
  1 (0 alt-staying 2 independent 0)
    2 ((Being healthier improves my life quality by letting me stay independent longer \.) (being-healthier-life-quality)) (0 :gist)
  1 (0 NEG 3 alt-nursing-home alt-nursing-home 0)
    2 ((Being healthier improves my life quality by letting me stay independent longer \.) (being-healthier-life-quality)) (0 :gist)
  1 (0 alt-living 2 longer 0)
    2 ((Being healthier improves my life quality by letting me live longer \.) (being-healthier-life-quality)) (0 :gist)
  1 (0 NEG alt-having 3 alt-medical-issue 0)
    2 ((Being healthier improves my life quality by preventing medical issues \.) (being-healthier-life-quality)) (0 :gist)
  1 (0 alt-improve 2 blood sugar 0)
    2 ((Being healthier improves my life quality by preventing medical issues \.) (being-healthier-life-quality)) (0 :gist)
  1 (0 alt-staying 2 blood sugar 0)
    2 ((Being healthier improves my life quality by preventing medical issues \.) (being-healthier-life-quality)) (0 :gist)
   1 (0)
       2 ((NIL Gist \: nothing found for how being healthier improves my life quality \.) (being-healthier-life-quality)) (0 :gist)
))  
       
 (READRULES '*thematic-answer-from-being-healthier-life-quality-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-being-healthier-life-quality-input*
  '( 
  
  ))

  ;; NOTE: Proposed new question: "How can being healthier improve your life quality ?"
		
 (READRULES '*question-from-being-healthier-life-quality-input*
  '(
  1 (0 what 2 you 0)
     2 (How can being healthier improve your life quality ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (How can being healthier improve your life quality ?) (0 :gist)
  ))

(READRULES '*reaction-to-being-healthier-life-quality-input*
  '(
  1 (0 making me feel happier about myself 0)
    2 (Though I should always try to have high self esteem\, it\'s especially easy when I know I am healthy\.) (100 :out)
  1 (0 getting people to stop nagging 0)
    2 (You are sure nagging can be annoying\. It must be nice to get people off my back\.) (100 :out)
  1 (0 letting me do activities I like 0)
    2 (Being healthier can be very freeing sometimes\, because it lets me do activities I couldn\'t do before\.) (100 :out)
  1 (0 helping my memory 0)
    2 (It must feel great to have a fresh memory compared to before\.) (100 :out)
  1 (0 letting me stay independent longer 0)
    2 (You are sure it must be great to be independent as long as possible\.) (100 :out)
  1 (0 letting me live longer 0)
    2 (Living a healthy lifestyle is definitely the key to living a long time\. You hope you are able to live that long when you get older\.) (100 :out)
  1 (0 preventing medical issues 0)
    2 (Living with the threat of medical issues can be scary sometimes\. You are sure it\'s nice to get those fears off my back by being healthier\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (Being healthier can feel like a breath of fresh air in many ways\. You hope I can stay healthy as me get older\.) (100 :out)
  ))
); end of eval-when
