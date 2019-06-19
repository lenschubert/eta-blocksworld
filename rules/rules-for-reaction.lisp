(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '())

(READRULES '*reaction-to-example-input*
  '(1 (0 NIL GIST \: 0)
      2 (Sorry \, you did not catch what I said \.) (0 :out)
    1 (0)
      2 (The gist of my reply is \: \' 1 \' \.) (0 :out)
  ))
); end of eval-when
