; Ben Kane 7-16-2019
;
; Definitions of constraints for coreference, and corresponding weights.
;

(defun get-weights+constraints ()
; ````````````````````````````````
; Retrieves list of pairs of weights & constraints to apply.
;
'((5.00 exact-match-c)
  (5.00 precise-construct-c)
  (1.00 indefinite-reference-c)
  (0.90 binding-reflexive-c)
  (0.90 binding-anaphor-c)
  (0.90 binding-r-expression-c)
  (0.90 proper-name-conflict-c)
  (0.75 definite-reference-conflict-c)
  (0.75 pronoun-conflict-c)
  (0.50 type-match-c)
  (0.25 mod-agreement-c)
  (0.15 recency-c)
  (0.15 salience-c)
  (0.15 parallel-c)
)) ; END get-constraints


(defun exact-match-c (de1 de2 ulf)
; `````````````````````````````````
; If the references of de1 contains the exact ulf of de2, it is very likely
; that the two corefer.
; 
  (if (some (lambda (de2-ref)
        (equal (reconstruct-ulf de2-ref)
               (reconstruct-ulf (get de1 'ulf))))
      (mapcar (lambda (ref) (get ref 'ulf)) (get de2 'references))) 1 0)
) ; END exact-match-c


(defun precise-construct-c (de1 de2 ulf)
; ```````````````````````````````````````
; Here we check if de1 and de2 are contained in some precise construct which indicates
; that the two corefer with some certainty - e.g. "John is the president".
;
  (if (precise-construct? de2 de1 ulf) 1 0)
) ; END precise-construct-c


(defun type-match-c (de1 de2 ulf)
; ````````````````````````````````
; Here we check whether the type of de1 is equal to or subsumes de2.
; NOTE: should this be discrete, or should we take into account the amount of 'generalization' needed to match?
;
  (cond
    ((equal (get de1 'type) (get de2 'type)) 1)
    ((compare-type (get de1 'type) (get de2 'type)) 0.75)
    ((compare-type (get de2 'type) (get de1 'type)) 0.25)
    (t -1))
) ; END type-match-c


(defun mod-agreement-c (de1 de2 ulf)
; ````````````````````````````````````
; Here we check the extent to which the modifiers of de1 subsume those of de2 (see compare-mods for more info).
;
  (compare-mods (get de1 'mods) (get de2 'mods))
) ; END mod-agreement-c


(defun binding-reflexive-c (de1 de2 ulf)
; ```````````````````````````````````````
; If de1 is reflexive, make sure de2 is a *local* ancestor of de1 in the ulf, e.g. (|John| ((pres wash.v) himself.pro))
; or (|John| ((pres ask.v) |Mary| (to (wash.v herself.pro)))) but not (|John| ((pres ask.v) |Mary| (to (wash.v himself.pro))))
; That is, check that de2 is both local to de1, and c-commands de1.
;
  (if (and (equal (get de1 'cat) 'reflexive) (same-sentence? de1 de2 ulf))
    (let ((phrase1 (reconstruct-ulf (get de1 'ulf))) (phrase2 (reconstruct-ulf (get de2 'ulf))))
      (if (and (local? phrase2 phrase1 (reconstruct-ulf ulf))
               (c-command? phrase2 phrase1 (reconstruct-ulf ulf)))
      1 -1)) 0)
) ; END binding-reflexive-c


(defun binding-anaphor-c (de1 de2 ulf)
; ``````````````````````````````````````
; If de1 is an anaphoric pronoun, make sure de2 is either not local to de1 or does not c-commands de1.
;
  (if (and (equal (get de1 'cat) 'anaphor) (same-sentence? de1 de2 ulf))
    (let ((phrase1 (reconstruct-ulf (get de1 'ulf))) (phrase2 (reconstruct-ulf (get de2 'ulf))))
      (cond
        ((local? phrase1 phrase2 (reconstruct-ulf ulf)) -1)
        ((not (local? phrase2 phrase1 (reconstruct-ulf ulf))) 1)
        ((not (c-command? phrase2 phrase1 (reconstruct-ulf ulf))) 1)
        (t -1))) 0)
) ; END binding-anaphor-c


(defun binding-r-expression-c (de1 de2 ulf)
; ```````````````````````````````````````````
; If de1 is some r-expression, make sure de1 is not an antecedent to de2, and that de2 does not c-command
; de1 in the same sentence.
;
  (if (and (member (get de1 'cat) '(sentence event action proper-name definite-np indexical-np indefinite-np)) (same-sentence? de1 de2 ulf))
    (let ((phrase1 (reconstruct-ulf (get de1 'ulf))) (phrase2 (reconstruct-ulf (get de2 'ulf))))
      (cond
        ((local? phrase1 phrase2 (reconstruct-ulf ulf)) -1)
        ((c-command? phrase2 phrase1 (reconstruct-ulf ulf)) -1)
        (t 0))) 0)
) ; END binding-r-expression-c


(defun recency-c (de1 de2 ulf)
; `````````````````````````````
; Penalty for antecedents which are more distant in conversation history (taken as a fraction of the cutoff for
; relevant antecedents).
;
  (- (if (get de2 'recency) (/ (get de2 'recency) *recency-cutoff*) 0))
) ; END recency-c


(defun salience-c (de1 de2 ulf)
; ```````````````````````````````
; Favor antecedents which have a higher syntactic salience: 1 for a reference which was used as a direct subject, 0.5 for
; direct object, 0.25 for all other syntactic positions.
;
  (if (get de2 'salience) (get de2 'salience) 0)
) ; END salience-c


(defun parallel-c (de1 de2 ulf)
; ``````````````````````````````````````
; Slightly favor discourse entities which have the same salience, for example in parallel expressions.
;
  (floor (- 1 (abs (- (get de2 'salience) (get de1 'salience)))))
) ; END parallel-c


(defun indefinite-reference-c (de1 de2 ulf)
; ```````````````````````````````````````````
; If de1 is an indefinite reference (e.g. "a red block"), impose a penalty, since indefinite references typically introduce a new entity.
; NOTE: likewise with reified sentences/actions/events, at least for now.
;
  (if (or
    (equal (get de1 'cat) 'indefinite-np)
    (member (get de1 'cat) '(sentence event action)))
  -1 0)
) ; END indefinite-reference-c


(defun proper-name-conflict-c (de1 de2 ulf)
; `````````````````````````````````````````
; If the ulf of de1 is a proper name, and if de2 already has proper name(s) in its references, and those names do not coincide,
; it is implausible that the two corefer.
;
  (let ((proper-name1 (if (proper-name? (get de1 'ulf)) (get de1 'ulf) nil))
        (proper-names2 (remove-if-not #'proper-name? (mapcar (lambda (ref) (get ref 'ulf)) (get de2 'references)))))
    (if (and proper-name1 proper-names2 (not (member proper-name1 proper-names2))) -1 0))
) ; END proper-name-conflict-c


(defun pronoun-conflict-c (de1 de2 ulf)
; ```````````````````````````````````````
; If the ulf of de1 is a pronoun, and if de2 already has pronoun(s) in its references, and the perspectives of the pronouns do
; not coincide (e.g. I.pro and you.pro), it is implausible that the two corefer (except perhaps in complex scenarios like quotations).
;
  (let ((pron1 (if (pron? (get de1 'ulf)) (get de1 'ulf) nil))
        (prons2 (remove-if-not #'pron? (mapcar (lambda (ref) (get ref 'ulf)) (get de2 'references)))))
    (if (and pron1 prons2 (not (some (lambda (p)
                                (equal (pronoun-perspective pron1) (pronoun-perspective p))) prons2))) -1 0))
) ; END pronoun-conflict-c


(defun definite-reference-conflict-c (de1 de2 ulf)
; `````````````````````````````````````````````````
; A definite reference is unlikely to refer to a past discourse entity for which the proper name is known (e.g. *"John went to the
; store. The man bought an apple", cf. "John went to the store. He bough an apple.").
;
  (let ((proper-names2 (remove-if-not #'proper-name? (mapcar (lambda (ref) (get ref 'ulf)) (get de2 'references)))))
    (if (and (equal (get de1 'cat) 'definite-np) proper-names2) -1 0))
) ; END definite-reference-conflict-c