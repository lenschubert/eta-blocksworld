;;
;; Special requests (e.g. pause, quit)
;; 

(MAPC 'ATTACHFEAT
        '((moment second minute bit)
          (finished-word it all everything)))

(READRULES '*specific-answer-from-request-input*
'(
  1 (bye 0)
    2 ((Goodbye \.)) (0 :gist)
  1 (goodbye 0)
    2 ((Goodbye \.)) (0 :gist)
  1 (0 that is finished-quant 0)
    2 ((Goodbye \.)) (0 :gist)
  1 (0 pause 0)
    2 ((Pause for a moment \.)) (0 :gist)
  1 (0 stop for 1 moment 0)
    2 ((Pause for a moment \.)) (0 :gist)
  1 (0 give 2 moment 0)
    2 ((Pause for a moment \.)) (0 :gist)
  1 (0 take 1 break 0)
    2 ((Pause for a moment \.)) (0 :gist)
  1 (David 1 stop 0)
    2 ((Pause for a moment \.)) (0 :gist)
  1 (David)
    2 ((Resume \.)) (0 :gist)
  1 (0 resume 0)
    2 ((Resume \.)) (0 :gist)
))