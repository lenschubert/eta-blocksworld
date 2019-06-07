(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; MEETING WITH KIM NOTES (8/4/2017)

  ;; Things are getting worse these days
  ;; Don't like what's happening to country
  ;; Helps them stay engaged
  ;; Something to talk about at dinner
  ;; Brings up a lot of high emotions
  ;; No/not really, they make me/people angry/sad

  (alt-keep keep keeps keeping help helps helping)
  (alt-make make makes making get gets getting cause causes causing)
  (alt-engaged engaged connected)
  (alt-like like enjoy appreciate)
  (alt-dislike dislike hate)
  (alt-debate debate debates argument arguments)
  (alt-learn learn learning educated education knowledge knowledgable aware awareness)
  (alt-happening happening doing)
  (alt-country country America USA)
  (bad-emotion BADSTATE angry anger mad stress stressful stressed upsetting depressing emotional emotions emotion heated)

  ))
   

;; 	Do you like to discuss politics and current events? 
;;	(0 I do not like to discuss politics 0) 
;;	(0 I like to discuss politics 0)
;;	like-politics
;;	(Do you like to discuss politics ?) 
;;	(3 Do you like 2 discuss politics 5) 

	
(READRULES '*specific-answer-from-like-politics-input*
  '(
  1 (0 NEG 3 alt-make 3 bad-emotion 0)
    2 ((I do not like to discuss politics because it makes me upset \.)  (like-politics)) (0 :gist)
  1 (0 NEG 3 it is bad-emotion 0)
    2 ((I do not like to discuss politics because it makes me upset \.)  (like-politics)) (0 :gist)
  1 (0 NEG 3 it brings 5 bad-emotion 0)
    2 ((I do not like to discuss politics because it makes me upset \.)  (like-politics)) (0 :gist)
  1 (0 alt-keep 3 alt-engaged 0)
    2 ((I like to discuss politics because it keeps me engaged \.)  (like-politics)) (0 :gist)
  1 (0 something 2 talk about 0)
    2 ((I like to discuss politics because it keeps me engaged \.)  (like-politics)) (0 :gist)
  1 (0 NEG 1 alt-like 2 alt-debate 0)
    2 ((I do not like to discuss politics because I do not like debates \.)  (like-politics)) (0 :gist)
  1 (0 alt-dislike 2 alt-debate 0)
    2 ((I do not like to discuss politics because I do not like debates \.)  (like-politics)) (0 :gist)
  1 (0 alt-like 2 alt-debate 0)
    2 ((I like to discuss politics because I like debates \.)  (like-politics)) (0 :gist)
  1 (0 alt-keep 2 alt-learn 0)
    2 ((I like to discuss politics because it helps me learn \.)  (like-politics)) (0 :gist)
  1 (0 alt-make 2 worse 0)
    2 ((I do not like to discuss politics because things seem worse these days \.)  (like-politics)) (0 :gist)
  1 (0 NEG 1 alt-like 2 alt-happening 2 alt-country 0)
    2 ((I do not like to discuss politics because things seem worse these days \.)  (like-politics)) (0 :gist)
  1 (0)
       2 ((NIL Gist \: nothing found for if I like to discuss politics \.) (like-politics)) (0 :gist)
))  
       
 (READRULES '*thematic-answer-from-like-politics-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-like-politics-input*
  '(
  
  ))
		
 (READRULES '*question-from-like-politics-input*
  '(
  1 (0 what 2 you 0)
     2 (Do you like to discuss politics ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (Do you like to discuss politics ?) (0 :gist)
  ))

(READRULES '*reaction-to-like-politics-input*
  '( 
  1 (0 NEG like 5 makes me upset 0)
    2 (Politics can be upsetting to discuss sometimes\, however there\'s also a lot of positive things to talk about too\. Try to focus on speading kindness and helping people in need\!) (100 :out)
  1 (0 NEG like to discuss politics 3 NEG like debates 0)
    2 (You think that debates can be stressful sometimes\. You just try to be a good listener and have nice conversations with people rather than angry debates\.) (100 :out)
  1 (0 NEG like to discuss politics 2 things seem worse 0)
    2 (Things might seem worse today in some ways\, however you think there\'s also many things in society which are much better than they used to be\.) (100 :out)
  1 (0 keeps me engaged 0)
    2 (It\'s important to stay engaged with things that are going on in the world and my community\, and seeing how I can help\.) (100 :out)
  1 (0 like debates 0)
    2 (You have fun debating things sometimes\, as long as people don\'t become too angry\.) (100 :out)
  1 (0 helps me learn 0)
    2 (Talking about politics does help me learn things from other perspectives and keep track of what\'s going on in the world\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (You believe it\'s important to keep track of current events\. There\'s a lot of bad things going on\, but you try to be optimistic and positive about the future\.) (100 :out)
  ))
); end of eval-when
