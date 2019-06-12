;; File for testing the initial version of the spatial QA version of LISSA
;; June 10/19
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load "/p/nl/tools/ttt/src/load"); needed: lissa6.lisp references ttt:...
(setq *use-latency* nil)
(load "lissa6.lisp")
(load "general-word-data.lisp")
(load "rules-for-spatial-questions.lisp")
(load "eval-lexical-ulfs.lisp")
(load "stem.lisp")

;; tests:
;; (setq clause '(Is the Nvidia block on the Mercedes block ?))
;; (trace choose-result-for choose-result-for1)
;; (trace instance) ; more detailed tracing
;; (trace eval-lexical-ulfs); still more detailed
;; (form-ulf-from-clause clause)
;; (setq clause '(Is there a red block on the Mercedes block ?))
;; (form-ulf-from-clause clause)
;; (setq clause '(Is there a red Nvidia block on top of the Mercedes block ?))
;; (form-ulf-from-clause clause)
;; (setq clause '(is the Mcdonalds block to the left of a red block ?))

