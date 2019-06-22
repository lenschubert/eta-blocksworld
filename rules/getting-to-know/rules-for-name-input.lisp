(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
 (american-names american-male-names american-female-names)
 ))
 
;; (what did you have for breakfast ?)
;; (name)
;; from-name-input
;; (0 my name is 0) 
;;     gist-question: (2 what is your name 1)


 (READRULES '*specific-answer-from-name-input*
  '(
  1 (0 american-names american-family-names 0)
     2 ((My name is 2 3 \.)  (name)) (0 :gist)
  1 (0 american-names 0)
     2 ((My name is 2 \.)  (name)) (0 :gist)
  1 (0)
     2 ((ETA could not understand what my name is \.)  (name)) (0 :gist)
  ))
       
       
 (READRULES '*thematic-answer-from-name-input*
    '())

 (READRULES '*unbidden-answer-from-name-input*
    '())
		
 (READRULES '*question-from-name-input*
    '(
    1 (0 what 2 you 0)
       2 (What is your name ?) (0 :gist)
    1 (0 how 2 you 0)
       2 (What is your name ?) (0 :gist)
    1 (0 wh_ 1 your name 0)
       2 (What is your name ?) (0 :gist)
    ))

(READRULES '*reaction-to-name-input*
  '(
    1 (0 my name is american-names 0)
      2 (It is very nice to meet me 5 \. You hope we have many great interactions in the future\.) (100 :out)
    1 (0)
      2 (It is very nice to meet me \. You hope we have many great interactions in the future\.) (100 :out)
  ))
); end of eval-when
