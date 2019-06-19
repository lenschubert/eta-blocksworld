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
   '(
      1 (BE 0)
         2 (BE DET 3 PREP DET 3 DET 3)
            3 (*generate-ulf* ( \( BE 1 \) \( NP 2 3 \) \( REL 4 5 6 \) \( NP 7 8 \) )) (0 :subtree+clause)
      1 (0)
         2 ((NIL Gist \: 0) (query)) (0 :gist)
       
  		

	))

 (READRULES '*generate-ulf*
   '(
      1 (0)
         2 ((0) (query))  (0 :gist)
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
