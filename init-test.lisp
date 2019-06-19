;; File for testing the initial version of the spatial QA version of LISSA
;; June 10/19
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load "ttt/src/load"); needed: lissa6.lisp references ttt:...
(setq *use-latency* nil)
(setq *count* 0)
(load "core/lissa6.lisp")
(load "core/general-word-data.lisp")
;(load "rules-for-spatial-questions.lisp")
;(load "rules-for-spatial-questions-v2.lisp")
(load "rules-for-spatial-questions.lisp"); this sets *spatial-question-ulf-tree*
                                            ; in lissa6.lisp, 'form-ulf-from-clause';
                                            ; If changing the root for spatial 
                                            ; question interpretation, be sure to 
                                            ; edit 'form-ulf-from-clause'
(load "core/eval-lexical-ulfs.lisp")
(load "core/stem.lisp")

;; tests:
;; (setq clause '(Is the Nvidia block on the Mercedes block ?))
;; (trace choose-result-for choose-result-for1)
;; (trace instance) ; more detailed tracing
;; (trace eval-lexical-ulfs); still more detailed
;; (trace match lex-ulf!); full (& usually most useful) details
;;
;; (setq clause '(Is there a red block on the Mercedes block ?)); 
;;  Tracing choose-result-for and lex-ulf! now gives something weird for the
;; above sentence:
;; ...
;   2[2]: (CHOOSE-RESULT-FOR ((MERCEDES CORP) (BLOCK NOUN))
;                             *N1-ULF-TREE*)
;      3[2]: (LEX-ULF! NAME MERCEDES)
;      3[2]: returned |Mercedes|
;      3[2]: (LEX-ULF! NOUN BLOCK)
;      3[2]: returned BLOCK.N
;    2[2]: returned ((|Mercedes| BLOCK.N) (MERCEDES BLOCK))
;; ...

;; **ALL THIS REMAINS TO BE RECHECKED, AFTER MAJOR REVISIONS...
;; (setq clause '(Is there a red Nvidia block on top of the Mercedes block ?)); ok
;; (setq clause '(is the Mcdonalds block to the left of a red block ?)); ok
;; (setq clause '(Is there anything behind the NVidia block ?)); ok
;; (setq clause '(Are the two green blocks touching ?)); ok
;; (setq clause '(are there two green blocks on the table that are near each other ?))
                                                                          ; ok  
;; (setq clause '(are there any clear blocks on the table ?)); ok
;; (setq clause '(which block is the mercedes block on top of ?)); ok
;; (setq clause '(What block is to the left of the Burger King block ?)); fails
                                               ; because "Burger King" is 2 words
;; (setq clause '(What block is to the left of the Burger_King block ?)); ok 
;; (setq clause '(Is the nvidia block visible ?)); ok

;; (setq clause '(Where is the NVidia block ?)); ok
;; (setq clause '(what is the highest red block ?))
;; (setq clause '(What color block is to the left of the NVidia block ?)); ok
;;                     ``````````` interpreted as (color.a block.n)
;; (setq clause '(What is the block next to the farthest blue block ?)); ok

;;
;; (format t "~s" (form-ulf-from-clause clause))



;; Some results: 'PLUR' fixed
;; are there two green blocks on the table that are near each other ?
;; (Initial quotes so as not to freak the Lisp reader when loading this file)
'(((PRES BE.V) THERE.PRO
  (TWO.D
   (N+PREDS (GREEN.A (PLUR BLOCK.N)) (ON.P (THE.D TABLE.N))
    (THAT.REL ((PRES BE.V) (NEAR.P (EACH.D OTHER.N)))))))
 ?)

;; are there any clear blocks on the table ?
'(((PRES BE.V) THERE.PRO (ANY.D (CLEAR.A (PLUR BLOCK.N)))
  (ON.P (THE.D TABLE.N)))
 ?)

;; Where is the Nvidia block ?
'((SUB (AT.P (WHAT.D PLACE.N))
  ((PRES BE.V) (THE.D |NVidia| BLOCK.N) *H))
 ?)

;; What is the highest red block ?
'((WHAT.PRO ((PRES BE.V) (THE.D (MOST-N HIGH.A (RED.A BLOCK.N))))) ?)

;; What is the block next to the farthest blue block ?
'((WHAT.PRO
  ((PRES BE.V)
   (THE.D
    (N+PREDS BLOCK.N
     (NEXT_TO.P (THE.D (MOST-N FAR.A (BLUE.A BLOCK.N))))))))
 ?)
