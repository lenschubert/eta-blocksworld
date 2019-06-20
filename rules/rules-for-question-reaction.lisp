(eval-when (load eval)
 
  (READRULES '*reaction-to-question*
  '(
    1 (0 wh_ 1 your name 0)
      2 (Your creators have named you Lissa \.) (0 :out)
    1 (0 aux you 1 answer 1 question 0)
      2 (You can try your best to answer my questions \.) (0 :out)
  ))
); end of eval-when

