(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '( (game games cards card scrabble poker)
     (sew sewing knit knitting crochet craft crafts crafting DIY)
     (read reading book)
     (gym workout running treadmill badminton zumba yoga pilates)
     (cook cooking)
     (bake baking)
     (flower flowers arrangement dry pressed)
     (paint painting draw drawing sketch sketching)
     (chat chatting talk talking conversation conversations)
     (TV shows show series movie movies television)
  ))
   
;; What do you enjoy doing when the weather keeps you indoors? 
;; (0 enjoy 3 I have to stay indoors 0)
;; things-enjoy-doing-indoors
;; (2 What 2 enjoy 3 weather keeps you indoors 2) 
	

(READRULES '*specific-answer-from-things-enjoy-doing-indoors-input*
  '( 1 (0 TV shows 0) ;; maybe the gist clause format can be (0 enjoy 3 I have to stay indoors 0)
       2 ((I enjoy watching TV shows when I have to stay indoors \.)  (things-enjoy-doing-indoors)) (0 :gist) 
     1 (0 flower arrangement 0) 
       2 ((I enjoy creating 2 3 when I have to stay indoors \.)  (things-enjoy-doing-indoors)) (0 :gist)
     1 (0 game 0) 
       2 ((I enjoy playing 2 when I have to stay indoors \.)  (things-enjoy-doing-indoors)) (0 :gist)
     1 (0 sewing 0) 
       2 ((I enjoy 2 when I have to stay indoors \.)  (things-enjoy-doing-indoors)) (0 :gist)
     1 (0 reading 0) 
       2 ((I enjoy 2 when I have to stay indoors \.)  (things-enjoy-doing-indoors)) (0 :gist)
     1 (0 gym 0) 
       2 ((I enjoy 2 when I have to stay indoors \.)  (things-enjoy-doing-indoors)) (0 :gist)
     1 (0 cooking 0) 
       2 ((I enjoy 2 when I have to stay indoors \.)  (things-enjoy-doing-indoors)) (0 :gist)
     1 (0 baking 0) 
       2 ((I enjoy 2 when I have to stay indoors \.)  (things-enjoy-doing-indoors)) (0 :gist)
     1 (0 painting 0) 
       2 ((I enjoy 2 when I have to stay indoors \.)  (things-enjoy-doing-indoors)) (0 :gist)
     1 (0 chatting 0) 
       2 ((I enjoy 2 when I have to stay indoors \.)  (things-enjoy-doing-indoors)) (0 :gist)
     1 (0 TV 0) 
       2 ((I enjoy watching 2 when I have to stay indoors \.)  (things-enjoy-doing-indoors)) (0 :gist)
     1 (0)
       2 ((NIL Gist \: nothing found for what I enjoy doing if I have to stay indoors \.) (things-enjoy-doing-indoors)) (0 :gist)
))
       
       
 (READRULES '*thematic-answer-from-things-enjoy-doing-indoors-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-things-enjoy-doing-indoors-input*
  '(
  ))
		
 (READRULES '*question-from-things-enjoy-doing-indoors-input*
  '(
    1 (0 what 2 you 0)
      2 (What do you enjoy when the weather keeps you indoors ?) (0 :gist)
    1 (0 how 2 you 0)
      2 (What do you enjoy when the weather keeps you indoors ?) (0 :gist)
    1 (2 what 2 enjoy 3 weather keeps you indoors 2)
      2 (What do you enjoy when the weather keeps you indoors ?) (0 :gist)
  ))

(READRULES '*reaction-to-things-enjoy-doing-indoors-input*
  '( 1 (0 TV shows 0)
       2 (You also have watched some movies and TV shows\. You like watching shows related to crimes and psycho\.) (100 :out)
     1 (0 flower arrangement 0)
       2 (Sounds really cool that I are making crafts out of flower\.) (100 :out)
     1 (0 game 0)
       2 (You play a lot of board games with your friends\. Texas Holdem is one of the fun games\.) (100 :out)
     1 (0 sewing 0)
       2 (It feels great to create crafts out of crude materials\!) (100 :out)
     1 (0 reading 0)
       2 (You read books when you are alone\. You read mostly nonfictions\, but you also love sci-fi and detective fiction\.) (100 :out)
     1 (0 gym 0)
       2 (0 yoga 0)
         3 (Yoga is good for your health and convenient to practice\.) (100 :out)
       2 (0 treadmill 0)
         3 (Running in the treadmill is different from running on the ground\, but it is still fun\.) (100 :out)
       2 (0)
         3 (It is nice to find other alternatives to keep exercising indoor even though the weather is bad\.) (100 :out)
     1 (0 cooking 0)
       2 (You used to cook for your grandchildren\.) (100 :out)
     1 (0 baking 0)
       2 (You know some basic baking recipes\, but others are too complicated\.) (100 :out)
     1 (0 painting 0)
       2 (Painting is a nice way to relax and examine closely your emotions\.) (100 :out)
     1 (0 chatting 0)
       2 (It is surprising how sometimes people can learn so many things from chatting\. Language is an amazing invention\.) (100 :out)
     1 (0 TV 0)
       2 (You also have watched some movies and shows\. You like watching videos related to crimes and psycho\.) (100 :out)
	 1 (0 NIL Gist 0)
	   2 (That makes sense\.) (100 :out)
  ))
); end of eval-when
