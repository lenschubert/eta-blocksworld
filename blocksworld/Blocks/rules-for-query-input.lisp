(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '()
  )
;; (what are your query ?)
;;	(query)
;;		from-query-input
;;			(0 my hobby is 0) (0 do not like 2 hobby 0)
;;			gist-question:(3 what are 1 query 0)

 (READRULES '*specific-answer-from-query-input*
   '(1 (0)
      2 ((My query is 0) (query)) (0 :gist)
       
  		

	))
       
       
 (READRULES '*thematic-answer-from-query-input*
    '())

 (READRULES '*unbidden-answer-from-query-input*
    '())
		
 (READRULES '*question-from-query-input*
    '())

(READRULES '*reaction-to-query-input*
   '(1 (0)
       2 (Thank you for the query \.) (0 :out)
     
  ))
); end of eval-when
