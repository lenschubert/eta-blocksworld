(eval-when (load eval)

  (MAPC 'ATTACHFEAT
        '())

  (READRULES '*name-ulf-tree*
    '(
    1 (My name is 2)
      2 (((lex-ulf! d 1) (lex-ulf! n 2) (lex-ulf! v 3) (lex-ulf! name 4))
        ((1 2) (3 (= 4)))) (0 :ulf-recur)
    ))
); end of eval-when
