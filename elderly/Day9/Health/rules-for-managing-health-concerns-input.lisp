(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; MEETING WITH KIM NOTES (8/8/2017)

  ;; Totally healthy / I don't have any health problems
    ;; Response: "Could you give some examples of what you're doing to stay healthy?"

  ;; Diabetes
  ;; Arthritis
  ;; Depression
  ;; Back pain
  ;; Heart conditions
  ;; Breathing problems
  ;; COPD
  ;; Exercise 
  ;; Physical therapy
  ;; Knee replacements
  ;; Vision loss
  ;; Weight loss
  ;; Sleep
  ;; Parkinsons
  ;; Alzheimers

  ;; It's all too hard / too much
  ;; I'm not managing anything well

  (alt-COPD COPD bronchitis emphysema)

  ))
   

;;	Tell me about how you are managing one of your health concerns. 
;;	(0 I manage my health concerns 0)
;;	managing-health-concerns
;;	(how are you managing your health concerns ?)
;;	(3 how 2 you managing 2 health concerns 3)


	

(READRULES '*specific-answer-from-managing-health-concerns-input*
  '(
  1 (0 diabetes 0)
    2 ((I manage my health concerns by treating my diabetes \.) (managing-health-concerns)) (0 :gist)
  1 (0 arthritis 0)
    2 ((I manage my health concerns by treating my arthritis \.) (managing-health-concerns)) (0 :gist)
  1 (0 depression 0)
    2 ((I manage my health concerns by treating my depression \.) (managing-health-concerns)) (0 :gist)
  1 (0 back pain 0)
    2 ((I manage my health concerns by treating my back pain \.) (managing-health-concerns)) (0 :gist)
  1 (0 heart conditions 0)
    2 ((I manage my health concerns by treating my heart conditions \.) (managing-health-concerns)) (0 :gist)
  1 (0 breathing problems 0)
    2 ((I manage my health concerns by treating my breathing problems \.) (managing-health-concerns)) (0 :gist)
  1 (0 alt-COPD 0)
    2 ((I manage my health concerns by treating my breathing problems \.) (managing-health-concerns)) (0 :gist)
  1 (0 exercise 0)
    2 ((I manage my health concerns by getting exercise \.) (managing-health-concerns)) (0 :gist)
  1 (0 physical therapy 0)
    2 ((I manage my health concerns by getting physical therapy \.) (managing-health-concerns)) (0 :gist)
  1 (0 knee replacements 0)
    2 ((I manage my health concerns by getting knee replacements \.) (managing-health-concerns)) (0 :gist)
  1 (0 vision loss 0)
    2 ((I manage my health concerns by treating my vision loss \.) (managing-health-concerns)) (0 :gist)
  1 (0 weight loss 0)
    2 ((I manage my health concerns by losing weight \.) (managing-health-concerns)) (0 :gist)
  1 (0 sleep 0)
    2 ((I manage my health concerns by getting sleep \.) (managing-health-concerns)) (0 :gist)
  1 (0 parkinsons 0)
    2 ((I manage my health concerns by treating my parkinsons \.) (managing-health-concerns)) (0 :gist)
  1 (0 alzheimers 0)
    2 ((I manage my health concerns by treating my alzheimers \.) (managing-health-concerns)) (0 :gist)
  1 (0 it 2 too hard 0)
    2 ((I manage my health concerns badly \.) (managing-health-concerns)) (0 :gist)
  1 (0 it 2 too much 0)
    2 ((I manage my health concerns badly \.) (managing-health-concerns)) (0 :gist)
  1 (0 NEG managing 0)
    2 ((I manage my health concerns badly \.) (managing-health-concerns)) (0 :gist)
  1 (0)
    2 ((NIL Gist \: nothing found for how I manage my health concerns \.) (managing-health-concerns)) (0 :gist)
))    
       
 (READRULES '*thematic-answer-from-managing-health-concerns-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-managing-health-concerns-input*
  '( 
  
  ))
		
 (READRULES '*question-from-managing-health-concerns-input*
  '(
  1 (0 what 2 you 0)
     2 (how are you managing your health concerns ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (how are you managing your health concerns ?) (0 :gist)
  1 (0 do you 4 problems 0)
     2 (how are you managing your health concerns ?) (0 :gist)
  ))

(READRULES '*reaction-to-managing-health-concerns-input*
  '(
  1 (0 manage my health concerns 3 diabetes 0)
    2 (Diabetes seems like a major annoyance\. You would hate having to monitor the food you eat\. You hope I can continue to manage it well\.) (100 :out)
  1 (0 manage my health concerns 3 arthritis 0)
    2 (Arthritis sounds painful\. You hope I am successful in keeping it from being a major problem\.) (100 :out)
  1 (0 manage my health concerns 3 depression 0)
    2 (You know some people who struggled with depression\. It can be very hard sometimes\. Just remember that there are always people there for me to talk to if I need it\.) (100 :out)
  1 (0 manage my health concerns 3 back pain 0)
    2 (Back pain sounds awful\. You hope I am successful in keeping it from being a major problem\.) (100 :out)
  1 (0 manage my health concerns 3 heart conditions 0)
    2 (It sounds scary to be having heart conditions\. Hopefully I am getting the help I need with that\, and taking good care of myself \.) (100 :out)
  1 (0 manage my health concerns 3 breathing problems 0)
    2 (It sounds scary to be having breathing problems\. Hopefully I am getting the help I need with that\, and taking good care of myself \.) (100 :out)
  1 (0 manage my health concerns 3 exercise 0)
    2 (Getting regular exercise is one of the best ways to avoid common health problems\. It\'s awesome that I am taking care of myself like that\!) (100 :out)
  1 (0 manage my health concerns 3 physical therapy 0)
    2 (Physical therapy is a great way to get controlled exercise\. It can really help with joint problems\.) (100 :out)
  1 (0 manage my health concerns 3 knee replacements 0)
    2 (Getting a knee replacement sounds like an intensive treatment\. But you are sure it helped a lot\!) (100 :out)
  1 (0 manage my health concerns 3 vision loss 0)
    2 (Vision loss sounds like an awful problem\. Hopefully it doesn\'t get too bad and I can get a nice pair of glasses to help\.) (100 :out)
  1 (0 manage my health concerns 3 losing weight 0)
    2 (Maintaining a healthy weight is super important to health\. Hopefully I can continue to manage my weight well\.) (100 :out)
  1 (0 manage my health concerns 3 getting sleep 0)
    2 (Getting enough sleep is super important to feeling good and healthy\. Hopefully I can continue to manage my sleep well\.) (100 :out)
  1 (0 manage my health concerns 3 parkinsons 0)
    2 (It sounds very sad that I am struggling with Parkinson\'s\. You hope I am successful in getting treatment for it\.) (100 :out)
  1 (0 manage my health concerns 3 alzheimers 0)
    2 (It sounds very sad that I am struggling with Alzheimers\'s\. You hope I am successful in getting treatment for it\.) (100 :out)
  1 (0 manage my health concerns badly 0)
    2 (It nearly always helps to talk to a professional about health concerns\. You hope I try to do that\, if I haven\'t already\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (You hope I am successful in managing all my health concerns\. Remember that there\'s always people I can talk to if I need them\.) (100 :out)
  ))
); end of eval-when
