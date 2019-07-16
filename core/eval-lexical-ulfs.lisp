;; Code for deriving ULFs for lexical words whose category is specified   (June 10/19)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eval-lexical-ulfs (ulf)
;`````````````````````````````
; 'ulf' is an arbitrary ULF that may contain items of form 
;      (lex-ulf! <lex-cat> <part number>),
; to be replaced by atomic ULFs.
;
 (cond ((atom ulf) ulf)
       ((eq (car ulf) 'lex-ulf!)
        (eval (list (car ulf) 
                    (list 'quote (cadr ulf)) (list 'quote (caddr ulf)))))
       (t (cons (eval-lexical-ulfs (car ulf)) (eval-lexical-ulfs (cdr ulf))))
 )); end of eval-lexical-ulfs


(defun lex-ulf! (cat word-sym)
;`````````````````````````````
; Construct a ulf of the appropriate type out of 'word-sym' (a symbol such
; as MERCEDES, ARE, ON-TOP-OF), given the lexical category (such as NAME,
; V, or P); **this version is intended for very limited experimental use;
;
; Make sure 'stem' program is available:
 (if (not (fboundp 'stem)) (load "stem.lisp"))

 (let ((word-str (string word-sym)) stem)
      (case cat
         (name (case word-sym
                  (ADIDAS '|Adidas|)
                  (BURGER_KING '|Burger King|)
                  (ESSO '|Esso|)
                  (HEINEKEN '|Heineken|)
                  (HP '|HP |)
                  (MCDONALDS '|McDonalds|)
                  (MERCEDES '|Mercedes|)
                  (NVIDIA '|NVidia|)
                  (PEPSI '|Pepsi|)
                  (SRI '|SRI |)
                  (STARBUCKS '|Starbucks|)
                  (TEXACO '|Texaco|)
                  (TARGET '|Target|)
                  (TOYOTA '|Toyota|)
                  (SHELL  '|Shell|)
                  (TWITTER '|Twitter|)
                  (t (if (< (length word-str) 4)
                         (intern (format nil "~a " word-sym)); NB: final blank
                         (intern (capitalize (string-downcase word-sym)))))))
         (pro (intern (format nil "~a.PRO" word-sym)))
         (punc word-sym)
         (nn ; known to be singular 
             (intern (format nil "~a.N" word-sym)))
         (nns ; known to be plural
             (setq stem (stem (list 'nns word-sym)));
             (list 'plur (intern (format nil "~a.N" stem))))
         ((n noun) (case word-sym
                     (block 'block.n) (blocks '(plur block.n))
                     (cube 'block.n)  (cubes '(plur block.n))
                     (book 'block.n)  (books '(plur block.n))
                     (blog 'block.n)  (blogs '(plur block.n))
                     (black 'block.n) (blacks '(plur block.n))
                     (glock 'block.n) (glocks '(plur block.n))
                     (bach 'block.n)  (bachs '(plur block.n))
                     (blood 'block.n) (bloods '(plur block.n))
                     (look 'block.n)  (looks '(plur block.n))
                     (glass 'block.n) (box '(plur block.n))
                     (t (setq stem (stem (list 'n word-sym))); tries to depluralize
                        (if (eq stem word-sym); assume singular if unchanged
                                              ; (somewhat error-prone)
                            (intern (format nil "~a.N" word-sym))
                            (list 'plur (format nil "~a.N" stem))))))
         ((p prep) (intern (format nil "~a.P" word-sym)))
         ((d det) (intern (format nil "~a.D" word-sym)))
         ; ** Here we should insert cases where the verb is known to be of
         ;    type (POS) VBZ, VBD, VB, VBG, VBN, VBEN; this is a generic stub:
         ((v verb) (case word-sym
                     ((is are) '(pres be.v)) (be 'be.v) ((was were) '(past be.v))
                     ((support supports) '(pres support.v))
                     (supported '(past support.v))
                     (t (intern (format nil "~a.V" word-sym)))))
         (wh-pred (case word-sym
                     (where '(at.p (what.d place.n)))
                     (when '(at.p (what.d time.n)))
                     (t (intern (format nil "~a.ADV" word-sym)))))
         ((a adj) (intern (format nil "~a.A" word-sym)))
         (sup-adj (case word-sym
                    (leftmost 'left.a) (rightmost 'right.a)
                    ((furthest farthest) 'far.a) (nearest 'near.a)
                    (closest 'close.a) (highest 'high.a) (tallest 'tall.a)
                    (nearest 'near.a) (topmost 'top.a) (uppermost 'upper.a)
                    (smallest 'small.a) (lowest 'low.a) (largest 'large.a)
                    (centermost 'centered.a) (shortest 'short.a) (backmost 'back.a)
                    (longest 'long) (fewest few.a) (frontmost front.a)
                    (t (intern (format nil "~a.A" (stem-superlative word-sym))))))
         (adv (intern (format nil "~a.ADV-A" word-sym))) )
 )); end of lex-ulf!)
                   

(defun stem-superlative (sup-adj); tested
;```````````````````````````````
; Find stem of superlative adjective; this is a stub, intended as default
; when word-specific stems have not been found in the calling program;
; only a simple check whether the stem probably shouldn't have a doubled
; up final consonant is made.
;
; sup-adj: an upper-case symbolic atom such as 'biggest', "smartest', etc.
; 
 (let ((str (string-upcase (string sup-adj))) n)
      (setq n (length str))
      (setq str (subseq str 0 (- n 3)))
      (if (member (subseq str (- n 5) (- n 3)) 
                   '("BB" "DD" "GG" "NN" "PP" "TT") :test 'string=)
          (setq str (subseq str 0 (- n 4))))
      (intern str)
 )); end of stem-superlative


(defun capitalize (str); tested
;``````````````````````
; Return variant of str with first letter upper case; 
; assumes 1st character of str is alphabetic;
;
 (concatenate 'string (string-upcase (subseq str 0 1))
                      (subseq str 1 (length str))))

               

