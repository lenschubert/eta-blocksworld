(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '((niece nieces niece\'s)
    (nephew nephews nephew\'s)
    (occasion christmas thanksgiving easter celebration birthday dinner brunch lunch)
    ))
;; (Have you been to any family gathering recently ?)
;;	(family-gathering)
;;		from-family-gathering-input
;;			 (0 I 3 to 2 wedding 0) (0 I have 1 been to 1 family gathering 0) 
;;			gist-question: (3 have you 2 family gathering 1 recently 0)

 (READRULES '*specific-answer-from-family-gathering-input*
   '(1 (NEG 0 going to 2 wedding 0) 
        2 ((I will go to a wedding soon \.)  (family-gathering)) (0 :gist) 		
     1 (NEG 0 looking forward 2 wedding 0) 
        2 ((I will go to a wedding soon \.)  (family-gathering)) (0 :gist) 	
     1 (NEG 0)	
        2 ((I have not been to a wedding recently \.)  (family-gathering)) (0 :gist)
     1 (1 yes 0)	
        2 ((I have been to a wedding recently \.)  (family-gathering)) (0 :gist)
	 1 (0 nephew 2 wedding 0) 
        2 ((I have been to my nephew\'s wedding recently \.)  (family-gathering)) (0 :gist) 		
     1 (0 niece 2 wedding 0) 
        2 ((I have been to my niece\'s wedding recently \.)  (family-gathering)) (0 :gist) 		
     1 (0 nephew 2 married 0) 
        2 ((I have been to my nephew\'s wedding recently \.)  (family-gathering)) (0 :gist) 		
     1 (0 niece 2 married 0) 
        2 ((I have been to my niece\'s wedding recently \.)  (family-gathering)) (0 :gist) 		
     1 (0 had 4 wedding 0) 
        2 ((I have been to a wedding recently \.)  (family-gathering)) (0 :gist) 		
     1 (0 went 2 wedding 0) 
        2 ((I have been to a wedding recently \.)  (family-gathering)) (0 :gist) 		
     1 (0 going to 2 wedding 0) 
        2 ((I will go to a wedding soon \.)  (family-gathering)) (0 :gist) 		
     1 (0 looking forward 2 wedding 0) 
        2 ((I will go to a wedding soon \.)  (family-gathering)) (0 :gist) 	
     1 (0 occasion 0)
        2 ((I have been to a family gathering recently \.)  (family-gathering))
     1 (0 have not 0) 
        2 ((I have not been to a wedding recently \.)  (family-gathering)) (0 :gist)
      1 (0)
       2 ((NIL Gist \: nothing found for if I have been to a wedding recently \.) (family-gathering)) (0 :gist)
))
       
       
 (READRULES '*thematic-answer-from-family-gathering-input*
    '())

 (READRULES '*unbidden-answer-from-family-gathering-input*
    '())
		
 (READRULES '*question-from-family-gathering-input*
    '(
    1 (0 what 2 you 0)
       2 (Have you been to any family gathering recently ?) (0 :gist)
    1 (0 how 2 you 0)
       2 (Have you been to any family gathering recently ?) (0 :gist)
	  1 (0 have you 3 wedding 0)
       2 (Have you been to any family gathering recently ?) (0 :gist)
    ))

(READRULES '*reaction-to-family-gathering-input*
   '(
   1 (0 NIL Gist 0)
       2 (Getting together with family every now and then is pretty important\.) (100 :out)
    1 (0 have been 2 nephew\'s wedding 0)
       2 (It\'s awesome that I went to a family wedding\! You hope it was a happy event for him\.) (100 :out)
    1 (0 have been 2 niece\'s wedding 0)
       2 (It\'s awesome that I went to a family wedding\! You hope it was a happy event for her\.) (100 :out)
    1 (0 have been 2 wedding 0)
       2 (It\'s awesome that I went to a family wedding\! You hope it was a happy event for the couple\.) (100 :out)
    1 (0 will go 2 wedding 0)
       2 (That sounds exciting\! You hope the wedding goes well\.) (100 :out)
    1 (0 have been 2 family gathering 0)
       2 (It\'s always nice to get together with family on special occasions\.) (100 :out)
    1 (0 have not been 2 wedding 0)
       2 (You hope I can get together with family sometime soon\.) (100 :out)
    ))
); end of eval-when
