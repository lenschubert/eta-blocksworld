
;; fast start-up: with this file, we can use
;;   (load "start-lissa5.lisp") or (load "start-lissa5")
;;   (lissa t)
;; to get under way
(load "lissa5-schema.lisp"); schematic dialog steps
(load "choose-gist-clause-trees-for-input.lisp")
(load "choose-reaction-to-input.lisp")
(load "rules-for-householdChores-today-input")
(load "rules-for-householdChore-enjoy-input")
(load "rules-for-householdChore-help-others-input")

(format t "~%~%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ~
             ~% TO RUN LISSA IN PRINT-MODE OR TALK-MODE, USE RESPECTIVE CALLS
             ~%           (lissa nil)    (lissa t)
             ~%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ~
             ~% ALSO NOTE: For inhibiting repetitive outputs via latency, do ~
             ~%            (setq *use-latency* T) ~
             ~% THOUGH THAT'S NOT RECOMMENED IN THE LISSA DEVELOPMENT PHASE
             ~%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
        


; activate one of the following code lines:
(lissa *mode*) ; for one round
;(mainLoop)  ; for repeated round
