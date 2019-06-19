(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

    ;; MEETING WITH KIM NOTES (8/8/2017)

    ;; All the stuff we said in the exercise one
    ;; Walking
    ;; Gardening
    ;; Golf
    ;; Walking pet

    (alt-facility JCC YMCA)
    (alt-swimming swimming swim pool)
    (alt-walking walking walk walks hiking hike hikes)
    (alt-running running run runs)
    (alt-pet pet pets pet-dog)
    (pet-dog dog dogs puppy puppies pup mutt mutts hound hounds lab labs labrador
    husky huskies pug pugs beagle beagles poodle poodles bulldog bulldogs terrier
    terriers chihuahua chihuahuas retriever retrievers)

  ))
   

;;	What ways have you found to stay physically active as you get older?
;;	(0 to stay physically active 0)
;;	stay-physically-active
;;	(How would you stay physically active ?)
;;	(3 How 2 stay physically active 3)


(READRULES '*specific-answer-from-stay-physically-active-input*
  '(
  1 (0 alt-walking alt-pet 0)
    2 ((To stay physically active I walk my pet \.) (stay-physically-active)) (0 :gist)
  1 (0 gardening 0)
    2 ((To stay physically active I do gardening \.) (stay-physically-active)) (0 :gist)
  1 (0 golf 0)
    2 ((To stay physically active I do golf \.) (stay-physically-active)) (0 :gist)
  1 (0 yoga 0)
    2 ((To stay physically active I do yoga \.) (exercises-you-do)) (0 :gist)
  1 (0 treadmill 0)
    2 ((To stay physically active I use the treadmill \.) (exercises-you-do)) (0 :gist)
  1 (0 alt-running 0)
    2 ((To stay physically active I go for a run \.) (exercises-you-do)) (0 :gist)
  1 (0 alt-walking 0)
    2 ((To stay physically active I go for a walk \.) (exercises-you-do)) (0 :gist)
  1 (0 alt-swimming 0)
    2 ((To stay physically active I go for a swim \.) (exercises-you-do)) (0 :gist)
  1 (0 water aerobics 0)
    2 ((To stay physically active I go for a swim \.) (exercises-you-do)) (0 :gist)
  1 (0 gym 0)
    2 ((To stay physically active I go to the gym \.) (exercises-you-do)) (0 :gist)
  1 (0 living center 0)
    2 ((To stay physically active I go to an exercise program at a senior living center \.) (exercises-you-do)) (0 :gist)
  1 (0 program 0)
    2 ((To stay physically active I go to a recreation facility \.) (exercises-you-do)) (0 :gist)
  1 (0 silver sneakers 0)
    2 ((To stay physically active I go to Silver Sneakers \.) (exercises-you-do)) (0 :gist)
  1 (0)
    2 ((NIL Gist \: nothing found for how to stay physically active \.) (exercises-you-do)) (0 :gist)
))
            
 (READRULES '*thematic-answer-from-stay-physically-active-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-stay-physically-active-input*
  '(
  
  ))
		
 (READRULES '*question-from-stay-physically-active-input*
  '(
  1 (0 what 2 you 0)
     2 (How would you stay physically active ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (How would you stay physically active ?) (0 :gist)
  ))

(READRULES '*reaction-to-stay-physically-active-input*
  '(
  1 (0 walk my pet 0)
    2 (It\'s good to give my pet exercise as well\. You sometimes wish you had a pet you could walk\.) (100 :out)
  1 (0 do gardening 0)
    2 (You love to walk through pretty gardens\. It sounds like a fun activity to take care of them\.) (100 :out)
  1 (0 do golf 0)
    2 (You are horrible at golf\. You imagine it\'s a fun way to get activity if I am good at it though\.) (100 :out)
  1 (0 do yoga 0)
    2 (You do yoga a lot between work\, it\'s a great way to get the blood moving\.) (100 :out)
  1 (0 use the treadmill 0)
    2 (You wanted a treadmill but it was too expensive\. It\'s a good way to stay in shape though\.) (100 :out)
  1 (0 go for a run 0)
    2 (Going for runs at my age is impressive\. It sounds like I am still quite active\!) (100 :out)
  1 (0 go for a walk 0)
    2 (Sometimes when you have been sitting for too long it\'s very refreshing to go for a walk\.) (100 :out)
  1 (0 go for a swim 0)
    2 (Swimming is a great way to stay cool as well\. It\'s too bad you can\'t swim\.) (100 :out)
  1 (0 go to the gym 0)
    2 (It\'s good to get out of the house to get activity\. Going to the gym is a good way to make friends too\.) (100 :out)
  1 (0 exercise program 2 senior living center 0)
    2 (It sounds very convenient to be offered an exercise program right where I live\. You are jealous\!) (100 :out)
  1 (0 recreation facility 0)
    2 (Recreation facilities can offer a lot of fun opportunities for activity\.) (100 :out)
  1 (0 Silver Sneakers 0)
    2 (You don\'t know much about Silver Sneakers\, but you will look into it\. It\'s good knowledge to have for the future\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (You personally like to find creative new ways to get activity\. It helps you get motivated\.) (100 :out)
  ))
); end of eval-when
