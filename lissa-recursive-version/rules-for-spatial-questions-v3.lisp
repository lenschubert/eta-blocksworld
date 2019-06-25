; "rules-for-spatial-questions.lisp"  -- expanded June 15/19
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
          (block blocks cube cubes book books black glock 
                             blog blogs bach blood glass); often misrecognized
          (prep of on to under in behind near touching abutting between 
                below above visible)
          (rel-adj near close touching adjacent flush)
          (qual-adj purple blue green yellow orange red pink gray grey
                black white brown clear visible)
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

;; NB: All questions are expected to have a separate question mark at the end;
;;     If necessary, prior input processing of the user input (as supplied -- 
;;     somewhat unreliably -- by the speech recognizer) should separate off
;;     or add a question mark, when the input seems to be in the form of 
;;     a question (typically starting with a be-word, a wh-word, or a prep-
;;     osition plus wh-word)
;;
;; NB: :ulf-recur rules specify 2 reassembly patterns -- one for the successive
;;     parts, and one for putting the ULFs for the parts together with the 
;;     correct bracketing; (:ulf rules specify just the ulf assembly patterns).
;;
;;     The first of these reassembly patterns needs to be a list of any of
;;     the following 3 sorts of components:
;;     - an atom, which will be used as-is in the second reassembly pattern;
;;     - a triple (lex-ulf! <lex-cat> <part number>) which will (later) be
;;       evaluated into a lexical ULF atom or ULF expression;
;;     - a pattern of form (<name of a rule-tree> <itm1> <itm2> ...) where
;;       the <itmj> elements are typically integers indicating parts, but
;;       can also be arbitrary expressions, potentially containing integers
;;       indicating parts.
;;
;;     The second reassembly pattern just specifies how the "pieces" 
;;     (top-level components) in the first reassembly pattern should be 
;;     bracketed to yield the final ULF form (once the components of type
;;     (<name of a rule-tree> <itm1> <itm2> ...) have been recursively
;;     evaluated). It could also introduce additional ULF expressions,
;;     but for readability usually shouldn't, unless material needs to be
;;     added that doesn't fit with the syntactic constraints on types of
;;     components in the first reassembly pattern, as enumerated above.
;;     
;;     The expressions of form (lex-ulf! <lex-cat> <part number>) in the
;;     resulting ULF are evaluated as a final step in the program 
;;     'choose-result-for1', which interprets the directives.

(READRULES '*spatial-question-ulf-tree* ; Later we can use a more general tree,
                                        ; not restricted to the blocks world,
                                        ; and use occurrence of "block" or 
                                        ; "table" (& perhas a spatial relation)
                                        ; to jump to this tree;
 '(1 (be 0)
    2 *yn-question-ulf-tree* (0 :subtree)
   1 (modal 0)      ; e.g., "Can you see the NVidia block ?
    2 *modal-question-ulf-tree* (0 :subtree)
   1 (wh_ 0)
    2 *wh-question-ulf-tree* (0 :subtree)
   1 (prep 2 wh_ 0) ; e.g., "On top of which block is the NVidia block ?"
    2 *ppwh-question-ulf-tree* (0 :subtree)
 ))


(READRULES '*yn-question-ulf-tree* ; simple test version

 '(1 (be det 2 block 0); more generally we would look for (be np_ 0)
    2 (be det 2 block prep 3 det 3 ?); e.g., Is the NVidia block on a red block ?
     3 (((lex-ulf! v 1) (*np-ulf-tree* 2 3 4) (*rel-ulf-tree* 5 6) 
         (*np-ulf-tree* 7 8) (lex-ulf! punc 9)) ((1 2 (3 4)) 5)) 
       (0 :ulf-recur)   ; bracket structure rule``````````````
    2 (be det 2 block adj ?); e.g., Is the NVidia block clear/red/visible ?
     3 (((lex-ulf! v 1) (*np-ulf-tree* 2 3 4) (lex-ulf! adj 5) (lex-ulf! punc 6))
        ((1 2 3) 4)) (0 :ulf-recur)
   1 (be there det 0)
    2 (be there det 2 block prep 3 det 3 ?); e.g., Is there a red block on a blue block ?
     3 (((lex-ulf! v 1) there.pro (*np-ulf-tree* 3 4 5) 
         (*rel-ulf-tree* 6 7) (*np-ulf-tree* 8 9) (lex-ulf! punc 10))
        ((1 2 3 (4 5)) 6)) (0 :ulf-recur) 
    2 (be there det 2 block prep 3 det 3 rel-adj 4 ?); e.g., Are there 2 green blocks
                                             ; on the table (that are) near each other ?
     3 (((lex-ulf! v 1) there.pro (*np+preds-ulf-tree* 3 4 5 6 7 8 9 10 11)
         (lex-ulf! punc 12)) ((1 2 3) 4)) (0 :ulf-recur)
   1 (be there pron prep 3 det 3 ?); e.g., Is there anything behind the NVidia block ?
    2 (((lex-ulf! v 1) there.pro (lex-ulf! pro 3) (*rel-ulf-tree* 4 5) 
        (*np-ulf-tree* 6 7) (lex-ulf! punc 8)) ((1 2 3 (4 5)) 6)) (0 :ulf-recur)
  ))

;; These rules and the N1 rules need to allow for PLUR ("blocks")
(READRULES '*np-ulf-tree* 
 '(1 (det noun) ; e.g., the table, a stack, a row
    2 ((lex-ulf! det 1) (lex-ulf! noun 2)) (0 :ulf)
   1 (det sup-adj 3); e.g., "the leftmost block" => (most-n left.a block.n)
                    ; if (leftmost.a block.n) is preferred, interchange the
                    ; '1' and '2' lines here with the next '1' and '2' lines
    2 (((lex-ulf! det 1) (*sup-n1-ulf-tree* 2 3)) (1 2)) (0 :ulf-recur)
   1 (det adj 3) 
    2 (((lex-ulf! det 1) (*n1-ulf-tree* 2 3)) (1 2)) (0 :ulf-recur)
   1 (det corp noun) 
    2 ((lex-ulf! det 1) ((lex-ulf! name 2) (lex-ulf! noun 3))) (0 :ulf)
   1 (pron) 
    2 (lex-ulf! pro 1) (0 :ulf)
   1 (degr-adv num-adj 3); e.g., exactly two red blocks
    2 (((lex-ulf! adv 1) (lex-ulf! adj 2) (*n1-ulf-tree* 3))
       ((1 2) 3)) (0 :ulf-recur)
 ))


(READRULES '*np+preds-ulf-tree* ; expected form: det n1 {PP,el-clause} {PP,rel-clause};
                                ; but only "that is/are ..." rel-clauses are handled 
 '(1 (det 2 prep 3 det 2 prep 3 det 2); two postmodifying PPs, e.g.,
                                      ; two red blocks near each other on the table
    2 (((lex-ulf! det 1) (*n1-ulf-tree* 2) (*rel-ulf-tree* 3 4) (*np-ulf-tree* 5 6)
        (*rel-ulf-tree* 7 8) (*np-ulf-tree* 9 10)) (1 (n+preds 2 (3 4) (5 6))))
      (0 :ulf-recur)
   1 (det 2 prep 3 det 2 that be prep 3 det 2); postmodifying PP + rel-clause
    2 (((lex-ulf! det 1) (*n1-ulf-tree* 2) (*rel-ulf-tree* 3 4) (*np-ulf-tree* 5 6)
        that.rel (lex-ulf! v 8) (*rel-ulf-tree* 9 10) (*np-ulf-tree* 11 12))
       (1 (n+preds 2 (3 4) (5 (6 (7 8)))))) (0 :ulf-recur)
   1 (det 2 that be prep 3 det 2 prep 3 det 2); postmodifying rel-clause + PP
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

(READRULES '*sup-n1-ulf-tree* ; e.g., leftmost red block => 
                              ;         (most-n left.a (red.a block.n))
 '(1 (sup-adj 3)
    2 (((lex-ulf! sup-adj 1) (*n1-ulf-tree* 2)) (most-n 1 2)) (0 :ulf-recur)
 ))    ;``````````````````` this renders "leftmost" as just 'left.a' (etc.)


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

     
(readrules '*modal-question-ulf-tree* ; ones like "Can you see the NVidia block ?
 '(1 (Sorry\, you\'re not handling modal questions yet) (0 :out)
 ))

(readrules '*wh-question-ulf-tree* ; ones like "Where is the NVidia block?
 '(1 (where be det 2 noun 0)
    2 (where be det 2 noun ?)
     3 (((lex-ulf! wh-pred 1) (lex-ulf! v 2) (*np-ulf-tree* 3 4 5) ?)
        ((sub 1 (2 3 *h)) ?)) (0 :ulf-recur)
   1 (wh-det noun be prep 3 det 3 ?); e.g., what/which/whose block is to the left
                                   ; of the Nvidia block ?
    2 (((lex-ulf! det 1) (lex-ulf! noun 2) (lex-ulf! v 3) (*rel-ulf-tree* 4 5) 
        (*np-ulf-tree*  6 7) ?) (((1 2) (3 (4 5))) ?)) (0 :ulf-recur)
   1 (what color noun be prep 3 det 3 ?); e.g., what color block is to the left
                                        ; of the Nvidia block ? [unusual subj NP!]
    2 (((lex-ulf! det 1) (lex-ulf! adj 2) (lex-ulf! noun 3) (lex-ulf! v 4)
       (*rel-ulf-tree* 5 6) (*np-ulf-tree*  7 8) ?) (((1 (2 3)) (4 (5 6))) ?))
       (0 :ulf-recur)
   1 (wh-det noun be the 2 prep 2 prep ?); e.g., What/which block is the NVidia block
                                        ; on top of [to the left of]?
    2 (((lex-ulf! det 1) (lex-ulf! noun 2) (lex-ulf! v 3) the.d (*n1-ulf-tree* 5)
        (*rel-ulf-tree* 6 7 8) ?) ((sub (1 2) (3 (4 5) (6 *h))) ?)) (0 :ulf-recur)
   1 (wh-pron be the sup-adj 2 ?); e.g., what is the highest red block ?
    2 (((lex-ulf! pro 1) (lex-ulf! v 2) the.d (*sup-n1-ulf-tree* 4 5) ?)
       ((1 (2 (the.d 4))) ?)) (0 :ulf-recur)
   ;TBC do some more wh-pron cases, and then "how many"
 ))


(readrules '*ppwh-question-ulf-tree* ;e.g., On (top of) what object is the NVidia block ?
 '(1 (prep 2 wh-det 2 be det 4 ?) 
    2 (((lex-ulf! 1 2) (lex-ulf! det 3) (*n1-ulf-tree* 4) (lex-ulf! 5) (lex-ulf! det 6)
        (*n1-ulf-tree* 7 ) ?) ((sub (1 (2 3)) (4 (5 6) *h)) ?)) (0 :ulf-recur)
  ; add further rules, e.g., for "On what blocks are there other blocks ?", or
  ; "On how many blocks is the Target block resting/placed/supported/positioned ?"
 ))

); end of eval-when
