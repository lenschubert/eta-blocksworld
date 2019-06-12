; "rules-for-spatial-questions.lisp"
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
          (prep on to under in behind near touching abutting)
          (adj purple blue green yellow orange red pink gray grey 
                black white brown)
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

(READRULES '*yn-question-ulf-tree* ; simple test version

 '(1 (be det 2 block 0)
    2 (be det 2 block prep 3 det 3 ?)
     3 (((lex-ulf! v 1) (*np-ulf-tree* 2 3 4) (*rel-ulf-tree* 5 6) 
         (*np-ulf-tree* 7 8) (lex-ulf! punc 9)) ((1 2 (3 4)) 5)) 
       (0 :ulf-recur)   ; bracket structure rule``````````````
   1 (be there det 0)
    2 (be there det 2 block prep 3 det 3 ?)
     3 (((lex-ulf! v 1) there.pro (*np-ulf-tree* 3 4 5) 
         (*rel-ulf-tree* 6 7) (*np-ulf-tree* 8 9) (lex-ulf! punc 10))
        ((1 2 3 (4 5)) 6)) (0 :ulf-recur) 
  ))


(READRULES '*np-ulf-tree* 
 '(1 (det block) 
    2 ((lex-ulf! det 1) block.n) (0 :ulf)
   1 (det adj 3) 
    2 (((lex-ulf! det 1) (*n1-ulf-tree* 2 3)) (1 2)) (0 :ulf-recur)
   1 (det corp block) 
    2 ((lex-ulf! det 1) (lex-ulf! name 2) block.n) (0 :ulf)
 ))


(READRULES '*n1-ulf-tree* ; premodified noun
 '(1 (adj block) 
    2 ((lex-ulf! adj 1) block.n) (0 :ulf)
   1 (adj adj block) 
    2 ((lex-ulf! adj 1) (lex-ulf! adj 2) block.n) (0 :ulf)
   1 (corp block)
    2 ((lex-ulf! name 1) block.n)  (0 :ulf)
   1 (adj corp block)
    2 ((lex-ulf! adj 1) ((lex-ulf! name 2) block.n)) (0 :ulf)
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
     
