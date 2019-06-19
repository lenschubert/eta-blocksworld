(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; MEETING WITH KIM NOTES (8/4/2017)

  ;; More likely to read actual newspaper than we are
  ;; Will also watch news

  (time-frequently frequently daily day morning mornings afternoon afternoons evening evenings)
  (time-sometimes sometimes weekly week)
  (time-rarely rarely seldom hardly little scarcely)
  (time-never never)
  (alt-bad bad depressing sad scary)
  (alt-but but however although)
  (alt-internet internet online blog website)

  ))
   
;;  How often do you read the newspaper?  
;;	(0 I do not read newspaper 0) 
;;	(0 I read newspaper 0)
;;	newspaper-how-often
;;	(How often do you read the newspaper ?)  
;;	(3 How often 2 read 2 newspaper 3) 
	

(READRULES '*specific-answer-from-newspaper-how-often-input*
  '(
  1 (0 NEG 1 often 3 alt-but 2 watch 0)
    2 ((I read newspaper rarely but I do watch the news \.)  (newspaper-how-often)) (0 :gist)
  1 (0 NEG 1 often 3 alt-but 2 alt-internet 0)
    2 ((I read newspaper rarely but I do look at news online \.)  (newspaper-how-often)) (0 :gist)
  1 (0 NEG 1 often 8 BADSTATE 0)
    2 ((I read newspaper rarely because of all the bad news \.)  (newspaper-how-often)) (0 :gist)
  1 (0 NEG 1 often 5 alt-bad 1 news 0)
    2 ((I read newspaper rarely because of all the bad news \.)  (newspaper-how-often)) (0 :gist)
  1 (0 time-rarely 3 alt-but 2 watch 0)
    2 ((I read newspaper rarely but I do watch the news \.)  (newspaper-how-often)) (0 :gist)
  1 (0 time-rarely 3 alt-but 2 alt-internet 0)
    2 ((I read newspaper rarely but I do look at news online \.)  (newspaper-how-often)) (0 :gist)
  1 (0 time-rarely 8 BADSTATE 0)
    2 ((I read newspaper rarely because of all the bad news \.)  (newspaper-how-often)) (0 :gist)
  1 (0 time-rarely 5 alt-bad 1 news 0)
    2 ((I read newspaper rarely because of all the bad news \.)  (newspaper-how-often)) (0 :gist)
  1 (0 time-never 3 alt-but 2 watch 0)
    2 ((I do not read newspaper but I do watch the news \.)  (newspaper-how-often)) (0 :gist)
  1 (0 time-never 3 alt-but 2 alt-internet 0)
    2 ((I do not read newspaper but I do look at news online \.)  (newspaper-how-often)) (0 :gist)
  1 (0 time-never 8 BADSTATE 0)
    2 ((I do not read newspaper because of all the bad news \.)  (newspaper-how-often)) (0 :gist)
  1 (0 time-never 5 alt-bad 1 news 0)
    2 ((I do not read newspaper because of all the bad news \.)  (newspaper-how-often)) (0 :gist)
  1 (0 very often 0)
    2 ((I read newspaper frequently \.)  (newspaper-how-often)) (0 :gist)
  1 (0 time-frequently 0)
    2 ((I read newspaper frequently \.)  (newspaper-how-often)) (0 :gist)
  1 (0 time-sometimes 0)
    2 ((I read newspaper sometimes \.)  (newspaper-how-often)) (0 :gist)
  1 (0 NEG 4 often 0)
    2 ((I read newspaper rarely \.)  (newspaper-how-often)) (0 :gist)
  1 (0 time-rarely 0)
    2 ((I read newspaper rarely \.)  (newspaper-how-often)) (0 :gist)
  1 (0 time-never 0)
    2 ((I do not read newspaper \.)  (newspaper-how-often)) (0 :gist)
    1 (0)
    2 ((NIL Gist \: nothing found for how often I read newspaper \.) (newspaper-how-often)) (0 :gist)
))
         
 (READRULES '*thematic-answer-from-newspaper-how-often-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-newspaper-how-often-input*
  '(
  
  ))
		
 (READRULES '*question-from-newspaper-how-often-input*
  '(
  1 (0 what 2 you 0)
     2 (How often do you read the newspaper ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (How often do you read the newspaper ?) (0 :gist)
  ))

(READRULES '*reaction-to-newspaper-how-often-input*
  '(
  1 (0 I read newspaper frequently 0)
    2 (It\'s great that you read the newspaper often\! It\'s important to stay on top of things that are going on in your community and in the world\.) (100 :out)
  1 (0 I read newspaper sometimes 0)
    2 (It\'s good that I still read the newspaper\. It\'s important to stay on top of things that are going on in your community and in the world\.) (100 :out)
  1 (0 I read newspaper rarely 2 do watch 0)
    2 (You don\'t think it matters much whether you read newspaper or watch the news\. The important thing is keeping in touch with things that are happening in the world\.) (100 :out)
  1 (0 I read newspaper rarely 2 do look 2 online 0)
    2 (It\'s great that I am so up to date with modern technology\. There\'s many good news sources online\, though there\'s a lot more bad ones as well\. I just have to be careful\.) (100 :out)
  1 (0 I read newspaper rarely 4 bad news 0)
    2 (The negative things in the news can be too much sometimes\, however there\'s also a lot of good and heartwarming things in the news\.) (100 :out)
  1 (0 I read newspaper rarely 0)
    2 (You think it\'s good to read newspaper sometimes\, or have some other source of news so that you can see what\'s happening in your community and in the world\.) (100 :out)
  1 (0 I do not read newspaper 2 do watch 0)
    2 (You don\'t think it matters much whether you read newspaper or watch the news\. The important thing is keeping in touch with things that are happening in the world\.) (100 :out)
  1 (0 I do not read newspaper 2 do look 2 online 0)
    2 (It\'s great that I am so up to date with modern technology\. There\'s many good news sources online\, though there\'s a lot more bad ones as well\. I just have to be careful\.) (100 :out)
  1 (0 I do not read newspaper 4 bad news 0)
    2 (The negative things in the news can be too much sometimes\, however there\'s also a lot of good and heartwarming things in the news\.) (100 :out)
  1 (0 I do not read newspaper 0)
    2 (You think it\'s good to read newspaper sometimes\, or have some other source of news so that you can see what\'s happening in your community and in the world\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (You think it\'s good to read newspaper sometimes\, or have some other source of news so that you can see what\'s happening in your community and in the world\.) (100 :out)
  ))
); end of eval-when
