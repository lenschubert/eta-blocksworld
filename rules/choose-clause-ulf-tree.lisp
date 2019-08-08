(eval-when (load eval)

   (READRULES '*clause-ulf-tree*
   '(
      1 (spatial-question 0)
         2 (*spatial-question-ulf-tree* (2)) (0 :ulf-coref)
      1 (My name is 0)
         2 (*name-ulf-tree* (1 2 3 4)) (0 :ulf-coref)
   ))
); end of eval-when
