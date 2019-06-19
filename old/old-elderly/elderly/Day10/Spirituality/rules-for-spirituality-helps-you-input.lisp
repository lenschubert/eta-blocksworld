(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

    ;; MEETING WITH KIM NOTES (8/8/2017)

    ;; Own death
    ;; Someone’s loss
    ;; Grief
    ;; Comfort
    ;; Other people’s support
    ;; Things happen for reason
    ;; Not alone
    ;; Feeling connected with nature

    (alt-cope cope coping deal dealing accept accepting)
    (alt-people people people\'s person friend friends someone alt-family)
    (alt-family family children grandchildren child grandchild son daughter grandson granddaughter niece nephew)
    (alt-comfort comfort comfortable consolation solace happy happiness happier
      joy content contentment contented)

  ))
   

;;	How does spirituality help you when life gets hard? 
;;	(0 spirituality helps me 0)
;;	spirituality-helps-you
;;	(How does spirituality help you ?)
;;	(3 How does spirituality help you 3 )


	

(READRULES '*specific-answer-from-spirituality-helps-you-input*
  '(
  1 (0 alt-cope 3 own death 0)
    2 ((Spirituality helps me cope with my own death \.) (spirituality-helps-you)) (0 :gist)
  1 (0 come 1 terms 3 own death 0)
    2 ((Spirituality helps me cope with my own death \.) (spirituality-helps-you)) (0 :gist)
  1 (0 loss of 2 alt-people 0)
    2 ((Spirituality helps me cope with the loss of someone \.) (spirituality-helps-you)) (0 :gist)
  1 (0 death of 2 alt-people 0)
    2 ((Spirituality helps me cope with the loss of someone \.) (spirituality-helps-you)) (0 :gist)
  1 (0 grief 0)
    2 ((Spirituality helps me deal with grief \.) (spirituality-helps-you)) (0 :gist)
  1 (0 alt-comfort 0)
    2 ((Spirituality helps me feel more comfortable \.) (spirituality-helps-you)) (0 :gist)
  1 (0 other 1 alt-people 1 support 0)
    2 ((Spirituality helps me through the support of other people \.) (spirituality-helps-you)) (0 :gist)
  1 (0 things happen 3 reason 0)
    2 ((Spirituality helps me realize things happen for a reason \.) (spirituality-helps-you)) (0 :gist)
  1 (0 NEG 1 alone 0)
    2 ((Spirituality helps me realize I am not alone \.) (spirituality-helps-you)) (0 :gist)
  1 (0 connected 2 nature 0)
    2 ((Spirituality helps me be connected with nature \.) (spirituality-helps-you)) (0 :gist)
  1 (0)
    2 ((NIL Gist \: nothing found for how spirituality helps me \.) (spirituality-helps-you)) (0 :gist)
))
            
 (READRULES '*thematic-answer-from-spirituality-helps-you-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-spirituality-helps-you-input*
  '(
  
  ))
		
 (READRULES '*question-from-spirituality-helps-you-input*
  '(
  1 (0 what religion 2 you 0)
     2 (Are you religious ?) (0 :gist)
  1 (0 are 2 you 2 religious 0)
     2 (Are you religious ?) (0 :gist)
  1 (0 do 2 you 2 follow 0)
     2 (Are you religious ?) (0 :gist)
  1 (0 are 2 you 2 spiritual 0)
     2 (Are you religious ?) (0 :gist)
  1 (0 what 2 you 0)
     2 (How does spirituality help you ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (How does spirituality help you ?) (0 :gist)
  1 
  ))

(READRULES '*reaction-to-spirituality-helps-you-input*
  '(
  1 (0 spirituality helps me cope with my own death 0)
    2 (You can see how spirituality would help me cope with death\. For example\, knowing that even though my body may die\, my essence lives on\.) (100 :out)
  1 (0 spirituality helps me cope with the loss of someone 0)
    2 (It makes sense that spirituality would help me cope with the loss of someone close\. It helps me know they\'re in a better place\.) (100 :out)
  1 (0 spirituality helps me deal with grief 0)
    2 (Sometimes when I am grieving\, spirituality is one place I can turn to in order to feel better\.) (100 :out)
  1 (0 spirituality helps me feel more comfortable 0)
    2 (Spirituality can definitely help me feel more comfortable with my purpose in life\.) (100 :out)
  1 (0 spirituality helps me through the support of other people 0)
    2 (It\'s very nice how religion or spirituality help connect me to other supportive people\.) (100 :out)
  1 (0 spirituality helps me realize things happen for a reason 0)
    2 (You think it\'s important to understand how everything in life is connected\.) (100 :out)
  1 (0 spirituality helps me realize I am not alone 0)
    2 (It\'s good to realize that whenever I am in a bad place\, there are people out there who care about me \.) (100 :out)
  1 (0 spirituality helps me be connected with nature 0)
    2 (You think it\'s important to realize the importance of living with nature\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (Personally\, spirituality helps you feel like you have some sense of purpose in the world\.) (100 :out)
  ))
); end of eval-when
