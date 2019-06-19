(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; MEETING WITH KIM NOTES (8/4/2017)

  ;; New question prompt: "Tell me about a personal goal you're working on to stay healthy"

  ;; Diet
  ;; Excersize
  ;; Excersizing their brain (crossword puzzle, sodoku, etc.)
  ;; Being around other people
  ;; Going to the gym
  ;; Walking / running
  ;; Silver Sneakers (program to go to YMCA for free)
  ;; Diabetes / blood sugar
  ;; Taking medicine
  ;; Physical therapy

  (alt-diet diet dieting)
  (alt-exercise exercise exercising activity active train training fitness)
  (alt-brain brain mind)
  (alt-learning learning knowledge brain crossword sodoku puzzle chess checkers riddle riddles)
  (alt-being-outside being be going go spending spend appreciate appreciating enjoy enjoying)
  (alt-outside outside outdoors nature)
  (alt-make-friend being be making make finding find talking talk)
  (alt-friend friend friends people connections relationship relationships acquaintances others)
  (alt-taking taking take remember remembering eat eating)
  (alt-pills pills pill medicine meds)
  (alt-weight weight overweight underweight fat obese skinny thin heavy)
  (alt-change change loss gain lose gaining losing increase decrease increased decreased lower higher less more work)

  (exercise-types walk walking run running gym swim swimming yoga)
  (exercise-types-two working out physical therapy silver sneakers)

  ))
   

;;	Tell me about a personal goal you are working on to stay healthy.
;; (0 personal goal I am working on to stay healthy 0)
;; goal-stay-healthy
;; (What is a personal goal you are working on to stay healthy ?)
;; (3 What 2 personal goal 3 working 3 healthy 3)

;; NOTE: Proposed new gist clause: "(0 personal goal I am working on to stay healthy 0)"
;; New tag: goal-stay-healthy

(READRULES '*specific-answer-from-goal-stay-healthy-input*
  '(
  1 (0 alt-diet 0)
    2 ((A personal goal I am working on is to stay healthy is my diet \.) (goal-stay-healthy)) (0 :gist)
  1 (0 alt-exercise 2 alt-brain 0)
    2 ((A personal goal I am working on is to stay healthy is exercising my brain \.) (goal-stay-healthy)) (0 :gist)
  1 (0 alt-learning 0)
    2 ((A personal goal I am working on is to stay healthy is exercising my brain \.) (goal-stay-healthy)) (0 :gist)
  1 (0 exercise-types-two exercise-types-two 0)
    2 ((A personal goal I am working on is to stay healthy is to get more exercise by 2 3 \.) (goal-stay-healthy)) (0 :gist)
  1 (0 exercise-types 0)
    2 ((A personal goal I am working on is to stay healthy is to get more exercise by 2 \.) (goal-stay-healthy)) (0 :gist)
  1 (0 alt-exercise 0)
    2 ((A personal goal I am working on is to stay healthy is to get more exercise \.) (goal-stay-healthy)) (0 :gist)
  1 (0 alt-being-outside 2 alt-outside 0)
    2 ((A personal goal I am working on is to stay healthy is to spend more time outside \.) (goal-stay-healthy)) (0 :gist)
  1 (0 alt-make-friend 2 alt-friend 0)
    2 ((A personal goal I am working on is to stay healthy is to be around other people \.) (goal-stay-healthy)) (0 :gist)
  1 (0 alt-weight 1 alt-change 0)
    2 ((A personal goal I am working on is to stay healthy is to change my weight \.) (goal-stay-healthy)) (0 :gist)
  1 (0 alt-change 2 alt-weight 0)
    2 ((A personal goal I am working on is to stay healthy is to change my weight \.) (goal-stay-healthy)) (0 :gist)
  1 (0 diabetes 0)
    2 ((A personal goal I am working on is to stay healthy is to monitor my blood sugar \.) (goal-stay-healthy)) (0 :gist)
  1 (0 blood sugar 0)
    2 ((A personal goal I am working on is to stay healthy is to monitor my blood sugar \.) (goal-stay-healthy)) (0 :gist)
  1 (0 alt-taking 2 alt-pills 0)
    2 ((A personal goal I am working on is to stay healthy is to remember my medicine \.) (goal-stay-healthy)) (0 :gist)
  1 (0)
       2 ((NIL Gist \: nothing found for a personal goal I am working on to stay healthy \.) (goal-stay-health)) (0 :gist)
 ))  
       
 (READRULES '*thematic-answer-from-goal-stay-healthy-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-goal-stay-healthy-input*
  '(
  
  ))
		
  ;; NOTE: Proposed new question: "What is your personal goal to stay healthy ?"

 (READRULES '*question-from-goal-stay-healthy-input*
  '(
  1 (0 what 2 you 0)
     2 (What is your personal goal to stay healthy ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (What is your personal goal to stay healthy ?) (0 :gist)
  1 (0 do 2 you 2 goal 0)
     2 (What is your personal goal to stay healthy ?) (0 :gist)
  ))

(READRULES '*reaction-to-goal-stay-healthy-input*
  '(
  1 (0 to stay healthy 2 my diet 0)
    2 (Going on a diet is a great way to stay healthy\. It can be very challenging\, but is also very rewarding\.) (100 :out)
  1 (0 stay healthy 2 exercising my brain 0)
    2 (It\'s good to do puzzles\. It helps keep my brain sharp and is fun at the same time\!) (100 :out)
  1 (0 stay healthy 2 get more exercise by exercise-types-two exercise-types-two 0)
    2 (17 18 is a great way to get exercise\. Hopefully it pays off and helps keep me healthy and strong\!) (100 :out)
  1 (0 stay healthy 2 get more exercise by exercise-types 0)
    2 (0 walk 0)
      3 (You think simply going for a walk each day is a great way to get exercise\.) (100 :out)
    2 (0 walking 0)
      3 (You think simply going for a walk each day is a great way to get exercise\.) (100 :out)
    2 (0 run 0)
      3 (Going for a run takes a lot of stamina\! It\'s awesome that I am motivated enough for that type of exercise\.) (100 :out)
    2 (0 running 0)
      3 (Going for a run takes a lot of stamina\! It\'s awesome that I am motivated enough for that type of exercise\.) (100 :out)
    2 (0 swim 0)
      3 (Going for a swim is a great way to get exercise\, it helps me stay cool when it\'s hot outside as well\.) (100 :out)
    2 (0 swimming 0)
      3 (Going for a swim is a great way to get exercise\, it helps me stay cool when it\'s hot outside as well\.) (100 :out)
    2 (0 gym 0)
      3 (The gym is a good place to do exercise and stay healthy\. It\'s also a great spot to make friends\!) (100 :out)
    2 (0 yoga 0)
      3 (Doing yoga can be very relaxing\, but also a great way to stay fit\. It\'s the best of both worlds\!) (100 :out)
  1 (0 stay healthy 2 get more exercise 0)
    2 (It\'s great that you are trying to get exercise\! Regular activity is one of the best ways to stay healthy for a long time\.) (100 :out)
  1 (0 stay healthy 2 spend more time outside 0)
    2 (Spending some time outside every day is important\. You don\'t do it enough\, but when you do it helps relax you for the rest of the day\.) (100 :out)
  1 (0 stay healthy 2 be around other people 0)
    2 (Being around other people is important for my emotional health\. Humans are social creatures\, after all\.) (100 :out)
  1 (0 stay healthy 2 monitor my blood sugar 0)
    2 (Sounds like monitoring blood sugar takes a lot of diligence\. No amount of work is too little for staying healthy\, though\.) (100 :out)
  1 (0 stay healthy 2 remember my medicine 0)
    2 (One good way to remember pills is to have a checklist which I keep next to my keys or some other important item\.) (100 :out)
  1 (0 stay healthy 2 change my weight 0)
    2 (You hope I can achieve the weight that helps you be healthy and feel confident about my body\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (It\'s super important to have some way to stay healthy as I get older\.) (100 :out)
  ))
); end of eval-when
