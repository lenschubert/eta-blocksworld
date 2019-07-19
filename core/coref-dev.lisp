;; July 18/19 
;; ================================================
;;
;; A module for resolving coreferences (currently in
;; development)
;;
;; TODO: The approach that I have is extremely hacky and a bit
;; ad-hoc. It needs to be replaced by a more rigorous approach
;; such as using discourse representation structures, centering
;; theory, etc.
;;
;; Some example sentence sequences that this seems to work
;; correctly on now:
;;
;; Is the Texaco block above the Nvidia block?
;; Is it below [that block]/[it]?
;;
;; Is the Texaco block above the Nvidia block?
;; Is it above the Starbucks block?
;; Is it above the SRI block?
;;


(defun ref? (sym)
; ``````````````````
; Predicate to check if a symbol is a reference to something previously
; in the conversation.
; TODO: Need a general way to detect references.
;
  (or
    (pron? sym)
    (equal sym '(THAT.D BLOCK.N))
    (equal sym '(THAT.D ONE.N))
    (equal sym '(THOSE.D (PLUR BLOCK.N)))
    (equal sym '(THOSE.D (PLUR ONE.N))))
) ; END ref?



(defun pron? (sym)
; ``````````````````
; Predicate to check if a symbol is a pronoun. For now, we exclude
; existential there.pro from this.
;
  (and
    (symbolp sym)
    (not (equal sym 'THERE.PRO))
    (> (length (string sym)) 4)
    (equal (implode (last (explode (string sym)) 4)) '.PRO))
) ; END pron?



(defun definite-np? (ulf)
; `````````````````````````
; Check if a noun phrase is a definite noun phrase, i.e. if we should
; introduce a discourse entity that may be referred to by a future reference.
;
; TODO: This categorization doesn't make much sense currently. Indefinite articles
; like "a red block" should also introduce discourse entities, but these are also less
; commonly referred to in future spatial questions,
; e.g. "Is a red block on top of the Nvidia block ?"
;      "Is a blue block on top of it ?"
; The "it" here most plausibly refers to the Nvidia block, not the red block.
; There is another issue here too, if instead the follow-up question was
; "Is a blue block on top of that block ?", then it would plausibly refer to the
; red block from the previous question. However, currently I treat "that block" and "it"
; synonymously, indefinite noun phrases aren't stored as discourse entities, and there's no
; way to incorporate the additional information about the block referred to by "a red block"
; if, for example, the system's response was "Yes, the Nvidia block."
;
  (and
    (listp ulf)
    (symbolp (car ulf))
    (or
      (equal (car ulf) 'THE.D)
      (equal (car ulf) 'K)
      (equal (car ulf) 'SET-OF)))
) ; END definite-np?



(defun plur? (np)
; `````````````````
; Check if a noun phrase is plural or not. If it uses a set-of operator, or has a plur operator
; nested somewhere (although we need to be careful not to count as plural if an n+preds with a plural
; in the postmodifier), then it is counted as plural.
;
  (or
    (equal (first np) 'SET-OF)
    (and (member (first np) '(K THE.D)) (listp (second np))
      (or
        (equal (first (second np)) 'PLUR)
        (if (member-if (lambda (x) (and (listp x) (equal (car x) 'PLUR))) (second np)) t)
      )))
) ; END plur?



(defun sing? (np)
; ```````````````````
; Check if singular. If not plural, we count it as singular.
;
  (not (plur? np))
) ; END sing?



(defun update-de-list (ulf)
; ```````````````````````````
; Updates the list of discourse-entities by traversing ulf in depth-first order
; (but reversed, so the subject is given preference over the object). When a definite
; noun phrase is encountered, add it to the front of the discourse-entities list (or if
; it already exists in the list, bring it to the front).
;
  (cond
    ((definite-np? ulf)
      (if *discourse-entities*
        (remove-if (lambda (x) (equalp ulf x)) *discourse-entities*))
        (setq *discourse-entities* (cons ulf *discourse-entities*))
      ulf)
    ((symbolp ulf) ulf)
    (t (let (res) (dolist (phrase (reverse ulf))
          (setq res (cons (update-de-list phrase) res)))
        res)))
) ; END update-de-list



(defun resolve-ref! (ref)
; `````````````````````````
; Resolves a reference. First, we determine what category the reference falls under
; (currently just singular vs. plural), and we enforce the corresponding constraints,
; removing the candidates from the discourse entities list which don't abide by the
; constraints. Then, we choose the reference at the top of the remaining candidates,
; and then remove it from the discourse entities list so as to enforce reflexive
; constraints (e.g. in "Is it above that block" the two references can't refer to the
; same object).
;
  (let ((candidate-list *discourse-entities*)
        (constraints (cond
          ((member ref '(IT.PRO (THAT.D BLOCK.N) (THAT.D ONE.N))) '(sing?))
          ((member ref '(THEY.PRO THEM.PRO (THOSE.D (PLUR BLOCK.N)) (THOSE.D (PLUR ONE.N)))) '(plur?))
        )))
    (mapc (lambda (constr)
      (setq candidate-list (remove-if (lambda (x) (not (funcall constr x))) candidate-list)))
    constraints)
  (setq *discourse-entities*
    (remove-if (lambda (x) (equal x (car candidate-list))) *discourse-entities*))
  (or (car candidate-list) ref))
) ; END resolve-ref!



(defun coref-ulf (ulf)
; `````````````````````
; The top level coreference function for ulf. We do two steps: first, use TTT rule to
; transduce any references to the noun phrase at the top of the discourse entities list
; (satisfying constraints). Then update the discourse entity list using the new ulf,
; including re-adding the noun phrases that the references were previously resolved to.
;
  (setq ulf (ttt:apply-rule '(/ ref? (resolve-ref! ref?)) ulf))
  (update-de-list ulf)
) ; END coref-ulf



(defun coref-gist (gist)
; ```````````````````````
; Currently unused.
;
  gist
) ; END coref-ulf