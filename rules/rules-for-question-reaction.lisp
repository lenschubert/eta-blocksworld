(eval-when (load eval)
 
  (READRULES '*reaction-to-question*
  '(
    1 (0 wh_ 1 your name 0)
      2 (Your creators have named you David \.) (0 :out)
    1 (0 aux you 1 answer 1 question 0)
      2 (0 past question 0)
        3 (Sorry \, but you are not quite smart enough to answer follow up questions yet \.) (0 :out)
      2 (You can try your best to answer my questions \.) (0 :out)
    1 (0 wh_ 1 questions 1 aux you 1 answer 0)
      2 (You can try your best to answer yes no questions \, wh questions \, and how many
        questions \. You cannot answer modal questions right now \, though \.) (0 :out)
	1 (0 aux you 0)
      2 (You can try your best to answer yes no questions \, wh questions \, and how many
        questions \. You cannot answer modal questions right now \, though \.) (0 :out)
  ))
); end of eval-when

