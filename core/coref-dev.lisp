(defun ref? (sym)
; ``````````````````
; Predicate to check if a symbol is a reference to something previously
; in the conversation.
; TODO: Need a general way to detect references.
;
  (or
    (pron? sym)
    (equal sym '(THE.D BLOCK.N))
    (equal sym '(THAT.D BLOCK.N))
    (equal sym '(THOSE.D (PLUR BLOCK.N)))))

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



(defun resolve-ref! (ref)
  '(the.d block.n)
)



(defun coref-ulf (ulf)
; `````````````````````
;
  (ttt:apply-rule '(/ ref? (resolve-ref! ref?)) ulf)
) ; END coref-ulf



(defun coref-gist (gist)
; ```````````````````````
;
  gist
) ; END coref-ulf