;; Gist clause extraction
;; simple nested rules + features + wildcards
;;
;; "How did you get here today?"

(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
    (spatial-beginning-pair spatial-beginning there)
    (spatial-beginning spatial-verb between prep)
    (spatial-verb be modal wh_ do)
    (spatial-ending noun adj there directions)
    (spatial-word noun supporting corp adj
      uppermost under close touching farthest rotated)
    (spatial-word-potential spatial-word be wh_ prep)
    (kinds types sorts kind type sort formats format)
    (question questions)
    (answer understand hear interpret parse)
    (here here\'s heres)
    (directions left right top bottom back front)

    (corp Burger_King McDonalds Mercedes NVidia SRI SRI_International
      Starbucks Texaco Target Toyota )
    (block blocks cube cubes book books black glock 
      blog blogs bach blood glass); often misrecognized
    (name corp)
    (prep of on to under in behind near touching abutting between 
      below above next next_to visible)
    (rel-adj near close touching adjacent flush)
    (qual-adj purple blue green yellow orange red pink gray grey
      black white brown clear visible nearby)
    (num-adj two three four five six seven eight nine ten eleven twelve)
    (sup-adj leftmost rightmost furthest farthest nearest closest highest
      tallest nearest topmost)
    (ord-adj first second third fourth fifth sixthe seventh eighth ninth
      tenth eleventh twelfth thirteenth fourteenth fifteenth sixteenth
      seventeens eighteenth nineteenth twentieth)
    (diff-adj other different same distinct separate unique)
    (adj qual-adj rel-adj num-adj sup-adj ord-adj diff-adj)
    (mod-n adj corp)
    (noun block table stack row edge face plane line circle pile object
      color structure other); NB: "each other"; can also be adj, det
    (uppermost on highest top sitting)
    (under underneath supporting support)
    (close next)
    (touching face-to-face abutting against flush) 
    (be is are was were)
    (farthest furthest)
    (rotated angled swivelled turned)
  ))

  ; This is the top level choice tree for processing spatial question inputs.
  ; First, we want to check whether the response _is_ a spatial question, which
  ; we can do pretty generally by checking if it has any spatial keyword in it. If so,
  ; we sent it to further subtrees to do some simple preprocessing. Otherwise, we can check
  ; for any number of "small talk" patterns, which we should also be able to handle.
  (READRULES '*specific-answer-from-spatial-question-input*
  '(
    ;; ----------------------------------------
    ;; If spatial question, start preprocessing
    ;; ----------------------------------------
    1 (0 spatial-word 0)
      2 (*asr-fix-tree* (1 2 3)) (0 :subtree+clause)
    ;; ---------------------
    ;; "Small talk" patterns
    ;; ---------------------
    1 (0 wh_ 1 your name 0)
      2 ((What is your name ?)) (0 :gist)
    1 (0 aux you 1 answer 3 question 0)
      2 ((Can you answer my question ?)) (0 :gist)
    1 (0 aux you 0)
      2 ((Can you do something ?)) (0 :gist)
    1 (0 wh_ 1 kinds 2 question 1 aux you 1 answer 0)
      2 ((What questions can you answer ?)) (0 :gist)
    1 (0)
      2 ((NIL Gist \: Eta could not understand my question \.)) (0 :gist)
  ))

  ; The first stage of preprocessing. Here we want to check for common ASR mistakes, and
  ; map those to the (most plausibly) correct input.
  (READRULES '*asr-fix-tree*
  '(
    1 (0 mcdonald\'s 0)
      2 (*asr-fix-tree* (1 mcdonalds 3)) (0 :subtree+clause)
    1 (0 mcdonalds black 0)
      2 (*asr-fix-tree* (1 mcdonalds block 4)) (0 :subtree+clause)
    1 (0 meats are i 0)
      2 (*asr-fix-tree* (1 SRI 5)) (0 :subtree+clause)
    1 (0 meats? are i 0)
      2 (*asr-fix-tree* (1 SRI 5)) (0 :subtree+clause)
    1 (0 meats ? are i 0)
      2 (*asr-fix-tree* (1 SRI 6)) (0 :subtree+clause)
    1 (0 ssri block 0)
      2 (*asr-fix-tree* (1 SRI block 4)) (0 :subtree+clause)
    1 (0 sr. i block 0)
      2 (*asr-fix-tree* (1 SRI block 5)) (0 :subtree+clause)
    1 (0 sr \. i block 0)
      2 (*asr-fix-tree* (1 SRI block 6)) (0 :subtree+clause)
    1 (0 psr i block 0)
      2 (*asr-fix-tree* (1 the SRI block 5)) (0 :subtree+clause)
    1 (0 they survived look 0)
      2 (*asr-fix-tree* (1 the SRI block 5)) (0 :subtree+clause)
    1 (0 novita 0)
      2 (*asr-fix-tree* (1 NVidia 3)) (0 :subtree+clause)
    1 (0 univita 0)
      2 (*asr-fix-tree* (1 NVidia 3)) (0 :subtree+clause)
    1 (0 visiting aveda block 0)
      2 (*asr-fix-tree* (1 is the NVidia block 5)) (0 :subtree+clause)
    1 (0 above to 0)
      2 (*asr-fix-tree* (1 above the 4)) (0 :subtree+clause)
    1 (0 a mirror to 0)
      2 (*asr-fix-tree* (1 nearer to 5)) (0 :subtree+clause)
    1 (0 lymph nodes look 0)
      2 (*asr-fix-tree* (1 leftmost block 5)) (0 :subtree+clause)
    1 (0 stock 0)
      2 (*asr-fix-tree* (1 stack 3)) (0 :subtree+clause)
    1 (0)
      2 (*detect-references-tree* (1)) (0 :subtree+clause)
  ))

  ; The second stage of preprocessing. We want to detect any references/pronouns (for now)
  ; so we can preempt them and tell the user that they aren't currently supported.
  (READRULES '*detect-references-tree*
  '(
    1 (0 spatial-word-potential 0 it 0)
      2 ((Can you answer my question referring to a past question ?)) (0 :gist)
    1 (0 spatial-word-potential 0 they 0)
      2 ((Can you answer my question referring to a past question ?)) (0 :gist)
    1 (0 spatial-word-potential 0 them 0)
      2 ((Can you answer my question referring to a past question ?)) (0 :gist)
    1 (0 spatial-word-potential 0 that block 0)
      2 ((Can you answer my question referring to a past question ?)) (0 :gist)
    1 (0)
      2 (*trim-suffix-tree* (1)) (0 :subtree+clause)
  ))

  ; The third stage of preprocessing. We want to remove any "suffix" that the user might
  ; throw after the query, such as tag questions. We do this by trimming off everything at
  ; the end that isn't a spatial-ending (noun or adj). Right now this is being done in a rather
  ; unwieldy way, due to the problem of recursion (i.e. an input can theoretically have any number
  ; of spatial-ending words).
  (READRULES '*trim-suffix-tree*
  '(
    1 (0 spatial-ending ?)
      2 (*trim-prefix-tree* (1 2 ?)) (0 :subtree+clause)
    1 (0 spatial-ending)
      2 (*trim-prefix-tree* (1 2 ?)) (0 :subtree+clause)
    1 (0 spatial-ending 0 spatial-ending 0 spatial-ending 0 spatial-ending 0
         spatial-ending 0 spatial-ending 0 spatial-ending 0 spatial-ending 0)
      2 (*trim-prefix-tree* (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 ?)) (0 :subtree+clause)
    1 (0 spatial-ending 0 spatial-ending 0 spatial-ending 0 spatial-ending 0
         spatial-ending 0 spatial-ending 0 spatial-ending 0)
      2 (*trim-prefix-tree* (1 2 3 4 5 6 7 8 9 10 11 12 13 14 ?)) (0 :subtree+clause)
    1 (0 spatial-ending 0 spatial-ending 0 spatial-ending 0 spatial-ending 0
         spatial-ending 0 spatial-ending 0)
      2 (*trim-prefix-tree* (1 2 3 4 5 6 7 8 9 10 11 12 ?)) (0 :subtree+clause)
    1 (0 spatial-ending 0 spatial-ending 0 spatial-ending 0 spatial-ending 0
         spatial-ending 0)
      2 (*trim-prefix-tree* (1 2 3 4 5 6 7 8 9 10 ?)) (0 :subtree+clause)
    1 (0 spatial-ending 0 spatial-ending 0 spatial-ending 0 spatial-ending 0)
      2 (*trim-prefix-tree* (1 2 3 4 5 6 7 8 ?)) (0 :subtree+clause)
    1 (0 spatial-ending 0 spatial-ending 0 spatial-ending 0)
      2 (*trim-prefix-tree* (1 2 3 4 5 6 ?)) (0 :subtree+clause)
    1 (0 spatial-ending 0 spatial-ending 0)
      2 (*trim-prefix-tree* (1 2 3 4 ?)) (0 :subtree+clause)
    1 (0 spatial-ending 0)
      2 (*trim-prefix-tree* (1 2 ?)) (0 :subtree+clause)
    1 (0 spatial-word 0)
      2 (*trim-prefix-tree* (1 2 ?)) (0 :subtree+clause)
  ))

  ; The fourth stage of preprocessing. We want to remove any "prefix" that the user might
  ; use as an opening, e.g. "my question is ...".
  (READRULES '*trim-prefix-tree*
  '(
    1 (0 here 1 my 1 question 0)
      2 (*multi-token-word-tree* (spatial-question 7)) (0 :subtree+clause)
    1 (0 my 1 question 2 be this 0)
      2 (*multi-token-word-tree* (spatial-question 8)) (0 :subtree+clause)
    1 (0 my 1 question 2 be 0)
      2 (*multi-token-word-tree* (spatial-question 7)) (0 :subtree+clause)
    1 (0 spatial-beginning-pair spatial-beginning-pair spatial-beginning-pair ; meant to match something
        spatial-beginning-pair 0)                                             ; like "is there...what is next
                                                                              ; to the red block?"
      2 (*multi-token-word-tree* (spatial-question 4 5 6)) (0 :subtree+clause)
    1 (between spatial-beginning 0)
      2 (*multi-token-word-tree* (spatial-question 1 2 3)) (0 :subtree+clause)
    1 (wh_ spatial-beginning 0)
      2 (*multi-token-word-tree* (spatial-question 1 2 3)) (0 :subtree+clause)
    1 (NIL so spatial-beginning 0)
      2 (*multi-token-word-tree* (spatial-question 3 4)) (0 :subtree+clause)
    1 (NIL spatial-beginning 0)
      2 (*multi-token-word-tree* (spatial-question 2 3)) (0 :subtree+clause)
    1 (0)
      2 (*multi-token-word-tree* (spatial-question 1)) (0 :subtree+clause) 
  ))

  ; The fifth stage of preprocessing. Here we combine any words that have multiple tokens,
  ; e.g. "burger king" into a single word, joined by an underscore.
  (READRULES '*multi-token-word-tree*
  '(
    1 (0 burger king 0)
      2 (*multi-token-word-tree* (1 burger_king 4)) (0 :subtree+clause)
    1 (0 sri international 0)
      2 (*multi-token-word-tree* (1 sri_international 4)) (0 :subtree+clause)
    1 (0 next to 0)
      2 (*multi-token-word-tree* (1 next_to 4)) (0 :subtree+clause)
    1 (0)
      2 ((1)) (0 :gist)
  ))
		
  (READRULES '*question-from-spatial-question-input*
  '(
  ))

); end of eval-when
