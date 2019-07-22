;; *ETA-SCHEMA*: development version 6
;;
;; Dialogue for blocksworld conversation 
;; (intro + 30 questions +  outro)
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *eta-schema*

'(Event-schema (((set of me you) have-eta-dialog.v) ** ?e)
;```````````````````````````````````````````````````````````
; Blocksworld conversation. This consists of one or two "getting
; to know you" type questions, followed by a series of 10 questions.
;

:Actions 

;; ?a1. (Me say-to.v you 
;;       '(Hi I am David\. I\'m here to help answer some spatial questions for you\.
;;         Please try to speak as clearly as possible\. If you wish to quit at any time\, just say bye or goodbye\.))

?a1. (Me say-to.v you 
      '(Hi\, my name is David\. I\'m ready to answer your spatial questions\.))

;; ?a2. (Me say-to.v you 
;;       '(Before we begin\, would you mind telling me what your name is?))

;; ?a3. (You reply-to.v ?a2.)

;; ?a4. (Me react-to.v ?a3.)

; 1
?a5. (Me say-to.v you
      '(Do you have a spatial question for me?))

?a6. (You reply-to.v ?a5.)

?a7. (Me react-to.v ?a6.)

; 2
?a8. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a9. (You reply-to.v ?a8.)

?a10. (Me react-to.v ?a9.)

; 3
?a11. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a12. (You reply-to.v ?a11.)

?a13. (Me react-to.v ?a12.)

; 4
?a14. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a15. (You reply-to.v ?a14.)

?a16. (Me react-to.v ?a15.)

; 5
?a17. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a18. (You reply-to.v ?a17.)

?a19. (Me react-to.v ?a18.)

; 6
?a20. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a21. (You reply-to.v ?a20.)

?a22. (Me react-to.v ?a21.)

; 7
?a23. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a24. (You reply-to.v ?a23.)

?a25. (Me react-to.v ?a24.)

; 8
?a26. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a27. (You reply-to.v ?a26.)

?a28. (Me react-to.v ?a27.)

; 9
?a29. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a30. (You reply-to.v ?a29.)

?a31. (Me react-to.v ?a30.)

; 10
?a32. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a33. (You reply-to.v ?a32.)

?a34. (Me react-to.v ?a33.)

; 11
?a35. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a36. (You reply-to.v ?a35.)

?a37. (Me react-to.v ?a36.)

; 12
?a38. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a39. (You reply-to.v ?a38.)

?a40. (Me react-to.v ?a39.)

; 13
?a41. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a42. (You reply-to.v ?a41.)

?a43. (Me react-to.v ?a42.)

; 14
?a44. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a45. (You reply-to.v ?a44.)

?a46. (Me react-to.v ?a45.)

; 15
?a47. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a48. (You reply-to.v ?a47.)

?a49. (Me react-to.v ?a48.)

; 16
?a50. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a51. (You reply-to.v ?a50.)

?a52. (Me react-to.v ?a51.)

; 17
?a53. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a54. (You reply-to.v ?a53.)

?a55. (Me react-to.v ?a54.)

; 18
?a56. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a57. (You reply-to.v ?a56.)

?a58. (Me react-to.v ?a57.)

; 19
?a59. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a60. (You reply-to.v ?a59.)

?a61. (Me react-to.v ?a60.)

; 20
?a62. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a63. (You reply-to.v ?a62.)

?a64. (Me react-to.v ?a63.)

; 21
?a65. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a66. (You reply-to.v ?a65.)

?a67. (Me react-to.v ?a66.)

; 22
?a68. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a69. (You reply-to.v ?a68.)

?a70. (Me react-to.v ?a69.)

; 23
?a71. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a72. (You reply-to.v ?a71.)

?a73. (Me react-to.v ?a72.)

; 24
?a74. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a75. (You reply-to.v ?a74.)

?a76. (Me react-to.v ?a75.)

; 25
?a77. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a78. (You reply-to.v ?a77.)

?a79. (Me react-to.v ?a78.)

; 26
?a80. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a81. (You reply-to.v ?a80.)

?a82. (Me react-to.v ?a81.)

; 27
?a83. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a84. (You reply-to.v ?a83.)

?a85. (Me react-to.v ?a84.)

; 28
?a86. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a87. (You reply-to.v ?a86.)

?a88. (Me react-to.v ?a87.)

; 29
?a89. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a90. (You reply-to.v ?a89.)

?a91. (Me react-to.v ?a90.)

; 30
?a92. (Me say-to.v you
      '(Do you have another spatial question for me?))

?a93. (You reply-to.v ?a92.)

?a94. (Me react-to.v ?a93.)


;; ?a95. (Me say-to.v you
;;         '(Excellent questions\, but unfortunately all that
;;           thinking has been very tiring\, so I need to take a break now\.))

?a95. (Me say-to.v you
        '(Excellent questions\, but I need to take a break now\.))

)); end of defparameter *eta-schema*






(setf (get '*eta-schema* 'semantics) (make-hash-table))
;````````````````````````````````````````````````````````
; EL Semantics - Not yet used
;
(defun store-output-semantics (var wff schema-name)
  (setf (gethash var (get schema-name 'semantics)) wff)
); end of store-output-semantics

(mapcar #'(lambda (x)
      (store-output-semantics (first x) (second x) '*eta-schema*))
  '()
); end of mapcar #'store-output-semantics




(setf (get '*eta-schema* 'gist-clauses) (make-hash-table))
;````````````````````````````````````````````````````````
; Gist clauses
;
(defun store-output-gist-clauses (var clauses schema-name)
  (setf (gethash var (get schema-name 'gist-clauses)) clauses)
); end of store-output-gist-clauses

(mapcar #'(lambda (x) 
      (store-output-gist-clauses (first x) (second x) '*eta-schema*))
  '(
    ;; (?a2.  ((what is your name ?)))
    (?a5.  ((do you have a spatial question ?)))
    (?a8.  ((do you have a spatial question ?)))
    (?a11. ((do you have a spatial question ?)))
    (?a14. ((do you have a spatial question ?)))
    (?a17. ((do you have a spatial question ?)))
    (?a20. ((do you have a spatial question ?)))
    (?a23. ((do you have a spatial question ?)))
    (?a26. ((do you have a spatial question ?)))
    (?a29. ((do you have a spatial question ?)))
    (?a32. ((do you have a spatial question ?)))
    (?a35. ((do you have a spatial question ?)))
    (?a38. ((do you have a spatial question ?)))
    (?a41. ((do you have a spatial question ?)))
    (?a44. ((do you have a spatial question ?)))
    (?a47. ((do you have a spatial question ?)))
    (?a50. ((do you have a spatial question ?)))
    (?a53. ((do you have a spatial question ?)))
    (?a56. ((do you have a spatial question ?)))
    (?a59. ((do you have a spatial question ?)))
    (?a62. ((do you have a spatial question ?)))
    (?a65. ((do you have a spatial question ?)))
    (?a68. ((do you have a spatial question ?)))
    (?a71. ((do you have a spatial question ?)))
    (?a74. ((do you have a spatial question ?)))
    (?a77. ((do you have a spatial question ?)))
    (?a80. ((do you have a spatial question ?)))
    (?a83. ((do you have a spatial question ?)))
    (?a86. ((do you have a spatial question ?)))
    (?a89. ((do you have a spatial question ?)))
    (?a92. ((do you have a spatial question ?)))
  )
); end of mapcar #'store-output-gist-clauses




(setf (get '*eta-schema* 'topic-keys) (make-hash-table))
;````````````````````````````````````````````````````````
; Topic keys
;
(defun store-topic-keys (var keys schema-name)
  (setf (gethash var (get schema-name 'topic-keys)) keys)
); end of store-topic-keys

(mapcar #'(lambda (x) 
      (store-topic-keys (first x) (second x) '*eta-schema*))
  '(
    ;; (?a2.  (name))
    (?a5.  (spatial-question1))
    (?a8.  (spatial-question2))
    (?a11. (spatial-question3))
    (?a14. (spatial-question4))
    (?a17. (spatial-question5))
    (?a20. (spatial-question6))
    (?a23. (spatial-question7))
    (?a26. (spatial-question8))
    (?a29. (spatial-question9))
    (?a32. (spatial-question10))
    (?a35. (spatial-question11))
    (?a38. (spatial-question12))
    (?a41. (spatial-question13))
    (?a44. (spatial-question14))
    (?a47. (spatial-question15))
    (?a50. (spatial-question16))
    (?a53. (spatial-question17))
    (?a56. (spatial-question18))
    (?a59. (spatial-question19))
    (?a62. (spatial-question20))
    (?a65. (spatial-question21))
    (?a68. (spatial-question22))
    (?a71. (spatial-question23))
    (?a74. (spatial-question24))
    (?a77. (spatial-question25))
    (?a80. (spatial-question26))
    (?a83. (spatial-question27))
    (?a86. (spatial-question28))
    (?a89. (spatial-question29))
    (?a92. (spatial-question30))
  )
); end of mapcar
