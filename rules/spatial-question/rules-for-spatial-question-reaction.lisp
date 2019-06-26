(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '())

(READRULES '*reaction-to-spatial-question-input*
  '(
    1 (spatial-question 0)
      2 (I asked \: \' 2 \') (0 :out)
    1 (poss-ans 0)
      2 (You are not sure you understood the question correctly\, but your answer is \: 2) (0 :out)
    1 (0)
      2 (1) (0 :out)
  ))
); end of eval-when
