(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '())

(READRULES '*reaction-to-spatial-question-input*
  '(
    1 (spatial-question 0)
      2 (I asked \: \' 2 \') (0 :out)
    1 (0)
      2 (Answer \: 1) (0 :out)
  ))
); end of eval-when
