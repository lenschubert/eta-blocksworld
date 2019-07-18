(eval-when (load eval)

   (READRULES '*clause-ulf-tree*
   '(
      1 (spatial-question 0 pron 0)
         2 (*spatial-question-ulf-tree* (2 3 4)) (0 :ulf-coref)
      1 (spatial-question 0 that block 0)
         2 (*spatial-question-ulf-tree* (2 3 4 5)) (0 :ulf-coref)
      1 (spatial-question 0 those blocks 0)
         2 (*spatial-question-ulf-tree* (2 3 4 5)) (0 :ulf-coref)
      1 (spatial-question 0)
         2 (((*spatial-question-ulf-tree* 2)) 1) (0 :ulf-recur)
   ))
); end of eval-when
