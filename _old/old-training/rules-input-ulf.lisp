;; ULF extraction
;; ulf-recur and ulf directives
;;
;; Blocksworld queries to ULF

(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
    (corp Burger_King McDonalds Mercedes NVidia SRI Starbucks
      Texaco Target Toyota)
    ; Here is where we can account for common ASR mistakes, e.g. "block" vs. "blog"
    (block blocks cube cubes book books blog blogs)
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

    ;; ============================
    ;; TODO: ADD MORE FEATURES HERE
    ;; ============================

  ))


  ; This is (currently) the "root" for ULF transduction. In the core Lissa
  ; code, after a gist clause is extracted from user input, the gist clause
  ; is in turn supplied to this choice packet in order to extract a ULF. In
  ; the future, we will need to add a higher level on top of this which branches
  ; to different choice packets depending on whether the input is a yes-no question,
  ; wh- question, assertion, request, etc.
  (READRULES '*yn-question-ulf-tree*
  '(
    1 (be det 2 block 0)
       ; | We want to carefully construct hierarchies here to minimize the
       ; | amount of backtracking we need to do. In this case, after matching
       ; | something like "is there a red block ...", we want to check if the
       ; | prompt is specifically something like "is there a red block on top
       ; | of the green block", or if it's something else (to be constructed).
       ; V
      2 (be det 2 block prep 3 det 3 ?)
          ; | Constituents headed with 'lex-ulf!' are processed into ULF
          ; | externally, depending on the lexical category ('v' i.e. verb
          ; | in this case), and the word symbol.
          ; V
        3 (((lex-ulf! v 1) (*np-ulf-tree* 2 3 4) (*rel-ulf-tree* 5 6)
            ; | Constituents headed with a subtree (*np-ulf-tree* in this case)
            ; | are independently passed to seperate subtrees, where ULF
            ; | transduction continues recursively, using the rest of the
            ; | reassembly pattern (in this case, whatever was matched to
            ; | "det 3" in the above pattern) as input.
            ; V
            (*np-ulf-tree* 7 8) (lex-ulf! punc 9))
              ; | The final necessary component of a :ulf-recur rule is a
              ; | pattern showing how the processed ULF segments should be recombined
              ; | and bracketed. Here, the numbers correspond to the constituents
              ; | in the reassembly pattern, in the order that they occur (i.e.
              ; | the '1' corresponds to (lex-ulf! v 1)).
              ; V
              ((1 2 (3 4)) 5)) (0 :ulf-recur)

    1 (be there det 0)
      2 (be there det 2 block prep 3 det 3 ?)
        3 (((lex-ulf! v 1) there.pro (*np-ulf-tree* 3 4 5) 
          (*rel-ulf-tree* 6 7) (*np-ulf-tree* 8 9) (lex-ulf! punc 10))
          ((1 2 3 (4 5)) 6)) (0 :ulf-recur) 

    ;; ==========================
    ;; TODO: ADD MORE RULES HERE
    ;; ==========================

  ))


  ; This subtree matches a noun phrase. Currently this supports things like
  ; "the block", "the green block", "the red Nvidia block", "the SRI block", etc.
  (READRULES '*np-ulf-tree* 
  '(
    1 (det block) 
       ; | A :ulf rule (as opposed to :ulf-recur) signifies that a transduction
       ; | path has "bottomed out", so a final ulf segment is formed and propagated
       ; | back up to the reassembly pattern which lead to this subtree.
       ; V
      2 ((lex-ulf! det 1) block.n) (0 :ulf)
    1 (det adj 3)
       ; In this case, we have a |
       ; noun with premodifiers, |
       ; so we need to further   |
       ; recur to the n1 subtree |
       ;                         V
      2 (((lex-ulf! det 1) (*n1-ulf-tree* 2 3)) (1 2)) (0 :ulf-recur)

    1 (det corp block) 
      2 ((lex-ulf! det 1) ((lex-ulf! name 2) block.n)) (0 :ulf)
  ))


  ; This subtree matches a premodified noun (e.g. "green block").
  (READRULES '*n1-ulf-tree* 
  '(
    1 (adj block) 
      2 ((lex-ulf! adj 1) block.n) (0 :ulf)
    1 (adj adj block) 
      2 ((lex-ulf! adj 1) (lex-ulf! adj 2) block.n) (0 :ulf)
    1 (corp block)
      2 ((lex-ulf! name 1) block.n)  (0 :ulf)
    1 (adj corp block)
      2 ((lex-ulf! adj 1) ((lex-ulf! name 2) block.n)) (0 :ulf)
  ))


  ; This subtree matches prepositional phrases (i.e. relational
  ; phrases) such as "on", "on top of", "to the right of", etc.
  (READRULES '*rel-ulf-tree*
  '(
    1 (prep) 
      2 (lex-ulf! prep 1) (0 :ulf)
    1 (on top of)
      2 on_top_of.p (0 :ulf)
    1 (to the left of)
      2 to_the_left_of.p (0 :ulf)
    1 (to the right of)
      2 to_the_right_of.p (0 :ulf)
    1 (next to)
      2 next_to.p (0 :ulf)
    1 (in front of)
      2 in_front_of.p (0 :ulf)
  ))

  ;; ============================
  ;; TODO: ADD MORE SUBTREES HERE
  ;;       (as necessary)
  ;; ============================

); end of eval-when
     
