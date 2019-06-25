; "rules-for-spatial-questions.lisp"  -- expanded June 14/19
; from previous version
; ====================================================================

;; Choice packets for ulf derivation from spatial questions by user.
;;
;; The initial set of features are intended to support analysis
;; of the user's spatial relation questions in the Blocks world

(eval-when (load eval)

  (MAPC 'ATTACHFEAT
        '(; New as of June 9/19:
          (corp Burger_King McDonalds Mercedes NVidia SRI Starbucks
                Texaco Target Toyota )
          (block blocks cube cubes book books blog blogs); often misrecognized
          (prep on to under in behind near touching abutting between 
                below above visible)
          (rel-adj near close touching adjacent flush)
          (qual-adj purple blue green yellow orange red pink gray grey
                black white brown clear)
          (num-adj two three four five six seven eight nine ten eleven twelve)
                   ; (But note: we assume numerals can also be determiners)
          (sup-adj leftmost rightmost furthest farthest nearest highest
                nearest)
          (adj qual-adj rel-adj num-adj sup-adj)
          (noun block table stack row edge face plane line circle pile)
          (uppermost on highest top sitting)
          (under underneath supporting support)
          (close next)
          (touching face-to-face abutting against flush) 
          (be is are was were)
          (farthest furthest)
          (rotated angled swivelled turned)
          ))

;; NB: :ulf-recur rules specify 2 reassembly patterns -- one for the successive
;;     parts, and one for putting the ULFs for the parts together with the 
;;     correct bracketing; :ulf rules specify just the ulf assembly patterns.
;;
;;     Also note that the reassembly patterns often contain  constituents
;;         (lex-ulf! <lex-cat> <part number>),
;;     which are evaluated in the calling program 'choose-result-for1'.

(READRULES '*spatial-question-ulf-tree* ; Later we can use a more general tree,
                                        ; not restricted to the blocks world,
                                        ; and use occurrence of "block" or 
                                        ; "table" (& perhas a spatial relation)
                                        ; to jump to this tree;
 '(1 (be 0)
    2 *yn-question-ulf-tree* (0 :subtree)
   1 (modal 0)
    2 *modal-question-ulf-tree* (0 :subtree)
   1 (wh_ 0)
    2 *wh-question-ulf-tree* (0 :subtree)
 ))


(READRULES '*yn-question-ulf-tree* ; simple test version

 '(1 (be det 2 block 0); more generally we would look for (be np_ 0)
    2 (be det 2 block prep 3 det 3 ?); e.g., Is the NVidia block on a red block?
     3 (((lex-ulf! v 1) (*np-ulf-tree* 2 3 4) (*rel-ulf-tree* 5 6) 
         (*np-ulf-tree* 7 8) (lex-ulf! punc 9)) ((1 2 (3 4)) 5)) 
       (0 :ulf-recur)   ; bracket structure rule``````````````
    2 (be det 2 block adj ?); e.g., Is the NVidia block clear/red/visible?
     3 (((lex-ulf! v 1) (*np-ulf-tree* 2 3 4) (lex-ulf! adj 5) (lex-ulf! punc 6))
        ((1 2 3) 4)) (0 :ulf-recur)
   1 (be there det 0)
    2 (be there det 2 block prep 3 det 3 ?); e.g., Is there a red block on a blue block?
     3 (((lex-ulf! v 1) there.pro (*np-ulf-tree* 3 4 5) 
         (*rel-ulf-tree* 6 7) (*np-ulf-tree* 8 9) (lex-ulf! punc 10))
        ((1 2 3 (4 5)) 6)) (0 :ulf-recur) 
    2 (be there det 2 block prep 3 det 3 rel-adj 4 ?); e.g., Are there 2 green blocks
                                             ; on the table (that are) near each other?
     3 (((lex-ulf! v 1) there.pro (*np+preds-ulf-tree* 3 4 5 6 7 8 9 10 11)
         (lex-ulf! punc 12)) ((1 2 3) 4)) (0 :ulf-recur)
   1 (be there pron prep 3 det 3 ?); e.g., Is there anything behind the NVidia block?
    2 (((lex-ulf! v 1) there.pro (lex-ulf! pro 3) (*rel-ulf-tree* 4 5) 
        (*np-ulf-tree* 6 7) (lex-ulf! punc 8)) ((1 2 3 (4 5)) 6)) (0 :ulf-recur)
  ))

;; These rules and the N1 rules need to allow for PLUR ("blocks")
(READRULES '*np-ulf-tree* 
 '(1 (det noun) 
    2 ((lex-ulf! det 1) (lex-ulf! noun 2)) (0 :ulf)
   1 (det adj 3) 
    2 (((lex-ulf! det 1) (*n1-ulf-tree* 2 3)) (1 2)) (0 :ulf-recur)
   1 (det corp noun) 
    2 ((lex-ulf! det 1) (lex-ulf! name 2) (lex-ulf! noun 3)) (0 :ulf)
   1 (det 1); e.g., the table, a stack, a row
    2 ((lex-ulf! det 1) (lex-ulf! noun 2)) (0 :ulf)
   1 (pron) 
    2 (lex-ulf! pro 1) (0 :ulf)
 ))


(READRULES '*np+preds-ulf-tree* ; expected form: det n1 {PP,el-clause} {PP,rel-clause};
                                ; but only "that is/are ..." rel-clauses are handled 
 '(1 (det 2 prep 3 det 2 prep 3 det 2); e.g., 2 red blocks near each other on the table
    2 (((lex-ulf! det 1) (*n1-ulf-tree* 2) (*rel-ulf-tree* 3 4) (*np-ulf-tree* 5 6)
        (*rel-ulf-tree* 7 8) (*np-ulf-tree* 9 10)) (1 (n+preds 2 (3 4) (5 6))))
      (0 :ulf-recur)
   1 (det 2 prep 3 det 2 that be prep 3 det 2)
    2 (((lex-ulf! det 1) (*n1-ulf-tree* 2) (*rel-ulf-tree* 3 4) (*np-ulf-tree* 5 6)
        that.rel (lex-ulf! v 8) (*rel-ulf-tree* 9 10) (*np-ulf-tree* 11 12))
       (1 (n+preds 2 (3 4) (5 (6 (7 8)))))) (0 :ulf-recur)
   1 (det 2 that be prep 3 det 2 prep 3 det 2)
    2 (((lex-ulf! det 1) (*n1-ulf-tree* 2) that.rel (lex-ulf! v 4) (*rel-ulf-tree* 5 6)
        (*np-ulf-tree* 7 8) (*rel-ulf-tree* 9 10) (*np-ulf-tree* 11 12))
       (1 (n+preds 2 (3 (4 (5 6))) (7 8)))) (0 :ulf-recur)
   ; 2 rel-clauses unlikely, so hold off for now 
 ))

;; These N1 rules need to allow for PLUR ("blocks")
(READRULES '*n1-ulf-tree* ; premodified noun
 '(1 (adj noun) 
    2 ((lex-ulf! adj 1) (lex-ulf! noun 2)) (0 :ulf)
   1 (adj adj block) 
    2 ((lex-ulf! adj 1) (lex-ulf! adj 2) (lex-ulf! noun 3)) (0 :ulf)
   1 (corp noun)
    2 ((lex-ulf! name 1) (lex-ulf! noun 2))  (0 :ulf)
   1 (adj corp noun)
    2 ((lex-ulf! adj 1) ((lex-ulf! name 2) (lex-ulf! noun 3))) (0 :ulf)
 ))


(READRULES '*rel-ulf-tree* ; phrases like "on" or "on top of"
 '(1 (prep) 
    2 (lex-ulf! prep 1) (0 :ulf)
   1 (on top of)
    2  on_top_of.p (0 :ulf)
   1 (to the left of)
    2 to_the_left_of.p (0 :ulf)
   1 (to the right of)
    2 to_the_right_of.p (0 :ulf)
   1 (next to)
    2  next_to.p (0 :ulf)
   1 (in front of)
    2  in_front_of.p (0 :ulf)
 ))

)
     
(readrules '*modal-question-ulf-tree* ; ones like "Can you see the NVidia block?
 '(1 (Sorry\, you\'re not handling modal questions yet) (0 :out)
 ))

(readrules 'wh-question-ulf-tree* ; ones like "Where is the NVidia block?
 '(1 (Sorry\, you\'re not handling wh-questions yet) (0 :out)
 ))

