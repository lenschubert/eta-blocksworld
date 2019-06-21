;; File for testing example rule files
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; NOTES:
;; ' IS THERE A GREEN BLOCK BETWEEN THE HIGHEST RED BLOCK AND THE NVIDIA BLOCK ?' fails
;; 'HOW MANY RED BLOCKS ARE ON THE NVIDIA BLOCK ?' fails

;; Load ttt and core Lissa functions
(load "ttt/src/load")
(defparameter *use-latency* nil)
(defparameter *count* 0)
(load "core/lissa6.lisp")
(load "core/general-word-data.lisp")
(load "core/eval-lexical-ulfs.lisp")
(load "core/stem.lisp")
(load "rules/choose-clause-ulf-tree.lisp")
(load "rules/spatial-question/rules-for-spatial-question-ulf.lisp")

;; Prompt for verbose printing
(defparameter *verbose* nil)
(format t "~%~%~%~%~%~%~%~%~%")
(princ "verbose (t or nil) ?: ") (finish-output)
(setq *verbose* (if (equalp (write-to-string (read)) "t") t nil))

(defun get-ulf (query)
;````````````````````````````
; Gets ulf from query
;
  (form-ulf-from-clause (append '(Spatial question \:) query)))


(defun test-ulf (query answer)
;````````````````````````````
; Test whether the ulf extracted for a
; given query is equivalent to a given answer
;
  (let ((ulf (get-ulf query)))
    (if *verbose* (format t "> The extracted ulf is:~%: ~a~%> The correct ulf is:~%: ~a~%" ulf answer))
    (equalp answer ulf)))


(defun run-tests (tests)
;``````````````````````````````
; Runs a list of tests ((query answer) pairs),
; returns the number of tests where the correct pattern
; is extracted (check gist or ulf depending on 'gist?'),
; and prints which queries fail
; 
  (let ((n (length tests)) (i 0))
    (dolist (ti tests)
      (if *verbose*
        (format t "Testing: ~a~%``````````````````````````````````````~%" ti))
      (if (test-ulf (first ti) (third ti))
        (setf i (1+ i))
        (format t "Test failed: ~a~%~%~%" (first ti))))
  (format t "Number tests passed: ~a/~a~%" i n)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Run all the tests here, depending on if we're testing gist clause
; extraction or ulf extraction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(run-tests
;```````````````````````````````````````````````````````````
; ULF tests
; Theme: Blocksworld queries to ULF
;
  '(
    ((Is the Nvidia block on the
      Mercedes block ?)                    => (((PRES BE.V) (THE.D (|NVidia| BLOCK.N))
                                                (ON.P (THE.D (|Mercedes| BLOCK.N)))) ?))
    ((Is there a red block on the
      Mercedes block ?)                    => (((PRES BE.V) THERE.PRO (A.D (RED.A BLOCK.N))
                                               (ON.P (THE.D (|Mercedes| BLOCK.N)))) ?))
    ((Is there a red Nvidia block on top
      of the Mercedes block ?)             => (((PRES BE.V) THERE.PRO (A.D (RED.A (|NVidia| BLOCK.N)))
                                                (ON_TOP_OF.P (THE.D (|Mercedes| BLOCK.N)))) ?))
    ((Is the Mcdonalds block to the left
      of a red block ?)                    => (((PRES BE.V) (THE.D (|McDonalds| BLOCK.N))
                                                (TO_THE_LEFT_OF.P (A.D (RED.A BLOCK.N)))) ?))
    ((Is there a green block under the
      blue block ?)                        => (((PRES BE.V) THERE.PRO (A.D (GREEN.A BLOCK.N))
                                                (UNDER.P (THE.D (BLUE.A BLOCK.N)))) ?))
    ;----------------------------------------------------------------------------------------------;
    ((Is there a green block above the
      blue block ?)                        => (((PRES BE.V) THERE.PRO (A.D (GREEN.A BLOCK.N))
                                                (ABOVE.P (THE.D (BLUE.A BLOCK.N))))))
    ((Is there a green block on top of
      the other green block ?)             => (((PRES BE.V) THERE.PRO (A.D (GREEN.A BLOCK.N))
                                                (ON_TOP_OF.P (THE.D (OTHER.A (GREEN.A BLOCK.N))))) ?))
    ((Is the Nvidia block on the table ?)  => (((PRES BE.V) (THE.D (|NVidia| BLOCK.N))
                                                (ON.P (THE.D TABLE.N))) ?))
    ((Is there a green block between a red
      block and the SRI block ?)           => (((PRES BE.V) (A.D (GREEN.A BLOCK.N)) (BETWEEN.P
                                                ((A.D (RED.A BLOCK.N)) AND.CC (THE.D (|SRI| BLOCK.N))))) ?))
    ((Is the Starbucks block above two
      blue blocks ?)                       => (((PRES BE.V) (THE.D (|Starbucks| BLOCK.N)) (ABOVE.P
                                                (TWO.D (BLUE.A (PLUR BLOCK.N))))) ?))
    ((Is the block above the Texaco block
      red ?)                               => (((PRES BE.V) (THE.D (N+PREDS BLOCK.N (ABOVE.P (THE.D (|Texaco|
                                                BLOCK.N))))) RED.A) ?))
    ((Is the block above the Texaco block
      a green block ?)                     => (((PRES BE.V) (THE.D (N+PREDS BLOCK.N (ABOVE.P (THE.D (|Texaco|
                                                BLOCK.N))))) (= (A.D (GREEN.A) (BLOCK.N)))) ?))
    ((Is the block below the Toyota block
      on top of a red block ?)             => (((PRES BE.V) (THE.D (N+PREDS BLOCK.N (BELOW.P (THE.D (|Toyota|
                                                BLOCK.N))))) (ON_TOP_OF.P (A.D (RED.A BLOCK.N)))) ?))
    ((Is there a red block under the blue
      block that is under the SRI block ?) => (((PRES BE.V) THERE.PRO (A.D (RED.A BLOCK.N)) (UNDER.P (THE.D
                                                (N+PREDS (BLUE.A BLOCK.N) (THAT.REL ((PRES BE.V) (UNDER.P
                                                (THE.D (|SRI| BLOCK.N))))))))) ?))
    ((Is the uppermost green block on top
      of the Starbucks block ?)            => (((PRES BE.V) (THE.D (UPPERMOST.A (GREEN.A BLOCK.N)))
                                                (ON_TOP_OF.P (THE.D (|Starbucks| BLOCK.N)))) ?))
  )
)
