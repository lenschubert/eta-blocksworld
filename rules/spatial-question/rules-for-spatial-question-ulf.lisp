; On github at https://github.com/bkane2/eta-blocksworld 
; Select rules/spatial-question/rules-for-spatial-question-ulf.lisp
; ========================================================================
; "rules-for-spatial-questions.lisp"  -- currently under revision, June 21/19
; from previous version (v6). Add "between" rules. That's a bit tricky,
; because the complement of "between" either can be a plural ("between two
; red blocks") or a full NP conjunction ("between a red block and a blue
; block"), or a conjunction with ellipsis ("between a red and a blue
; block"; "between the Toyota and the SRI block"; "between the Toyota
; and SRI blocks").
;
; One issue is that to allow for names like "Burger King", we currently 
; need to preprocess to change this to "Burger_King". Would an alternative
; be to introduce features 'name-part1', 'name-part2, ..., which apply to
; parts of a multiword name, where single-word names have feature 'name',
; *as well as* feature 'name-part1'? Can we introduce a mini-grammar for
; names whose use is triggered by feature 'name-part1', and that allows
; a word with feature 'name' as a name, and allows appropriate sequences
; of words with features 'name-part1', 'name-part2, ... as names? But we
; can't do that via 'eval-lex-ulf', because this assumed we know for sure
; that the word(s) supplied can be of the specified category -- which we
; can't be sure of, just given features 'name-part1', 'name-part2, ... .
; So the grammar itself would need to check for particular word sequences,
; which would really be very inelegant, and infeasible for realistically
; large sets of names.
;
; Short of switching from single-word features (for pattern matching)
; to features assigned to word sequences (possible in TTT, I suppose),
; I think preprocessing is the best option. This might be done via the 
; gist clause mechanism, as part of "repairing" the user's word sequence
; as produced by the speech recognizer. Repairs are extremely context/
; domain-specific, but then that's also true for gist clause determination
; in general.
; 

; ====================================================================

;; Choice packets for ulf derivation from spatial questions by user.
;;
;; The initial set of features are intended to support analysis
;; of the user's spatial relation questions in the Blocks world

(eval-when (load eval)

  (MAPC 'ATTACHFEAT
        '(; New as of June 9/19:
          (corp Burger_King McDonalds Mercedes NVidia SRI SRI_International
                Starbucks Texaco Target Toyota Twitter Shell Adidas)
          (block blocks cube cubes book books black blacks glock glocks
                             blog blogs bach blood bloods glass box look looks); often misrecognized
          (name corp)
          (prep of on to under in behind near touching abutting between from
                below above next next_to visible); currently "next" needs to have
                                                 ; the 'prep' feature, to allow
                                                 ; merging into 'next_to.p'; it's
                                                 ; risky, & prior word-joining 
                                                 ; by '_' would be safer.
          (rel-adj near close touching adjacent flush)
          (qual-adj purple blue green yellow orange red pink gray grey
                black white brown clear visible nearby)
          (num-adj two three four five six seven eight nine ten eleven twelve many)
                   ; (But note: we assume numerals can also be determiners)
          (sup-adj leftmost rightmost furthest farthest nearest closest highest
                tallest nearest topmost uppermost smallest lowest largest
                centermost shortest backmost longest fewest frontmost)
          (ord-adj first second third fourth fifth sixthe seventh eighth ninth
           tenth eleventh twelfth thirteenth fourteenth fifteenth sixteenth
           seventeens eighteenth nineteenth twentieth)
          (diff-adj other different same distinct separate unique)
          (adj qual-adj rel-adj num-adj sup-adj ord-adj diff-adj)
          (mod-n adj corp)
          (noun block table stack row edge face plane line circle pile object
                color structure left right back front other); NB: "each other"
                                                         ; can also be adj, det
          (uppermost on highest top sitting)
          (under underneath supporting support)
          (close next)
          (touching face-to-face abutting against flush) 
          (be is are was were)
          (verb touch touches support supports connect connects consist_of
           consists_of sit sits adjoin adjoins flank flanks)
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
   ; "is/are"-questions
 '(1 (be 0 between 0); unfortunately "between" wreaks havoc with expected prep+NP
                    ; patterns, and so is here treated via many "between"-specific
                    ; rules
    2 *yn-between-question-ulf-tree* (0 :subtree)
   1 (be 0)
    2 *yn-question-ulf-tree* (0 :subtree)

   ; modal questions
   1 (modal 0)      ; e.g., "Can you see the NVidia block ?
    2 *modal-question-ulf-tree* (0 :subtree)

   ; wh-questions
   1 (wh_ 0 between 0)
    2 *wh-between-question-ulf-tree* (0 :subtree)
   1 (wh_ 0)
    2 *wh-question-ulf-tree* (0 :subtree)

   ; PP[wh]-questions
   1 (between 2 wh_ 0) ; e.g., "Between which two blocks is the NVidia block ?"
    2 *ppwh-between-question-ulf-tree* (0 :subtree)
   1 (prep 2 wh_ 0) ; e.g., "On top of which block is the NVidia block ?"
    2 *ppwh-question-ulf-tree* (0 :subtree)
   
   ; "do"-questions
   1 (do np_ 2 verb 1 between 0 ?); does anything sit between the two red blocks?
    2 (((lex-ulf! v 1) (*np-ulf-tree* 2 3) (lex-ulf! v 4) (*pp-between-ulf-tree* 6 7) ?)
       ((1 2 (3 (adv-e 4))) ?)) (0 :ulf-recur)
   1 (do np_ 2 verb np_ 2 ?); Does any block support the NVidia block ?
    2 (((lex-ulf! v 1) (*np-ulf-tree* 2 3) (lex-ulf! v 4) (*np-ulf-tree* 5 6) ?)
       ((1 2 (3 4)) ?)) (0 :ulf-recur)
   1 (do np_ 2 verb prep 3 det 3 ?); does any block sit on the red NVidia block ?
    2 (((lex-ulf! v 1) (*np-ulf-tree* 2 3) (lex-ulf! v 4) (*pp-ulf-tree* 5 6 7 8) ?)
       ((1 2 (3 (adv-e 4))) ?)) (0 :ulf-recur)

   ; declarative questions
   1 (np_ 3 be 0 ?); a red block is next to a blue block ?
    2 (((*spatial-sentence-ulf-tree* 1 2 3 4)) (1 ?)) (0 :ulf-recur)
   1 (np_ 3 verb 1 np_ 0 ?); a red block adjoins a blue block ?
    2 (((*spatial-sentence-ulf-tree* 1 2 3 4 5)) (1 ?)) (0 :ulf-recur)
   1 (np_ 3 verb 1 prep 0 ?); a red block sits between two green blocks ?
    2 (((*spatial-sentence-ulf-tree* 1 2 3 4 5 6)) (1 ?)) (0 :ulf-recur)

   ; fallback rules
   1 (0 block 0 between 0)
    2 *fallback-between-spatial-question-ulf-tree* (0 :subtree)
   1 (0 between 0 block 0)
    2 *fallback-between-spatial-question-ulf-tree* (0 :subtree)
   1 (0 block 0); last resort
    2 *fallback-spatial-question-ulf-tree* (0 :subtree) 
   1 (0 table 0)
    2 *fallback-spatial-question-ulf-tree* (0 :subtree)
 ))

; The following rules won't be reached by questions containing "between"

(READRULES '*yn-question-ulf-tree* 

 '(1 (be det 2 block 0); more generally we would look for (be np_ 0)
    2 (be det 2 block 1 prep 3 det 3 ?); e.g., Is the NVidia block on a red block ?
     3 (((lex-ulf! v 1) (*np-ulf-tree* 2 3 4) (*pp-ulf-tree* 5 6 7 8 9) ?)
        ((1 2 3) ?)) (0 :ulf-recur) 
    2 (be det 2 block adj ?); e.g., Is the NVidia block clear/red/visible ?
     3 (((lex-ulf! v 1) (*np-ulf-tree* 2 3 4) (lex-ulf! adj 5) ?)
        ((1 2 3) ?)) (0 :ulf-recur)
   1 (be there 3 noun 1 prep 3 det 5 ?); e.g., Is there a red block on a blue block"
    2 (((lex-ulf! v 1) there.pro (*np-ulf-tree* 3 4) (*pp-ulf-tree* 5 6 7 8 9) ?) 
       ((1 2 3 4) ?)) (0 :ulf-recur)
   1 (be there det 2 noun 1 prep 3 adj noun ?); e.g., are there any red blocks to the
                                            ;       left of blue blocks?
    2 (((lex-ulf! v 1) there.pro (*np-ulf-tree* 3 4 5) (*pp-ulf-tree* 6 7 8 9 10) ?)
       ((1 2 3 4) ?)) (0 :ulf-recur)
   1 (be there det 0 ?)
    2 (((lex-ulf! v 1) there.pro (*np-ulf-tree* 3 4) ?) ((1 2 3) ?)) (0 :ulf-recur)
         ; e.g., Is there a red block on a blue block ?
         ; e.g., Are there 2 green blocks on the table (that are) near each other ?
   1 (be there pron 1 prep 3 det 3 ?); e.g., Is there anything on the NVidia block ?
    2 (((lex-ulf! v 1) there.pro (lex-ulf! pro 3) (*pp-ulf-tree* 4 5 6 7 8) ?) 
       ((1 2 3 4) ?)) (0 :ulf-recur)
         ; ** Shouldn't we really get (any.d (n+preds thing.n (behind.p (the.d ...))))?
   1 (be there 2 block 0 ?); e.g., "Are there red blocks on the table ?"
    2 (((lex-ulf! v 1) there.pro (*n1-ulf-tree* 3 4 5) ?) ((1 2 (k 3)) ?)) 
      (0 :ulf-recur)
  ))

(READRULES '*spatial-sentence-ulf-tree*
 '(1 (np_ 3 be 1 between 0); a red block is between the NVidia and Mercedes blocks
    2 (((*np-ulf-tree* 1 2) (lex-ulf! v 3) (*pp-between-ulf-tree* 5 6))
       (1 (2 3))) (0 :ulf-recur)
   1 (np_ 3 be 1 prep 0); a red block is on the NVidia block
    2 (((*np-ulf-tree* 1 2) (lex-ulf! v 3) (*pp-ulf-tree* 5 6))
       (1 (2 3))) (0 :ulf-recur)
   1 (np_ 3 verb 1 np_ 0); a red block supports the NVidia block
    2 (((*np-ulf-tree* 1 2) (lex-ulf! v 3) (*np-ulf-tree* 5 6))
       (1 (2 3))) (0 :ulf-recur)
   1 (np_ 3 verb 1 between 0); a red block sits between the NVidia and Mercedes blocks
    2 (((*np-ulf-tree* 1 2) (lex-ulf! v 3) (*pp-between-ulf-tree* 5 6))
       (1 (2 3))) (0 :ulf-recur)
   1 (np_ 3 verb 1 prep 0)
    2 (((*np-ulf-tree* 1 2) (lex-ulf! v 3) (*pp-ulf-tree* 5 6))
       (1 (2 3))) (0 :ulf-recur)
 ))


(READRULES '*np-ulf-tree* 
 '(1 (det 2 noun 0) ; e.g., the table, a stack, a row, the NVidia block,
                    ;       the red block that is to the left of the blue block
    2 (((lex-ulf! det 1) (*n1-ulf-tree* 2 3 4)) (1 2)) (0 :ulf-recur)
   ; cases with no determiner:
   1 (pron) 
    2 (lex-ulf! pro 1) (0 :ulf)
   1 (degr-adv num-adj 1 noun 5) ; e.g., exactly two red blocks in a stack
    2 (((lex-ulf! adv 1) (lex-ulf! adj 2) (*n1-ulf-tree* 3 4 5))
       ((nquan (1 2)) 3)) (0 :ulf-recur)
   1 (noun 0); e.g., blocks on the table
    2 (((*n1-ulf-tree* 1 2)) (k 1)) (0 :ulf-recur)
   1 (adj noun 0); e.g., red blocks in front of you
    2 (((*n1-ulf-tree* 1 2 3)) (k 1)) (0 :ulf-recur)
   1 (adj adj noun 0); e.g., leftmost red blocks on the table
    2 (((*n1-ulf-tree* 1 2 3 4)) (k 1)) (0 :ulf-recur)
   ; Still need "There are...", "There is ..." sentence forms.

 ))


(READRULES '*n1-ulf-tree* ; premodified noun
 '(1 (noun)
    2 (lex-ulf! noun 1) (0 :ulf)
   1 (corp noun); e.g., NVidia block
    2 ((lex-ulf! name 1) (lex-ulf! noun 2)) (0 :ulf)
   1 (adj corp noun); e.g., red NVidia block ("red" is redundant, but...)
    2 ((lex-ulf! adj 1) ((lex-ulf! name 2) (lex-ulf! noun 3))) (0 :ulf)

   ; deal first with initial superlative adj's, possibly followed by another
   ; adj; then deal with 1 or two ordinary adjectices preceding the noun;
   ; then deal with postmodifiers; through this ordering, premodifiers will
   ; outscope postmodifiers:
   1 (sup-adj noun 0); e.g., highest block on the stack
    2 (((lex-ulf! sup-adj 1) (*n1-ulf-tree* 2 3)) (most-n 1 2)) (0 :ulf-recur)
   1 (sup-adj adj noun 0); e.g., highest red block on the table
    2 (((lex-ulf! sup-adj 1) (lex-ulf! adj 2) (*n1-ulf-tree* 3 4)) 
       (most-n 1 (2 3))) (0 :ulf-recur)
   ; ordinary premodifying adj's:
   1 (adj noun 0); e.g., red block that is to the left of a blue block
    2 (((lex-ulf! adj 1) (*n1-ulf-tree* 2 3)) (1 2)) (0 :ulf-recur)
   1 (adj adj noun 0); e.g., 
    2 (((lex-ulf! adj 1) (lex-ulf! adj 2) (*n1-ulf-tree* 3 4)) (1 2 3)) (0 :ulf-recur)
   ; postmodifiers (allow two, i.e., 2 PPs or a PP and a relclause (either order):
   1 (noun 1 prep 3 det 1 noun 1 prep 3 det 2); two postmodifying PPs, e.g.,
                                     ; blocks near each other on the table
    2 (((lex-ulf! noun 1) (*pp-ulf-tree* 2 3 4 5 6 7) (*pp-ulf-tree* 8 9 10 11 12)) 
       (n+preds 1 2 3)) (0 :ulf-recur)
   1 (noun 1 prep 3 det 2 that be 1 prep 3 det 2); postmodifying PP + rel-clause
    2 (((lex-ulf! noun 1) (*pp-ulf-tree* 2 3 4 5 6) that.rel (lex-ulf! v 8)
       (*pp-ulf-tree* 9 10 11 12 13)) (n+preds 1 2 (3 (4 5)))) (0 :ulf-recur)
   1 (noun 1 prep 3 det 3); postmodifying PP only 
                         ; e.g., block next to the farthest blue block
    2 (((lex-ulf! noun 1) (*pp-ulf-tree* 2 3 4 5 6)) (n+preds 1 2)) (0 :ulf-recur)
   1 (noun that be 1 prep 3 det 2); postmodifying rel-clause only
    2 (((lex-ulf! noun 1) that.rel (lex-ulf! v 3) (*pp-ulf-tree* 4 5 6 7 8))
        (n+preds 1 (2 (3 4)))) (0 :ulf-recur)
   ; PP after rel-clause might be a pred complement to "be", so we try this last:
   1 (noun that be 1 prep 3 det 1 noun 1 prep 3 det 2); postmodifying rel-clause + PP
    2 (((lex-ulf! noun 1) that.rel (lex-ulf! v 3) (*pp-ulf-tree* 4 5 6 7 8 9)
        (*pp-ulf-tree* 10 11 12 13 14)) (1 (n+preds 1 (2 (3 4)) 5))) (0 :ulf-recur)
   ; 2 rel-clauses unlikely, so hold off for now 
 )); end of *n1-ulf-tree*

; This now serves only for dealing with a PP[/NP], i.e., a PP with an NP gap,
; as in the question "What is the NVidia block on top of ?" But probably
; the *pp-ulf-tree* rules should be modified to make use of this, instead of
; duplicating the multiword propositional patterns, like "to the left of".
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

(readrules '*pp-ulf-tree*
 '(1 (prep det 2 noun); on a red block
    2 (((lex-ulf! prep 1) (*np-ulf-tree* 2 3 4)) (1 2)) (0 :ulf-recur)
   1 (prep 2 noun); on red blocks
    2 (((lex-ulf! prep 1) (*np-ulf-tree* 2 3)) (1 2)) (0 :ulf-recur)
   1 (on top of det 2 noun); on top of a red block
    2 ((on_top_of.p (*np-ulf-tree* 4 5 6)) (1 2)) (0 :ulf-recur)
   1 (on top of 2 noun); on top of red blocks
    2 ((on_top_of.p (*np-ulf-tree* 4 5)) (1 2)) (0 :ulf-recur)
   1 (to the left of det 2 noun); to the left of a red block
    2 ((to_the_left_of.p (*np-ulf-tree* 5 6 7)) (1 2)) (0 :ulf-recur) 
   1 (to the left of 2 noun); to the left of red blocks
    2 ((to_the_left_of.p (*np-ulf-tree* 5 6)) (1 2)) (0 :ulf-recur)
   1 (to the right of det 2 noun); to the right of a red block
    2 ((to_the_right_of.p (*np-ulf-tree* 5 6 7)) (1 2)) (0 :ulf-recur)
   1 (to the right of 2 noun); to the right of red blocks
    2 ((to_the_right_of.p (*np-ulf-tree* 5 6)) (1 2)) (0 :ulf-recur)
   1 (next to det 2 noun); next to the NVidia block
    2 ((next_to.p (*np-ulf-tree* 3 4 5)) (1 2)) (0 :ulf-recur)
   1 (next to 2 noun); next to red blocks
    2 ((next_to.p (*np-ulf-tree* 3 4)) (1 2)) (0 :ulf-recur)
   1 (in front of det 2 noun); in front of a red block
    2 ((in_front_of.p (*np-ulf-tree* 4 5 6)) (1 2)) (0 :ulf-recur)
   1 (in front of 2 noun); in front of red blocks
    2 ((in_front_of.p (*np-ulf-tree* 4 5)) (1 2)) (0 :ulf-recur)
   ; recurse if there's a premodifying adverb:
   1 (deg-adv prep 3 det 3 noun)
    2 (((lex-ulf! adv 1) (*pp-ulf-tree* 2 3 4 5 6)) (1 2)) (0 :ulf-recur)
   1 (deg-adv prep 3 adj 1 noun)
    2 (((lex-ulf! adv 1) (*pp-ulf-tree* 2 3 4 5 6)) (1 2)) (0 :ulf-recur)
 ))

     
(readrules '*modal-question-ulf-tree* ; ones like "Can you see the NVidia block ?
 '(1 (Sorry\, you\'re not handling modal questions yet) (0 :out)
 ))

(readrules '*wh-question-ulf-tree* ; ones like "Where is the NVidia block?
 '(1 (where be det 2 noun 0)
    2 (where be det 2 noun ?)
     3 (((lex-ulf! wh-pred 1) (lex-ulf! v 2) (*np-ulf-tree* 3 4 5) ?)
        ((sub 1 (2 3 *h)) ?)) (0 :ulf-recur)
   1 (where be there 0); interpret like a y/n-question, i.e., drop the "where"
    2 (((*yn-question-ulf-tree* 2 3 4)) 1) (0 :ulf-recur)
   1 (wh-det noun be prep 3 det 3 ?); e.g., what/which/whose block is to the left
                                   ; of the Nvidia block ?
    2 (((lex-ulf! det 1) (lex-ulf! noun 2) (lex-ulf! v 3) 
        (*pp-ulf-tree* 4 5 6 7) ?) (((1 2) (3 4)) ?)) (0 :ulf-recur)
   1 (what be prep 3 det 3 ?)
    2 ((what.pro (lex-ulf! v 2) (*pp-ulf-tree* 3 4 5 6) ?) 
       ((1 (2 3)) ?)) (0 :ulf-recur)
  1 (wh-det 1 noun be 1 prep 2 noun ?); What red blocks are (there) on blue blocks ?
    2 (((lex-ulf! det 1) (*n1-ulf-tree* 2 3) (lex-ulf! v 4) (*pp-ulf-tree* 6 7 8) ?)
        (((1 2) (3 4)) ?)) (0 :ulf-recur)
   1 (what color noun be prep 3 det 3 ?); e.g., what color block is to the left
                                        ; of the Nvidia block ? [unusual subj NP!]
    2 (((lex-ulf! det 1) (lex-ulf! adj 2) (lex-ulf! noun 3) (lex-ulf! v 4) 
       (*pp-ulf-tree* 5 6 7 8) ?) (((1 (2 3)) (4 5)) ?)) (0 :ulf-recur)
   1 (what color be the 0 ?)
    2 (((lex-ulf! det 1) (lex-ulf! noun 2) (lex-ulf! v 3) (*np-ulf-tree* 4 5))
       ((sub ({of}.p (1 2)) (3 4 *h)) ?)) (0 :ulf-recur)
   1 (wh-det noun be the 2 prep 2 prep ?); e.g., What/which block is the NVidia block
                                        ; on top of [to the left of]?
    2 (((lex-ulf! det 1) (lex-ulf! noun 2) (lex-ulf! v 3) the.d (*n1-ulf-tree* 5)
        (*rel-ulf-tree* 6 7 8) ?) ((sub (1 2) (3 (4 5) (6 *h))) ?)) (0 :ulf-recur)
   1 (wh-pron be the sup-adj 2 ?); e.g., what is the highest red block ?
    2 (((lex-ulf! pro 1) (lex-ulf! v 2) the.d (*n1-ulf-tree* 4 5) ?)
       ((1 (2 (= (the.d 4)))) ?)) (0 :ulf-recur)
   1 (wh-pron be the 2 noun prep 3 det 3 ?); e.g., what is the block next to the
                                           ; farthest blue block ?
    2 (((lex-ulf! pro 1) (lex-ulf! v 2) (*np-ulf-tree* 3 4 5 6 7 8 9) ?)
       ((1 (2 (= 3))) ?)) (0 :ulf-recur)
   1 (how many 1 block be prep 3 det 3 ?); e.g., How many blocks are on some red block ?
    2 ((how_many.d (*n1-ulf-tree* 3 4) (lex-ulf! v 5) (*pp-ulf-tree* 6 7 8 9) ?) 
       (((1 2) (3 4)) ?)) (0 :ulf-recur)
   1 (how many 1 block be 3 prep adj 3 ?); e.g., How many blocks are in front of 
                                         ;       red blocks ?
    2 ((how_many.d (*n1-ulf-tree* 3 4) (lex-ulf! v 5) (*pp-ulf-tree* 6 7 8 9) ?)
       (((1 2) (3 4)) ?)) (0 :ulf-recur)
   1 (how many 1 block be there ?)
    2 ((how_many.d (*n1-ulf-tree* 3 4) (lex-ulf! v 5) there.pro ?)
       (((1 2) (3 there.pro)) ?))  (0 :ulf-recur)
   1 (how many 1 noun 3 be adj ?); how many blocks (on the table) are red ?
    2 ((how_many.d (*n1-ulf-tree* 3 4 5) (lex-ulf! v 6) (lex-ulf! adj 7) ?)
       (((1 2) (3 4)) ?)) (0 :ulf-recur)
   1 (how many 1 block be there 3 prep det 3 ?); How many blocks are there on the table ?
    2 ((how_many.d (*n1-ulf-tree* 3 4) (lex-ulf! v 5) there.pro 
       (*pp-ulf-tree* 7 8 9 10)  ?) (((1 2) (3 there.pro 5)) ?)) (0 :ulf-recur)
   1 (how many 1 block be there 3 prep adj 3 ?); How many blocks are there on red blocks
    2 ((how_many.d (*n1-ulf-tree* 3 4) (lex-ulf! v 5) there.pro 
       (*pp-ulf-tree* 7 8 9 10) ?) (((1 2) (3 there.pro 5)) ?)) (0 :ulf-recur)
 ))


(readrules '*ppwh-question-ulf-tree* ;e.g., On (top of) what object is the NVidia block ?
 '(1 (prep 2 wh-det 2 be det 4 ?) 
    2 (((*rel-ulf-tree* 1 2) (lex-ulf! det 3) (*n1-ulf-tree* 4) (lex-ulf! v 5) 
        (lex-ulf! det 6) (*n1-ulf-tree* 7 ) ?) ((sub (1 (2 3)) (4 (5 6) *h)) ?)) 
       (0 :ulf-recur)
  ; add further rules, e.g., for "On what blocks are there other blocks ?", or
  ; "On how many blocks is the Target block resting/placed/supported/positioned ?"
 ))

; TO BE CHECKED FOR APPROPRIATENESS/ACCURACY/COMPLETENESS
(READRULES '*fallback-spatial-question-ulf-tree* ;
  ; These rules should be accessed as last resort by *spatial-question-ulf-tree*
  ; For the most part, these rules just allow for ignoring some words here and
  ; there, but there are also some reformulations (e,g., "support" relations)
 '(1 (4 where 2 det 2 block 2)
    2 (((*wh-question-ulf-tree* where is 4 5 6 ?)) (poss-ques 1)) (0 :ulf-recur)
   1 (4 where be there 0)
    2 (((*fallback-spatial-question-ulf-tree* 3 4 5)) 1) (0 :ulf-recur)
  1 (4 wh-det 2 noun be 2 prep 2 noun 2 ?);
    2 (((*wh-question-ulf-tree* 2 3 4 5 7 8 9 ?)) (poss-ques 1)) (0 :ulf-recur)
   1 (4 wh-det 1 color be det 1 block 2)
    2 (((*wh-question-ulf-tree* 2 4 5 6 7 8 ?)) (poss-ques 1)) (0 :ulf-recur)
   1 (4 wh-det 1 color 1 block be 1 prep 3 noun 2)
    2 (((*wh-question-ulf-tree* what color block is 8 9 10 11 ?)) 
       (poss-ques 1)) (0 :ulf-recur)
   1 (4 wh-pron be 2 sup-adj 2 noun 2)
    2 (((*wh-question-ulf-tree* 2 3 the 5 6 7 ?)) (poss-ques 1)) (0 :ulf-recur)
   1 (4 wh-det 2 noun be the sup-adj 2); e.g., which red block is the highest up?
    2 (((*wh-question-ulf-tree* which is the 7 3 4 ?)) (poss-ques 1)) (0 :ulf-recur)
   1 (8 sup-adj 2 noun 5); desperation rule for a superlative
    2 (((*wh-question-ulf-tree* which is the 2 3 4 ?)) (poss-ques 1)) (0 :ulf-recur) 
   1 (4 wh-pron be the 2 noun 1 be 1 prep 3 det 2 noun 5)
    2 (((*wh-question-ulf-tree* what is 4 5 6 that is 9 10 11 12 13 14 ?))
       (poss-ques 1)) (0 :ulf-recur)
   1 (4 wh-det 2 noun be 1 prep 3 det 2 noun 5)
    2 (((*wh-question-ulf-tree* which 3 4 is 6 7 8 9 10 11 ?))
       (poss-ques 1)) (0 :ulf-recur)
   1 (4 wh-det 2 noun be supporting det 2 noun 2); transform to on-relation
    2 (((*wh-question-ulf-tree* on 2 3 4 is 7 8 9 ?)) (poss-ques 1)) (0 :ulf-recur)
   1 (4 wh-det 2 noun be 1 supported by det 2 noun 2); transform to on-relation
    2 (((*wh-question-ulf-tree* 2 3 4 5 on 9 10 11 ?)) (poss-ques 1)) (0 :ulf-recur) 
   1 (2 be 1 det 2 noun 2 prep 3 det 3 noun 2)
    2 (((*yn-question-ulf-tree* 2 4 5 6 8 9 10 11 12 ?)) (poss-ques 1)) (0 :ulf-recur)
   1 (2 be pron 2 prep 3 det 3 noun 2) 
    2 (((*yn-question-ulf-tree* 2 3 5 6 7 8 9 ?)) (poss-ques 1)) (0 :ulf-recur)
   1 (2 be 1 det 2 noun 2 prep 3 pron 2)
    2 (((*yn-question-ulf-tree* 2 4 5 6 8 9 10 ?)) (poss-ques 1)) (0 :ulf-recur)
   1 (2 be det 2 noun 1 adj 2)
    2 (((*yn-question-ulf-tree* 2 3 4 5 7 ?)) (poss-ques 1)) (0 :ulf-recur)
   ; More can/should be added
   1 (0 det 2 block 0)
    2 (I\'m asking about some 3 4 \, but you didn\'t catch what it was) (0 :out)
   1 (0 det table 0)
    2 (I referred to the table\, but you didn\'t catch what I said) (0 :out)
   ; variants of begging-off responses should be added, with non-zero latency,
   ; so that the user will see a variety of such responses
 ))  
 

;  ; borrowed stuff, for reference:
;   2 *yn-question-ulf-tree* (0 :subtree)
;  1 (modal 0)      ; e.g., "Can you see the NVidia block ?
;   2 *modal-question-ulf-tree* (0 :subtree)
;  1 (wh_ 0)
;   2 *wh-question-ulf-tree* (0 :subtree)
;  1 (prep 2 wh_ 0) ; e.g., "On top of which block is the NVidia block ?"
;   2 *ppwh-question-ulf-tree* (0 :subtree)



); end of eval-when
