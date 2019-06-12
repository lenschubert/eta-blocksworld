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
                  (BURGER_KING '|Burger King|)
                  (MCDONALDS '|McDonalds|)
                  (MERCEDES '|Mercedes|)
                  (NVIDIA '|NVidia|)
                  (SRI '|SRI |)
                  (STARBUCKS '|Starbucks|)
                  (TEXACO '|Texaco|)
                  (TARGET '|Target|)
                  (TOYOTA '|Toyota|)
                  (t (if (< (length word-str) 4)
                         (intern (format nil "~a " word-sym)); NB: final blank
                         (intern (capitalize (string-downcase word-sym)))))))
         (punc word-sym)
         (nn ; known to be singular 
             (intern (format nil "~a.N" word-sym)))
         (nns ; known to be plural
             (setq stem (stem (list 'nns word-sym)));
             (list 'plur (intern (format nil "~a.N" stem))))
         ((n noun) (case word-sym
                     (block 'block.n) (blocks '(plur block.n))
                     (cube 'block.n) (cubes '(plur block.n))
                     (book 'block.n) (books '(plur block.n))
                     (blog 'block.n) (blogs '(plur block.n))
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
         ((a adj) (intern (format nil "~a.A" word-sym))))
 )); end of lex-ulf!
                   

(defun capitalize (str); tested
;``````````````````````
; Return variant of str with first letter upper case; 
; assumes 1st character of str is alphabetic;
;
 (concatenate 'string (string-upcase (subseq str 0 1))
                      (subseq str 1 (length str))))

               

