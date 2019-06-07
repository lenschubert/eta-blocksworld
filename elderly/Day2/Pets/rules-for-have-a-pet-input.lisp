(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
  (first-per-pron I we)
  (first-per-pron-pos my our)
  (verb-own have has own owns keep keeps verb-own-past)
  (verb-own-past had owned kept)
  (verb-got got adopted)
  
  (alt-allergies allergies allergic)
  (pet-types pet-cat pet-dog pet-bird pet-fish pet-other pet pets)
  (pet-cat cat cats kitten kittens kitty kitty kitties)
  (pet-dog dog dogs puppy puppies pup mutt mutts hound hounds lab labs labrador
    husky huskies pug pugs beagle beagles poodle poodles bulldog bulldogs terrier
    terriers chihuahua chihuahuas retriever retrievers)
  (pet-bird bird birds parakeet parakeets parrot parrots canary canaries)
  (pet-fish fish goldfish)
  (pet-other bunny bunnies rabbit rabbits gerbil gerbils hamster hamsters guinea lizard lizards snake snakes turtle turtles)
  
   (few a one two three four five six seven eight nine ten eleven)

  ))
   
;; 	Do you have a pet at home ?
;;	(have-a-pet)
;; 	from-have-a-pet-input
;;	(0 I do not have a pet 0)  (0 my pet is 0)
;;		gist question: (2 do 1 have 1 pet 3)
	

(READRULES '*specific-answer-from-have-a-pet-input*
  '(
  1 (0 first-per-pron 1 NEG 1 verb-own 0) ;; I do not have any pets
     2 ((I do not have a pet \.)  (have-a-pet)) (0 :gist)

  1 (0 first-per-pron verb-own 2 robotic pet-types 0) ;; I have a robotic cat
     2 ((My pet is a robotic 6 \.)  (have-a-pet)) (0 :gist)
  1 (0 first-per-pron 2 verb-got 2 robotic pet-types 0) ;; I got a robotic cat
     2 ((My pet is a robotic 7 \.)  (have-a-pet)) (0 :gist)
  1 (0 first-per-pron verb-own 2 pet-types and 2 pet-types 0) ;; I own a dog and two lovely cats
     2 ((My pet is a 5 and 8 \.)  (have-a-pet)) (0 :gist)
  1 (0 first-per-pron 2 verb-got 2 pet-types and 2 pet-types 0) ;; I adopted a dog and a cat
     2 ((My pet is a 6 and 9 \.)  (have-a-pet)) (0 :gist)
  1 (0 first-per-pron verb-own 2 pet-types 0) ;; We have two birds
     2 ((My pet is a 5 \.)  (have-a-pet)) (0 :gist)
  1 (0 first-per-pron 2 verb-got 2 pet-types 0) ;; I went and adopted a small dog
     2 ((My pet is a 6 \.)  (have-a-pet)) (0 :gist)
  1 (0 first-per-pron-pos 1 pet-types 1 died 0) ;; Our poor cat died
     2 ((I do not have a pet because my 4 died \.)  (have-a-pet)) (0 :gist)
  1 (0 first-per-pron verb-own-past 2 pet-types 3 died 0) ;; I had a lovely poodle but unfortunately it died
     2 ((I do not have a pet because my 5 died \.)  (have-a-pet)) (0 :gist)

  1 (0 few 2 robotic pet-types 0) ;; I have a robotic cat
     2 ((My pet is a robotic 5 \.)  (have-a-pet)) (0 :gist)
  1 (0 few 2 robotic pet-types 0) ;; I got a robotic cat
     2 ((My pet is a robotic 5 \.)  (have-a-pet)) (0 :gist)
  1 (0 few 2 pet-types 1 and 1 few 2 pet-types 0) ;; I own a dog and two lovely cats
     2 ((My pet is 2 4 and 8 10 \.)  (have-a-pet)) (0 :gist)
  1 (0 few 2 pet-types 0) ;; We have two birds
     2 ((My pet is 2 4 \.)  (have-a-pet)) (0 :gist)
  1 (0 few 2 pet-types 3 died 0) ;; I had a lovely poodle but unfortunately it died
     2 ((I do not have a pet because my 4 died \.)  (have-a-pet)) (0 :gist)
  
  
  
  1 (0 killed 0) ;; I used to have a cat, but it was killed by a car
     2 ((I do not have a pet because it died \.)  (have-a-pet)) (0 :gist)
  1 (0 put 1 down 0) ;; I used to have a dog, but we had to put it down
     2 ((I do not have a pet because it died \.)  (have-a-pet)) (0 :gist)
  1 (0 NEG 1 allow 1 pets 0) ;; My apartment didn't allow any pets
     2 ((I do not have a pet because where I live does not allow pets \.)  (have-a-pet)) (0 :gist)
  1 (0 NEG 1 allow 1 pet-types 0) ;; My apartment doesn't really allow cats
     2 ((I do not have a pet because where I live does not allow pets \.)  (have-a-pet)) (0 :gist)
  1 (0 NEG 10 alt-allergies 0) ;; No, I would get a cat but I have really bad allergies
     2 ((I do not have a pet because I have allergies \.)  (have-a-pet)) (0 :gist)
  1 (0 first-per-pron 1 verb-own-past 2 pet-types but 0)
     2 ((I do not have a pet but I used to have a 6 \.)  (have-a-pet)) (0 :gist)
  1 (0 first-per-pron 1 used to 3 pet-types but 0)
     2 ((I do not have a pet but I used to have a 7 \.)  (have-a-pet)) (0 :gist)
 

 1 (0 first-per-pron never 2 pets 0) ;; I never wanted any pets
     2 ((I do not have a pet \.)  (have-a-pet)) (0 :gist)
   1 (0 first-per-pron do not 0) ;; I never wanted any pets
     2 ((I do not have a pet \.)  (have-a-pet)) (0 :gist)
  1 (No 1 first-per-pron 0) ;; I never wanted any pets
     2 ((I do not have a pet \.)  (have-a-pet)) (0 :gist)
  1 (0)
       2 ((NIL Gist \: nothing found for what my pet is \.) (have-a-pet)) (0 :gist)
))
       
       
 (READRULES '*thematic-answer-from-have-a-pet-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-have-a-pet-input*
  '(
  1 (0 family-mems verb-own 2 pet-types 0)
     2 ((My family member has a pet 5 \.)  (family-neighbor-pet)) (0 :gist)
  1 (0 family-mems 1 got 2 pet-types 0)
     2 ((My family member has a pet 6 \.)  (family-neighbor-pet)) (0 :gist)
  1 (0 family-mems-possessive 2 pet-types 0)
     2 ((My family member has a pet 4 \.)  (family-neighbor-pet)) (0 :gist)
  1 (0 neighbor-ref verb-own 2 pet-types 0)
     2 ((My neighbor has a pet 5 \.)  (family-neighbor-pet)) (0 :gist)
  1 (0 neighbor-ref 1 got 2 pet-types 0)
     2 ((My neighbor has a pet 6 \.)  (family-neighbor-pet)) (0 :gist)
  1 (0 neighbor\'s 2 pet-types 0)
     2 ((My neighbor has a pet 4 \.)  (family-neighbor-pet)) (0 :gist)
  	))
		
 (READRULES '*question-from-have-a-pet-input*
  '(
  1 (0 do 2 you 0)
     2 (Do you have a pet at home ?) (0 :gist)
  1 (0 what 2 you 0)
     2 (Do you have a pet at home ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (Do you have a pet at home ?) (0 :gist)
  1 (0 your pet 0)
     2 (Do you have a pet at home ?) (0 :gist)
  ))

(READRULES '*reaction-to-have-a-pet-input*
  '(1 (0 robotic pet-types 0)
     2 (Oh\, a robotic pet seems interesting\. Must be a lot easier to take care of too\.) (100 :out)
  1 (0 pet-types and pet-types 0)
     2 (Wow\, I have a lot of pets\. You would like to have many pets one day\.) (100 :out)
  1 (0 pet-types 0)
     2 (0 pet-cat 0)
        3 (You love cats\, they\'re so small and cute\.) (100 :out)
     2 (0 pet-dog 0)
        3 (You are more of a cat person yourself \, but my 2 must be really cute\.) (100 :out)
     2 (0 pet-bird 0)
        3 (Having a pet bird seems really cool\. You think the ones that mimic their owners are funny\.) (100 :out)
     2 (0 pet-fish 0)
        3 (Fish must make a nice pet\. They\'re easy to take care of but fun to watch\.) (100 :out)
     2 (0 pet-other 0)
        3 (That sounds pretty neat\. You don\'t meet many people with that type of pet\.) (100 :out)
  1 (0 do not have 1 pet 3 died 0)
     2 (You are sorry for my loss\. It\'s always sad when a pet dies\.) (100 :out)
  1 (0 do not have 1 pet 5 not allow 0)
     2 (That\'s too bad\. You guess sometimes I have to make sacrifices when moving to a new home\.) (100 :out)
  1 (0 do not have 1 pet 3 allergies 0)
     2 (You understand\. Having allergies can make owning a pet difficult\.) (100 :out)
  1 (0 do not have 1 pet 2 used to 2 pet-types 0)
     2 (My 11 must have been nice while I had them\. It\'s too bad I don\'t anymore\.) (100 :out)
  1 (0 do not have 1 pet 0)
     2 (You understand\. You think having a pet can be difficult sometimes\.) (100 :out)
  1 (0 NIL Gist 0)
     2 (Pets can be nice companions\, though not everyone decides to have them\.) (100 :out)
	))
); end of eval-when

