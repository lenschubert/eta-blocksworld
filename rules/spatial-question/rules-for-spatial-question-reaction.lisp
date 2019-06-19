(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '())

(READRULES '*reaction-to-spatial-question-input*
  '(1 (NIL GIST \: 0)
      2 (Sorry \, you did not catch what I said \.) (0 :out)
    1 (Spatial question \: 0)
      2 (Your question was \: \' 4 \' \.) (0 :out)
    1 (0)
      2 (The gist of my reply is \: \' 1 \' \.) (0 :out)
  ))
); end of eval-when
