;; Gist clause extraction
;; simple nested rules + features + wildcards
;;
;; "How did you get here today?"

(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
    (spatial-words noun supporting corp rel-adj qual-adj sup-adj
      uppermost under touching farthest rotated)
    (kinds types sorts kind type sort formats format)
    (question questions)
    (answer understand hear interpret parse)
    (corp Burger_King McDonalds Mercedes NVidia SRI SRI_International
      Starbucks Texaco Target Toyota )
    (block blocks cube cubes book books black glock 
      blog blogs bach blood glass); often misrecognized
    (prep of on to under in behind near touching abutting between 
      below above next next_to visible); currently "next" needs to have
                                                 ; the 'prep' feature, to allow
                                                 ; merging into 'next_to.p'; it's
                                                 ; risky, & prior word-joining 
                                                 ; by '_' would be safer.
    (rel-adj near close touching adjacent flush)
    (qual-adj purple blue green yellow orange red pink gray grey
      black white brown clear visible nearby)
    (num-adj two three four five six seven eight nine ten eleven twelve)
                   ; (But note: we assume numerals can also be determiners)
    (sup-adj leftmost rightmost furthest farthest nearest closest highest
      tallest nearest topmost)
    (adj qual-adj rel-adj num-adj sup-adj)
    (noun block table stack row edge face plane line circle pile object
      structure other); NB: "each other"
    (uppermost on highest top sitting)
    (under underneath supporting support)
    (close next)
    (touching face-to-face abutting against flush) 
    (be is are was were)
    (farthest furthest)
    (rotated angled swivelled turned)
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
    1 (0 spatial-words 0)
      2 ((spatial-question 1 2 3)) (0 :gist)
    ;; ------------------------------
    ;; ADD "SMALL TALK" PATTERNS HERE
    ;; ------------------------------
    1 (0 wh_ 1 your name 0)
      2 ((What is your name ?)) (0 :gist)
    1 (0 aux you 1 answer 3 question 0)
      2 ((Can you answer my question ?)) (0 :gist)
    1 (0 aux you 0)
      2 ((Can you do something ?)) (0 :gist)
    1 (0 wh_ 1 kinds 2 question 1 aux you 1 answer 0)
      2 ((What questions can you answer ?)) (0 :gist)
    1 (0)
      2 ((NIL Gist \: Lissa could not understand my question \.)) (0 :gist)
  ))
  
  (READRULES '*thematic-answer-from-spatial-question-input*
    '())

  (READRULES '*unbidden-answer-from-spatial-question-input*
  '(
  ))
		
  (READRULES '*question-from-spatial-question-input*
  '(
  ))

); end of eval-when
