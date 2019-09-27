; Ben Kane 7-16-2019
;
; Helper functions for working with ulf.
;

(defun reconstruct-ulf (ulf &key verbose)
; ````````````````````````````````````````
; Reconstructs original ulf from processed ulf. Supply :verbose t
; as an argument to print information about each pronoun/reference.
;
  (cond
    ((and (atom ulf) (get ulf 'ulf))
      (cond (verbose
        (format t "sk: ~a~% |- ulf: ~a~% |- cat: ~a~% |- type: ~a~% |- mods: ~a~%"
          ulf (get ulf 'ulf) (get ulf 'cat) (get ulf 'type) (get ulf 'mods))))
      (reconstruct-ulf (get ulf 'ulf) :verbose verbose))
    ((and (atom ulf)) ulf)
    (t (mapcar (lambda (x)
        (reconstruct-ulf x :verbose verbose))
      ulf)))
) ; END reconstruct-ulf


(defun resolve-references (ulf)
; ```````````````````````````````
; Retrieves the most specific references for each discourse entity and substitutes them
; in for that discourse entity to obtain a final result.
;
  (cond
    ((and (atom ulf) (get ulf 'references))
      (resolve-references (get-most-specific-reference ulf)))
    ((and (atom ulf)) ulf)
    (t (mapcar (lambda (x)
        (resolve-references x))
      ulf)))
) ; END resolve-references


(defun special-op? (ulf)
; ````````````````````````
; Checks whether a ULF is a special operator or macro, e.g. sub, k, set-of, etc.
;
  (and (atom ulf) (member ulf '(not plur past pres perf prog pasv k ka ke to that tht fquan nquan nmod amod
                                *h *s *p set-of n+preds np+preds sub rep 's poss-by adv-a adv-e adv-f adv-s
                                ? ! = voc voc-O ds ans-to pu cf )))
) ; END special-op?


(defun indiv? (ulf)
; ```````````````````
; Checks whether a ulf segment is an individual type (noun phrase,
; reified noun/action/sentence, etc.)
;
  (or
    ; Compound types
    (quan? ulf)
    (reified-sentence? ulf)
    (reified-action? ulf)
    (reified-event? ulf)
    (det-np? ulf)
    (set-of? ulf)
    (kind? ulf)
    ; Atomic types
    (pron? ulf)
    (proper-name? ulf))
) ; END indiv?


(defun reference? (ulf)
; ```````````````````````
; TTT predicate to match a reference (anything that's an individual
; and not a pronoun).
;
  (and (indiv? ulf) (not (pron? ulf)))
) ; END reference?


(defun pron? (ulf)
; ````````````````````
; TTT predicate to match a pronoun (anything ending in .PRO, or a
; relative pronoun).
;
  (or (relative? ulf) (equal (second (sym-split ulf 4)) '.PRO))
) ; END pron?


(defun pronoun-perspective (pron)
; `````````````````````````````````
; Gets the perspective of a pronoun, i.e. '1s for first person singular,
; '2s for second person singular, '1p for first person plural, etc.
;
  (cond
    ((member pron '(I.pro me.pro myself.pro)) '1s)
    ((member pron '(you.pro yourself.pro)) '2s)
    ((member pron '(he.pro him.pro himself.pro she.pro her.pro herself.pro
                    one.pro oneself.pro themself.pro it.pro itself.pro that.pro)) '3s)
    ((member pron '(we.pro us.pro ourselves.pro)) '1p)
    ((member pron '(yourselves.pro)) '2p)
    ((member pron '(they.pro those.pro these.pro them.pro themselves.pro)) '3p))
) ; END pronoun-perspective


(defun male-pron? (pron)
; ````````````````````````
; Checks if a pronoun is male.
;
  (and (atom pron) (member pron '(he.pro him.pro himself.pro)))
) ; END male-pron?


(defun female-pron? (pron)
; `````````````````````````
; Checks if a pronoun is female.
;
  (and (atom pron) (member pron '(she.pro her.pro herself.pro)))
) ; END female-pron?


(defun person-pron? (pron)
; `````````````````````````
; Checks if a pronoun is person (singular).
;
  (and (atom pron) (member pron '(I.pro you.pro me.pro myself.pro yourself.pro one.pro oneself.pro themself.pro)))
) ; END person-pron?


(defun person-plur-pron? (pron)
; ``````````````````````````````
; Checks if a pronoun is person (plural).
;
  (and (atom pron) (member pron '(we.pro us.pro yourselves.pro)))
) ; END person-plur-pron?


(defun neutral-pron? (pron)
; ```````````````````````````
; Checks if a pronoun is neutral.
;
  (and (atom pron) (member pron '(it.pro that.pro itself.pro)))
) ; END neutral-pron?


(defun neutral-plur-pron? (pron)
; ```````````````````````````````
; Checks if a pronoun is neutral (plural).
;
  (and (atom pron) (member pron '(they.pro those.pro these.pro them.pro themselves.pro)))
) ; END neutral-plur-pron?


(defun existential-pron? (pron)
; ``````````````````````````````
; Checks if a pronoun is an existential pronoun.
;
  (and (atom pron) (member pron '(what.pro which.pro there.pro)))
) ; END existential-pron?


(defun ellipsis? (ulf)
; `````````````````````
; Check if a ULF is an ellipsis (i.e. curly brackets).
;
  (and (atom ulf) (equal (first (sym-split ulf 1 :front t)) '{))
) ; END ellipsis?


(defun replace-ellipsis! (ellipsis)
; ``````````````````````````````````
; Replaces an ellipsed item with entity.n in the case of nouns (e.g. {ref1}.n to entity.n),
; or the item without curly brackets otherwise (e.g. {you}.pro).
;
  (if (noun? ellipsis) 'entity.n
    (implode (remove-if (lambda (x) (member x '(#\{ #\}) :test #'char-equal)) (explode ellipsis))))
) ; END replace-ellipsis!


(defun det? (ulf)
; ```````````````````````
; Checks if a ULF is a determiner.
;
  (and (atom ulf) (equal (second (sym-split ulf 2)) '.D))
) ; END det?


(defun mod? (ulf)
; ````````````````
; Checks if a ULF is some simple noun phrase modifier (either adj or nominal predicate)
;
  (or (adj? ulf) (noun? ulf))
) ; END mod?


(defun adj? (ulf)
; ````````````````
; Checks if a ULF is an adjective.
;
  (and (atom ulf) (equal (second (sym-split ulf 2)) '.A))
) ; END adj?


(defun noun? (ulf)
; `````````````````
; Checks if a ULF is a nominal predicate.
;
  (or (and (atom ulf) (equal (second (sym-split ulf 2)) '.N))
    (and (plur? ulf) (equal (second (sym-split (second ulf) 2)) '.N)))
) ; END noun?


(defun relative? (ulf)
; `````````````````````
; Checks if a ULF is a relative pronoun.
;
  (and (atom ulf) (equal (second (sym-split ulf 4)) '.REL))
) ; END relative?


(defun reflexive? (ulf)
; ``````````````````````
; Checks if a ULF is a reflexive pronoun.
;
  (and (pron? ulf)
    (if (member ulf '(myself.pro yourself.pro yourselves.pro himself.pro herself.pro
                  oneself.pro itself.pro ourselves.pro themselves.pro)) t))
) ; END relative?


(defun anaphor? (ulf)
; ``````````````````````
; Checks if a ULF is an anaphoric pronoun.
;
  (and (pron? ulf)
    (not (relative? ulf)) (not (reflexive? ulf)))
) ; END relative?


(defun preposition? (ulf)
; ````````````````````````
; Checks if a ULF is a preposition, e.g. on.p.
;
  (and (listp ulf) (atom (car ulf)) (equal (second (sym-split (car ulf) 2)) '.P))
) ; END preposition?


(defun sentential-preposition? (ulf)
; ````````````````````````````````````
; Checks if a ULF is a sentential preposition (because.ps, while.ps, etc.).
;
  (and (atom ulf) (equal (second (sym-split ulf 3)) '.PS))
) ; END sentential-preposition?


(defun discourse-entity? (ulf)
; ````````````````````````````
; Checks if a ULF is a discourse entity (ends in .de).
;
  (and (atom ulf) (equal (second (sym-split ulf 3)) '.DE))
) ; END discourse-entity?


(defun reified-sentence? (ulf)
; `````````````````````````````
; Checks if a ULF is a reified sentence ("that ...").
;
  (and (listp ulf) (member (car ulf) '(that tht ans-to whether)))
) ; END reified-sentence?


(defun reified-action? (ulf)
; `````````````````````````````
; Checks if a ULF is a reified action ("to ...")
;
  (and (listp ulf) (member (car ulf) '(ka to)))
) ; END reified-action?


(defun reified-event? (ulf)
; `````````````````````````````
; Checks if a ULF is a reified event ("ke ...")
;
  (and (listp ulf) (member (car ulf) '(ke)))
) ; END reified-event?


(defun proper-name? (ulf)
; `````````````````````````
; Checks if a ULF is a proper name.
;
  (and (symbolp ulf) (not (special-op? ulf)) (not (sym-contains ulf #\.)))
) ; END proper-name?


(defun det-np? (ulf)
; ````````````````
; Checks if a ULF is a noun phrase starting with a determiner.
;
  (and (listp ulf) (det? (car ulf)))
) ; END det-np?


(defun definite-np? (ulf)
; `````````````````````````
; Checks if a ULF is a definite noun phrase.
;
  (and (det-np? ulf) (or
    (member (first ulf) '(the.d which.d what.d whichever.d whatever.d))
    (and (equal (first ulf) 'np+preds) (definite-np? (second ulf)))))
) ; END definite-np?


(defun indexical-np? (ulf)
; `````````````````````````
; Checks if a ULF is an indexical noun phrase (e.g. "that block")
;
  (and (det-np? ulf) (or
    (member (first ulf) '(that.d this.d those.d))
    (and (equal (first ulf) 'np+preds) (definite-np? (second ulf)))))
) ; END definite-np?


(defun indefinite-np? (ulf)
; ``````````````````````````
; Checks if a ULF is an indefinite noun phrase.
;
  (and (det-np? ulf) (or
    (member (first ulf) '(a.d some.d any.d))
    (set-of? ulf)
    (kind? ulf)
    (quan? ulf)
    (and (equal (first ulf) 'np+preds) (indefinite-np? (second ulf)))))
) ; END indefinite-np?


(defun set-of? (ulf)
; ```````````````````
; Checks if a ULF is a set-of some individuals.
;
  (and (listp ulf) (equal (first ulf) 'set-of))
) ; END set-of?


(defun kind? (ulf)
; ``````````````````
; Checks if a ULF is a kind (e.g. using the k operator).
;
  (and (listp ulf) (equal (first ulf) 'k))
) ; END kind?


(defun quan? (ulf)
; ``````````````````
; Checks if a ULF has fquan or nquan.
;
  (and (listp ulf) (listp (first ulf)) (member (first (first ulf)) '(fquan nquan)))
) ; END quan?


(defun plur? (ulf)
; `````````````````
; Checks if a ULF is plural (recursively)
;
  (if (atom ulf) (equal ulf 'plur)
    (some #'plur? ulf))
) ; END plur?


(defun remove-plur (ulf)
; ```````````````````````
; Removes plur from ULF.
;
  (if (atom ulf) (if (equal ulf 'plur) nil ulf)
    (let ((tmp (remove nil (mapcar #'remove-plur ulf))))
      (if (and (listp tmp) (= (length tmp) 1)) (car tmp) tmp)))
) ; END remove-plur


(defun numerical-adj? (ulf)
; ``````````````````````````
; If ULF is a numerical adjective (e.g. "5.a" or "five.a"), return the corresponding
; number, or nil otherwise.
; 
  (if (numberp ulf) (return-from numerical-adj? ulf))
  (if (not (adj? ulf)) (return-from numerical-adj? nil))
  (let ((adj (read-from-string (string (first (sym-split ulf 2))))))
    (cond
      ((numberp adj) adj) ((equal adj 'zero) 0) ((equal adj 'one) 1)
      ((equal adj 'two) 2) ((equal adj 'three) 3) ((equal adj 'four) 4)
      ((equal adj 'five) 5) ((equal adj 'six) 6) ((equal adj 'seven) 7)
      ((equal adj 'eight) 8) ((equal adj 'nine) 9) ((equal adj 'ten) 10)))
) ; END numerical-adj?


(defun numerical-det? (ulf)
; ``````````````````````````
; If ULF is a numerical determiner (e.g. "two.d"), return the corresponding
; number, or nil otherwise.
; 
  (if (not (det? ulf)) (return-from numerical-det? nil))
  (cond
    ((equal ulf 'zero.d) 0) ((equal ulf 'one.d) 1) ((equal ulf 'two.d) 2)
    ((equal ulf 'three.d) 3) ((equal ulf 'four.d) 4) ((equal ulf 'five.d) 5)
    ((equal ulf 'six.d) 6) ((equal ulf 'seven.d) 7) ((equal ulf 'eight.d) 8)
    ((equal ulf 'nine.d) 9) ((equal ulf 'ten.d) 10))
) ; END numerical-det?


(defun get-tense (ulf)
; `````````````````````
; Gets the tense of a sentence ULF.
;
  (cond
    ((member ulf '(past pres)) ulf)
    ((atom ulf) nil)
    (t (some #'get-tense ulf)))
) ; END get-tense


(defun get-aspect (ulf)
; ``````````````````````
; Gets the aspect of a sentence ULF.
;
  (cond
    ((member ulf '(perf prog)) ulf)
    ((atom ulf) nil)
    (t (some #'get-aspect ulf)))
) ; END get-aspect


(defun get-quan (ulf)
; ````````````````````
; Gets the quantity of a quantificational noun phrase. Returns the
; noun phrase without the quantificational modifier.
; NODE: Modify to return quantificational noun phrase without quant adj, along with number
;
  (if (atom ulf) (numerical-adj? ulf)
    (some #'get-quan ulf))
) ; END get-quan


(defun remove-quan (ulf)
; ```````````````````````
; Removes quantificational modifier from ULF.
;
  (if (atom ulf) (if (numerical-adj? ulf) nil ulf)
    (let ((tmp (remove nil (mapcar #'remove-quan ulf))))
      (if (and (listp tmp) (= (length tmp) 1)) (car tmp) tmp)))
) ; END remove-quan


(defun copulative? (v)
; `````````````````````
; Checks whether v is a copulative verb, e.g. be.v
;
  (member v '(be.v))
) ; END copulative?


(defun same-sentence? (de1 de2 ulf)
; ``````````````````````````````````
; Checks whether de1 and de2 are in the same ulf sentence.
;
  (labels ((find-sk (de ulf-part)
    (cond
      ((null ulf-part) nil)
      ((equal ulf-part de) t)
      ((discourse-entity? ulf-part)
        (find-sk de (get ulf-part 'ulf)))
      ((atom ulf-part) nil)
      (t (some (lambda (x) (find-sk de x)) ulf-part)))))
  (and (find-sk de1 ulf) (find-sk de2 ulf)))
) ; END same-sentence?


(defun precise-construct? (de1 de2 ulf)
; ```````````````````````````````````````
; Checks whether de2 is related to de1 through some precise construct, e.g. appositive, relative pronoun, etc.
;
  (or
    ; Appositive
    (ttt:match-expr `(_!1 (n+preds _!2 _*1 (= ,de2) _*2)) (get de1 'ulf))
    (ttt:match-expr `(^* (np+preds ,de1 _*1 (= ,de2) _*2)) ulf)
    ; Predicate nominative
    (ttt:match-expr `(^* (,de1 ((pres copulative?) (= ,de2) _*))) ulf)
    ; Relative pronoun
    ; NOTE: What if we have nested relative pronouns (e.g. the block that is on top of the block that is to the left of ...)?
    ; I anticipate this being a problem...
    ; NOTE: Add it-clefts? e.g. "it was to Rome that he travelled"
    (and (equal 'relative (get de2 'cat)) (or
      (ttt:match-expr `(_!1 (n+preds _!2 _*1 (^* ,de2) _*2)) (get de1 'ulf))
      (ttt:match-expr `(^*1 (np+preds ,de1 _*1 (^*2 ,de2) _*2)) ulf))))
) ; END precise-construct?


(defun local? (phrase1 phrase2 ulf)
; ``````````````````````````````````
; Checks whether phrase1 is a local ancestor to phrase2; i.e. if there is no other discourse entity standing
; between (blocking) phrase1 and phrase2, and phrase1 and phrase2 are both in the same sentence/clause.
;
; NOTE: This is a rather tricky matter in general, since sentences like "The woman told Martha about herself"
; can have both readings, one in which 'herself' refers to 'the woman' (even though 'Martha' stands between the
; two) and one in which 'herself' refers to Martha. It seems that the 'blocking' criterion applies strictly in
; cases with 'to ...', but not necessarily predicates in general, so this functon is implemented correspondingly.
;
  (let (blocker-found)
    (labels
      ; Finds the sub-ulf directly following phrase1
      ((find-list (ulf-part)
        (cond
          ((atom ulf-part) nil)
          ((member phrase1 ulf-part :test #'equal) (cdr (member phrase1 ulf-part :test #'equal)))
          (t (some (lambda (x) (find-list x)) ulf-part))))
      ; Check if phrase2 is local to phrase1
      (local-recur (ulf-part)
        (cond
          ; If the current ulf-part matches phrase2, we have a match
          ((equal ulf-part phrase2) t)
          ; If a clause-forming operator is found (n+preds/np+preds due to relative clauses), do not search any deeper
          ((and (listp ulf-part) (or (sentential-preposition? (first ulf-part)) (member (first ulf-part) '(n+preds np+preds that tht ans-to))))
            nil)
          ; If an action/event reifer is found, return true only if no blocker has been found
          ((and (listp ulf-part) (member (first ulf-part) '(to ka ke)))
            (if (some (lambda (x) (local-recur x)) ulf-part) (if blocker-found nil t) nil))
          ; If some other individual is found, tentatively set the 'blocker-found' tag to true and return no match
          ((indiv? ulf-part) (setq blocker-found t) nil)
          ; If any other atom is found, return no match
          ((atom ulf-part) nil)
          ; Otherwise, recursively check if we have a match anywhere
          (t (if (some (lambda (x) (local-recur x)) ulf-part) t nil)))))
  (local-recur (find-list ulf))))
) ; END local?


(defun c-command? (phrase1 phrase2 ulf)
; ``````````````````````````````````````
; Checks whether phrase1 c-commands phrase2 in a given ulf.
;
  (ttt:match-expr `(^* (_*1 ,phrase1 _*2 (^* ,phrase2) _*3)) ulf)
) ; END c-command?


(defun sym-split (sym n &key front)
; ```````````````````````````````````
; Splits a symbol into two symbols at index n from the end.
; (or if :front t is given, n from the front)
;
  (if (and (atom sym) (> (length (string sym)) n))
    (let ((lex (string sym)))
      (if front
        (list (intern (subseq lex 0 n))
          (intern (subseq lex n (length lex))))
        (list (intern (subseq lex 0 (- (length lex) n)))
          (intern (subseq lex (- (length lex) n) (length lex)))))))
) ; END sym-split


(defun sym-contains (sym char)
; ``````````````````````````````
; Returns true if a symbol contains the character given by char.
;
  (if (member char (explode sym) :test #'char-equal) t)
) ; END sym-contains


(defun explode (s)
;``````````````````
; The list of the characters making up symbol s
;
  (coerce (string s) 'list)
) ; END explode


(defun implode (l)
;``````````````````
; (IMPLODE LIST-OF-CHARACTERS) => a symbol
; The symbol is interned in the current package and has as name a string 
; with the characters in LIST-OF-CHARACTERS.
;
  (intern  (coerce l 'string))
) ; END implode