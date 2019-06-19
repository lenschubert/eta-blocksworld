(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '((yes yeah)
    (social-networks facebook skype facetime) ;; here
    (social-networks-relevant account profile page skyping other-communication)
    (other-communication email mail mailing text phone)
    (skype skyping skyped)
    (email emailing)
    (text texting)
    (phone call telephone)
	  (use used)  ;here
   ))
;;	(Do you use facebook or skype ?)
;;	(use-facebook)
;;		from-use-facebook-input
;;			(0 I do not use social-networks 0) (0 I use social-networks 0)
;;			gist-question: (3 do you 1 facebook 0)

 (READRULES '*specific-answer-from-use-facebook-input*
   '(
     1 (0 I do social-networks 0)
        2 ((I use 4 \.) (use-facebook)) (0 :gist)
    1 (0 I also 1 social-networks 0)
        2 ((I use 5 \.) (use-facebook)) (0 :gist)
    1 (2 yes 3 social-networks 0)
       2 ((I use 4 \.)  (use-facebook)) (0 :gist)
    1 (1 definitely 0)
       2 ((I use social-networks \.)  (use-facebook)) (0 :gist)
    1 (3 NEG 1 use 0) 
      2 ((I do not use social-networks \.)  (use-facebook)) (0 :gist)
    1 (1 Not really 0) 
      2 ((I do not use social-networks \.)  (use-facebook)) (0 :gist)
    1 (0 NEG 3 fan of 0) 
      2 ((I do not use social-networks \.)  (use-facebook)) (0 :gist)
    1 (1 I do not 1 social-networks 0)
       2 ((I do not use 6 \.)  (use-facebook)) (0 :gist)
    1 (0 I do 1 social-networks 0)
       2 ((I use 5 \.)  (use-facebook)) (0 :gist)
    1 (0 I do have 1 social-networks 0)   ;; here : I do have a facebook account
       2 ((I use 6 \.)  (use-facebook)) (0 :gist)
    1 (0 I social-networks 0)  ;; here: I skype quite a bit with the three year old
       2 ((I use 3 \.)  (use-facebook)) (0 :gist)
    1 (0 I have 1 social-networks 0)
       2 ((I use 5 \.)  (use-facebook)) (0 :gist)
    1 (0 I use 2 social-networks 0)
       2 ((I use 5 \.)  (use-facebook)) (0 :gist)
    1 (0 I am on 1 social-networks 0)
       2 ((I use 6 \.)  (use-facebook)) (0 :gist)
    1 (1 I 1 have 1 social-networks-relevant 0)
       2 ((I use social-networks \.)  (use-facebook)) (0 :gist)
    1 (1 I 1 use 1 social-networks-relevant 0)
       2 ((I use social-networks \.)  (use-facebook)) (0 :gist)
    1 (1 I 1 send 1 social-networks-relevant 0)
       2 ((I use social-networks \.)  (use-facebook)) (0 :gist)
    1 (1 I social-networks-relevant 0)
       2 ((I use social-networks \.)  (use-facebook)) (0 :gist)
    1 (0 I do not 1 post 0)
       2 ((I do not post on facebook \.) (use-facebook)) (0 :gist)
  1 (I do not 0)
       2 ((I do not use social-networks \.) (use-facebook)) (0 :gist) 
   1 (No 0)
       2 ((I do not use social-networks \.) (use-facebook)) (0 :gist)   
   1 (yes 0)
       2 ((I use social-networks \.) (use-facebook)) (0 :gist) 
    1 (0)
       2 ((NIL Gist \: nothing found for if I use social-networks \.) (use-facebook)) (0 :gist)
))
       
 (READRULES '*thematic-answer-from-use-facebook-input*
    '())

 (READRULES '*unbidden-answer-from-use-facebook-input*
    '(
      ; Should I add something about email here, e.g. "I do not use facebook, but
      ; I do use email to keep in touch" ?
	  
	  ;; Yes, that's a good idea
	  ;; also some people mentioned that they have facebook account
	  ;; but they don't post anything on it (they only use it to see pictures of their grands)
	  ;; something like "I do not post on facebook" can be a bidden answer

	  1 (0 I do 1 other-communication 0)
       2 ((I use 5 \.)  (use-facebook)) (0 :gist)
    1 (0 I do have 1 other-communication 0)
       2 ((I use 6 \.)  (use-facebook)) (0 :gist)
    1 (0 I other-communication 0)
       2 ((I use 3 \.)  (use-facebook)) (0 :gist)
    1 (0 I have 1 other-communication 0)
       2 ((I use 5 \.)  (use-facebook)) (0 :gist)
    1 (0 I use 2 other-communication 0)
       2 ((I use 5 \.)  (use-facebook)) (0 :gist)
    1 (0 I do not 1 post 0)
       2 ((I do not post on facebook \.) (use-facebook)) (0 :gist)
   ))
		
 (READRULES '*question-from-use-facebook-input*
    '(
    1 (0 what 2 you 0)
       2 (do you use facebook or skype ?) (0 :gist) ;; here: it is a good idea to use the  
													;; exact wording of the gist of LISSA question 
													;; for user's reciprocal questions (mostly because of consistency)
    1 (0 how 2 you 0)								;; (the gist has been provided above- the first line of comments )
       2 (do you use facebook or skype ?) (0 :gist)
	  1 (0 do you 2 facebook 0)
       2 (do you use facebook or skype ?) (0 :gist)
    ))


(READRULES '*reaction-to-use-facebook-input*
   '(
    1 (0 NEG 1 use social-networks 0)
      2 (0 facebook 0)
       3 (You never made a facebook account\, none of your friends are on it\.) (100 :out)     
      2 (0 skype 0)
       3 (Your daughter set up skype on your phone last year\. It is a great way to communicate\. Now\, you get to see her while you are talking to her\.) (100 :out)
      2 (0 facetime 0)
         3 (You haven't used facetime that much\. You prefer to just call people\.) (100 :out)
    1 (0 I use social-networks 0)
       2 (0 facebook 0)
         3 (You don\'t have a facebook account\, but it might be a good idea to make one\, to keep in touch with friends\.) (100 :out)
       2 (0 skype 0)
         3 (Your daughter set up skype on your phone last year\. It is a great way to communicate\. Now you get to see her while you are talking to her\.) (100 :out)
       2 (0 facetime 0)
         3 (You haven't used facetime that much\. You prefer to just call people\.) (100 :out)
    1 (0 I use social-networks-relevant 0)
       2 (0 other-communication 0)
         3 (0 email 0)
             4 (You used to use your email much more before\. You find it hard to type recently\.) (100 :out)
         3 (0 text 0)
             4 (Texting is hard for you \. It takes too much\. You prefer just to call people\.) (100 :out)
         3 (0 phone 0)
             4 (You still like to call people although your daughters prefer skype \.) (100 :out)
       2 (0)
         3 (That\'s nice\. You have a facebook account\, it makes it easier to communicate with friends\.) (100 :out)
       
    1 (0 NIL Gist 0)
      2 (You don\'t have a facebook account\, but it might be a good idea to make one to stay in touch with friends\.) (100 :out)
	))
); end of eval-when
