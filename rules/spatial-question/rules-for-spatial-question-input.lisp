;; Gist clause extraction
;; simple nested rules + features + wildcards
;;
;; "How did you get here today?"

(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ))

  ;
  ; The following "choice packet" defined below is parsed into a rule tree,
  ; which matches patterns recursively:
  ; If a particular pattern fails to match to the input, the pattern matching
  ; algorithm will backtrack and attempt to match the next sibling, and so on.
  ; If no patterns at some depth successfully match, the algorithm backtracks
  ; to the previous level of patterns and continues. The top-level (0) pattern
  ; (scroll down to the bottom of the choice packet), which matches anything,
  ; ensures that if no pattern is matched, a special "NIL Gist" will be extracted.
  ;
  (READRULES '*specific-answer-from-spatial-question-input*
  '(
    1 (0)
      2 ((Spatial question \: 1)) (0 :gist)
  ))
  
  (READRULES '*thematic-answer-from-spatial-question-input*
    '())

  (READRULES '*unbidden-answer-from-spatial-question-input*
    '())
		
  (READRULES '*question-from-spatial-question-input*
    '())

); end of eval-when
