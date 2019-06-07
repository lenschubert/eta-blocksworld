(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
  (family-mems son daughter grandchild grandchildren grandson granddaughter niece nephew
    cousin relative child children)
  (family-mems-possessive son\'s daughter\'s grandchild\'s grandchildren\'s grandson\'s granddaughter\'s niece\'s nephew\'s
    cousin\'s relative\'s child\'s children\'s)
  (neighbor-ref neighbor neighbors)
  (had has)
  (noise noises sound bark barks barking)
  (bark barks barking)
  ))
   
;; 	Tell me about a pet of a family member or neighbor
;;	family-neighbor-pet
;;	(0 my family member has 0) (0 my neighbor has 0)
;;		gist question: (1 Tell me about 2 pet 3 family 2 neighbor 3) 

	
(READRULES '*specific-answer-from-family-neighbor-pet-input*
  '(
  1 (0 family-mems verb-own 2 pet-types 0)
     2 ((My family member has a 5 \.)  (family-neighbor-pet)) (0 :gist)
  1 (0 family-mems 1 got 2 pet-types 0)
     2 ((My family member has a 6 \.)  (family-neighbor-pet)) (0 :gist)
  1 (0 family-mems-possessive 2 pet-types 0)
     2 ((My family member has a 4 \.)  (family-neighbor-pet)) (0 :gist)
  1 (0 neighbor-ref verb-own 2 pet-types 0)
     2 ((My neighbor has a 5 \.)  (family-neighbor-pet)) (0 :gist)
  1 (0 neighbor-ref 1 got 2 pet-types 0)
     2 ((My neighbor has 6 \.)  (family-neighbor-pet)) (0 :gist)
  1 (0 neighbor\'s 2 pet-types 0)
     2 ((My neighbor has 4 \.)  (family-neighbor-pet)) (0 :gist)
 ; 1 (0 pet-types 0)
  ;   2 ((My family or my neighbor has a pet 2 \.)  (family-neighbor-pet)) (0 :gist)

     ;; NOTE 1: Needs gist clauses for "I'm not sure about my family member/neighbor's pets"
     ;; or "My family member/neighbors don't have pets"

  1 (0 pet-types 1 died 0) ;
     2 ((My family member or my neighbor had a 2 but it died \.)  (have-a-pet)) (0 :gist)
  1 (0 killed 0) ;
     2 ((My family member or my neighbor had a pet but it died \.)  (have-a-pet)) (0 :gist)
  1 (0 put 1 down 0) ;; 
     2 ((My family member or my neighbor had a pet but it died \.)  (have-a-pet)) (0 :gist)
  1 (0 neighbor 3 pet-types 5 NEG clean 2 after 0) 
     2 ((My neighbor has a 2 and they do not clean up after it \.)  (have-a-pet)) (0 :gist)
  1 (0 neighbor 3 pet-types 5 bark 0) 
     2 ((My neighbor has a 2 and it barks a lot \.)  (have-a-pet)) (0 :gist)
  1 (0 neighbor 3 pet-types 5 noise 0) 
     2 ((My neighbor has a 2 and it makes a lot of noise \.)  (have-a-pet)) (0 :gist)
  1 (0 neighbor 3 pet-types 5 annoying 0) 
     2 ((My neighbor has a 2 and it is very annoying \.)  (have-a-pet)) (0 :gist)
  1 (0)
       2 ((NIL Gist \: nothing found for what pet my neighbor has \.) (have-a-pet)) (0 :gist)
	
  ))
       
       
 (READRULES '*thematic-answer-from-family-neighbor-pet-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-family-neighbor-pet-input*
  '(

  ))
		
 (READRULES '*question-from-family-neighbor-pet-input*
  '(
  1 (0 what 2 you 0)
     2 (Tell me about a pet of a family member or neighbor) (0 :gist)
  1 (0 how 2 you 0)
     2 (Tell me about a pet of a family member or neighbor) (0 :gist)
  ))

(READRULES '*reaction-to-family-neighbor-pet-input*
  '( 
   1 (0 NIL Gist 0)
     2 (You prefer your neighbors to not have pets because they can be loud\, but they can also be cute too\.) (100 :out)

  1 (0 family member has 2 pet-types 0)
     2 (0 pet-cat 0)
        3 (It must be nice to be able to pet their cat when I visit\.) (100 :out)
     2 (0 pet-dog 0)
        3 (It must be nice to be able to pet their dog when I visit\.) (100 :out)
     2 (0 pet-bird 0)
        3 (That\'s cool\, it must be fun to look at their bird when I visit\.) (100 :out)
     2 (0 pet-fish 0)
        3 (That\'s cool\, it must be fun to look at their fish when I visit\.) (100 :out)
     2 (0 pet-other 0)
        3 (That\'s cool\, it must be fun to look at their pet when I visit\.) (100 :out)
	 2 (That\'s cool\, it must be fun to look at their pet when I visit\.) (100 :out)
  1 (0 neighbor has 2 pet-types 0)
     2 (0 died 0)
	   3 (It is always sad when a pet dies\. Especially if I have spent a lot of time with it\.)
     2 (0 pet-cat 0)
        3 (Interesting\. You believe cats are the best pets\! They are easy to keep and just cute \.) (100 :out)
     2 (0 pet-dog 0)
        3 (Interesting\. You love dogs\. They are loyal and funny \. Though a little bit hard to be taken care of\.) (100 :out)
     2 (0 pet-bird 0)
        3 (Interesting\. Your sister used to have two birds as her pet\. She was very happy with them\. You have never had a bird though\.) (100 :out)
     2 (0 pet-fish 0)
        3 (Interesting\. Your sister used to have some beautiful fishes as her pet\. She was very happy with them\. You haven\'t had a fish though\.\.) (100 :out)
     2 (0 pet-other 0)
        3 (Interesting\. Most of people just like to have a cat or a dog\. It would be a nice experience to have other types of pets \.) (100 :out)
     2 (0 bark 0)
	    3 (The constant noise of a barking dog can be extremely annoying\. Their owner should definitely fix it\. ) (100 :out)
	 2 (0 noise 0)
	    3 (Some pets make extremely annoying noises\. Their owner should definitely fix it\.) (100 :out)
	 2 (0 annoying 0)
	    3 (Some pets are really troublesome for the neighbors\. The owners are responsible to take care of that\. ) (100 :out)
	 2 (0 clean up 0)
	    3 (Anyone who has a pet should be responsible to clean up after their pets\. It would be extremely annoying if they don\'t \.) (100 :out)
	 2 (Pets in neighborhood are cool\, as long as the owner takes care of them well\.) (100 :out)
  ))
); end of eval-when
