; Ben Kane 7-16-2019
;
; Functions for working with ULF types and modifiers.
;

(defun add-hier (hier-name &rest el-args)
; ``````````````````````````````````````````````````````````
; Adds to a hierarchy. Currently just uses implicit 'isa
; features on symbols, so hier-name is unused. el-args is a
; list where the first element is a node, and the rest of the
; elements are children whose 'isa pointer should point to the
; node. Currently we just preserve sense numbers in this step
; (although the un-sensed noun symbol is also given a list of
; sense numbers as a feature)
;
  (let* ((args (mapcar #'tag-sense el-args))
        (node (car args)) (children (cdr args)))
    (mapcar
      (lambda (child)
        (if (not (member node (get child 'isa)))
          (setf (get child 'isa) (cons node (get child 'isa)))))
      children)
)) ; END add-hier


(defun tag-sense (noun)
; `````````````````````````
; Removes the sense number from a noun symbol, and
; tags the noun symbol with it as a feature 'sense
;
  (let* ((noun-sense (detach-sense noun))
        (noun1 (first noun-sense)) (sense (second noun-sense)))
    (if (not (member sense (get noun1 'senses) :test #'equalp))
      (setf (get noun1 'senses) (cons sense (get noun1 'senses))))
    noun
)) ; END tag-sense


(defun detach-sense (noun)
; `````````````````````````
; Removes the sense number from a noun symbol, and
; returns a list of that noun symbol and the sense number
;
  (let* ((str (string noun))
        (noun-str (subseq str 0 (- (length str) 3)))
        (sense-str (subseq str (- (length str) 2) (length str))))
    (list (intern noun-str) sense-str)
)) ; END detach-sense


(defun remove-sense (noun)
; `````````````````````````
; Removes the sense number from a noun symbol.
;
  (let ((str (string noun)))
    (intern (subseq str 0 (- (length str) 3)))
)) ; END remove-sense


(defun add-sense (noun sense-str)
; ````````````````````````````````
; Adds a sense number to a (unsensed) noun.
;
  (if (has-sense? noun) noun
    (intern (concatenate 'string (string noun) "." sense-str)))
) ; END add-sense


(defun has-sense? (noun)
; ```````````````````````
; Returns true if noun has a sense number attached.
;
  (let ((str (string noun)))
    (numberp (read-from-string
      (subseq str (- (length str) 3) (length str))))
)) ; END has-sense?


(defun get-senses (noun)
; ```````````````````````
; Creates a list of all possible senses for a given noun.
;
  (if (has-sense? noun) (list noun)
    (mapcar (lambda (sense) (add-sense noun sense))
      (get noun 'senses)))
) ; END get-senses


(defun enumerate-sense-pairs (noun1 noun2)
; `````````````````````````````````````
; Creates list with all possible pairs of senses between two nouns.
;
  (mapcan (lambda (n1) (mapcar (lambda (n2) (list n1 n2))
    (get-senses noun2))) (get-senses noun1))
) ; END enumerate-sense-pairs


(defun subsumes? (noun1 noun2)
; `````````````````````````````
; Returns t if noun1 is an ancestor of noun2, nil otherwise.
; In the case that a given noun does not have a sense number specified,
; try all possible pairs of senses and return true if any of them is satisfied.
;
  (labels ((subsumes-recur (n1 n2)
            (cond
              ((or (null n1) (null n2)) nil)
              ((equal n1 n2) t)
              (t (some (lambda (parent) (subsumes-recur n1 parent)) (get n2 'isa))))))
  (if (or (equal noun1 'entity.n) (equal noun1 'entity.n.01)) t
    (some (lambda (pair) (subsumes-recur (first pair) (second pair)))
      (enumerate-sense-pairs noun1 noun2))))
) ; END subsumes?


(defun subsumes-distance (noun1 noun2)
; ``````````````````````````````````````
; If noun1 subsumes noun2, return the number of abstractions that are needed to reach
; noun1 from noun2 (or nil if noun1 does not subsume noun2). In the case that a given noun
; does not have a sense number specified, try all possible pairs of senses and return the
; minimum distance (or nil).
; (In the special case of "entity" we wish to return 0, at least for now)
;
  (labels ((subsumes-distance-recur (n1 n2 i)
            (cond
              ((or (null n1) (null n2)) nil)
              ((equal n1 n2) i)
              (t (some (lambda (parent) (subsumes-distance-recur n1 parent (1+ i))) (get n2 'isa))))))
  (if (or (equal noun1 'entity.n) (equal noun1 'entity.n.01)) 0
    (let ((res (remove nil
            (mapcar (lambda (pair) (subsumes-distance-recur (first pair) (second pair) 0))
              (enumerate-sense-pairs noun1 noun2)))))
      (if res (apply #'min res) nil))))
) ; END subsumes?


(defun ancestors (noun)
; ```````````````````````
; Returns all ancestors of a noun. 
; Top-level function, in the case that the given noun does not have a sense number specified,
; return a list of ancestors for each sense.
;
  (labels ((ancestors-recur (n)
    (if (not (get n 'isa)) (list n)
      (cons n (mapcan #'ancestors-recur (get n 'isa))))))
  (mapcar #'ancestors-recur (get-senses noun)))
) ; END ancestors


(defun lca (noun1 noun2)
; ````````````````````````
; Returns the lowest common ancestor of noun1 and noun2, currently implemented in terms of the
; intersection between the two ancestor trees. In the case that the given nouns do not have sense numbers
; specified, return an lca for each possible pair.
;
  (mapcar
    (lambda (pair)
      (let ((ancestors1 (car (ancestors (first pair)))) (ancestors2 (car (ancestors (second pair)))))
        (car (last (intersection ancestors1 ancestors2 :test #'eq)))))
  (enumerate-sense-pairs noun1 noun2))
) ; END lca


(defun lca-disambiguate (noun1 noun2 &key has-sense)
; ```````````````````````````````````````````````````
; Returns a singular lowest common ancestor of noun1 and noun2, disambiguating by choosing the most specific
; one using abstraction-distance. Removes sense unless :has-sense t is supplied.
;
  (let ((ancestor (caar (sort (mapcar
          (lambda (x) (list x (abstraction-distance x))) (lca noun1 noun2)) #'> :key #'second))))
    (if has-sense ancestor (remove-sense ancestor)))
) ; END lca-disambiguate


(defun lca-list (noun-list &key has-sense)
; `````````````````````````````````````````
; Returns the lca for a list of nouns. Removes sense from result unless :has-sense t is supplied.
;
  (let ((ancestor (reduce
          (lambda (noun1 noun2) (lca-disambiguate noun1 noun2 :has-sense t)) noun-list)))
  (if has-sense ancestor (remove-sense ancestor)))
) ; END lca-list


(defun abstraction-distance (noun)
; ```````````````````````````````````
; Gets the level of abstraction of a lca. Higher = more specific.
; NOTE: noun must have sense number.
;
  (labels ((distance-from-root (n i)
            (cond
              ((not (get n 'isa)) i)
              (t (apply #'max
                (mapcar (lambda (x) (distance-from-root x (+ i 1)))
                  (get n 'isa)))))))
  (if (and noun (has-sense? noun)) (distance-from-root noun 0) nil))
) ; END abstraction-distance


(defun add-names (entity-type name-list)
; ````````````````````````````````````````
; Adds a specified entity type as a feature 'entity-type
; to a list of proper names (after converting names to proper format).
;
  (let ((names (mapcar #'parse-name name-list)))
    (mapcar
      (lambda (name)
        (setf (get name 'entity-type) entity-type))
      names)
)) ; END add-names


(defun parse-name (name)
; ````````````````````````
; Converts a name from a format with all lowercase & underscores between words
; to a format with spaces and each word uppercase.
;
  (intern (format nil "~:(~a~)" (substitute #\Space #\_ (string name))))
) ; END parse-name


(defun get-type+mods (np)
; ``````````````````````````
; Given a ULF representing a noun phrase, extract the base type, and create a list
; where the first element is the type, and the subsequent elements are modifiers.
; NOTE: This function is really messy! It could use some refactoring at some point.
;
  (cond
    ; Pronoun, get type based on pronoun classification
    ((pron? np)
      (cond
        ((male-pron? np) '(male.n))
        ((female-pron? np) '(female.n))
        ((person-pron? np) '(person.n))
        ((person-plur-pron? np) '((set (cardinality indef) (type+mods (person.n)))))
        ((neutral-pron? np) '(entity.n))
        ((neutral-plur-pron? np) '((set (cardinality indef) (type+mods (entity.n)))))
        ((existential-pron? np) '(entity.n))))
    ; Proper name, try finding the default type attached with that lexical item
    ((proper-name? np) `(,(get np 'entity-type)))
    ; Set-of is fairly complicated; we have to first get the types of all the members of the set, and
    ; then find the lowest common ancestor of those types.
    ((set-of? np)
      `((set (cardinality ,(length (cdr np)))
             (type+mods (,(lca-list (mapcar (lambda (x) (car (get-type+mods x))) (cdr np))))))))
    ; Reified sentence 
    ((reified-sentence? np)
      `((sentence (tense ,(get-tense np)) (aspect ,(get-aspect np)))))
    ; Reified action
    ((reified-action? np) '((action)))
    ; Reified event
    ((reified-event? np) '((event)))
    ; Quan
    ((quan? np)
      (let ((quan (get-quan np)))
        (cond
          ; Quan is an integer greater than 1, create set with that cardinality
          ((and quan (> quan 1))
            `((set (cardinality ,quan) (type+mods ,(get-type+mods (remove-plur (second np)))))))
          ; Quan is equal to 1, simply treat as normal singular
          ((and quan (= quan 1)) (get-type+mods (second np)))
          ; Quan is some complex modifier, create set storing that modifier under cardinality
          (t 
            `((set (cardinality ,(second (first np))) (type+mods ,(get-type+mods (remove-plur (second np))))))))))
    ; Quantificational determiner
    ((and (listp np) (numerical-det? (first np)))
      `((set (cardinality ,(numerical-det? (first np))) (type+mods ,(get-type+mods (list 'some.d (remove-plur (second np))))))))
    ; Any quantificational modifier
    ((and (get-quan np) (> (get-quan np) 1))
      `((set (cardinality ,(get-quan np)) (type+mods (get-type+mods (remove-plur (remove-quan np)))))))
    ((and (get-quan np) (= (get-quan np) 1))
      `(,(get-type+mods (remove-quan np))))
    ; Plural
    ((plur? np)
      `((set (cardinality indef) (type+mods ,(get-type+mods (remove-plur np))))))
    ; Np+preds
    ((and (listp np) (equal (car np) 'np+preds))
      (let ((type+mods (get-type+mods (second np))))
        (cons (car type+mods) (append (cdr type+mods) (cddr np)))))
    ; Determiner/reified individual
    ((and (listp np) (or (det? (car np)) (equal (car np) 'k)))
      (let ((det (first np)) (n1 (second np)))
        (cond
          ; N+preds
          ((and (listp n1) (equal (car n1) 'n+preds))
            (get-type+mods (append (list 'np+preds (list det (second n1))) (cddr n1))))
          ; Kind
          ((equal (car np) 'k)
            `((kind (type+mods ,(get-type+mods n1)))))
          ; Other
          (t (get-type+mods n1)))))
    ; Noun with/without modifiers
    (t (cond
      ; Noun with no mods
      ((and (atom np) (noun? np)) `(,np))
      ; Single noun with some preceeding mods
      ((and (listp np) (noun? (car (last np))))
        (cons (car (last np)) (butlast np)))
      ; Nested noun+modifiers with some preceeding mods
      (t (let ((type+mods (get-type+mods (car (last np)))))
        (cons (car type+mods) (append (butlast np) (cdr type+mods))))))))
) ; END get-type+mods


(defun mod-subsumes? (mod1 mod2)
; ```````````````````````````````
; Check if mod1 subsumes mod2 (that is, if mod1 is more general than mod2).
; Since we don't have modifier hierarchies, we just check whether one modifier
; is the same as the other plus another modifier or adverbial,
; e.g. tall.a subsumes (very.adv-a tall.a), hot.a subsumes (burning.a hot.a)
; NOTE: In the future, should this be made a numerical score rather than boolean?
;
  (cond
    ((and (mod? mod1) (mod? mod2)) (equal mod1 mod2))
    ((mod? mod1) (mod-subsumes? mod1 (car (last mod2))))
    ((preposition? mod1) (equal mod1 mod2))
    (t (or (equal mod1 mod2) (and (listp mod2) (mod-subsumes? mod1 (car (last mod2)))))))
) ; END mod-subsumes?


(defun compare-mods (mods1 mods2)
; ````````````````````````````````
; Determines the fraction of mods in mods1 that are subsumed by some mod in mods2.
; NOTE: This might need to be modified to return a non-zero score for cases like
; (compare-mods '(big.a red.a) nil), since rarely a reference to an entity can be followed
; by a more specific reference, e.g. "I saw John yesterday. That handsome man ..."
;
  (labels ((compare-mods-recur (m1 m2 i)
            (cond
              ((null m1) i)
              ((null m2) (compare-mods-recur (cdr m1) mods2 i))
              ((mod-subsumes? (car m1) (car m2))
                (compare-mods-recur (cdr m1) (cdr m2) (+ i 1)))
              (t (compare-mods-recur m1 (cdr m2) i))
            )))
  (if mods1 (let ((n (compare-mods-recur mods1 mods2 0)))
    (/ n (length mods1))) 0))
) ; END compare-mods


(defun compare-type (type1 type2)
; ````````````````````````````````
; Determines whether type1 subsumes type2 (so, currently just a simple call to subsumes?,
; although in the future we might want to change this to give it a numerical score?).
; NOTE: This function is also rather messy, and could use some refactoring.
;
  (cond
    ; Both types are sets
    ((and (listp type1) (listp type2) (equal (car type1) 'set) (equal (car type2) 'set))
      (let ((cardinality1 (cadadr type1)) (cardinality2 (cadadr type2))
            (type+mods1 (car (cdaddr type1))) (type+mods2 (car (cdaddr type2))))
        (cond
          ; An indefinite set subsumes any other set (if the type subsumes the type of the other set)
          ((equal cardinality1 'indef)
            (compare-type (car type+mods1) (car type+mods2)))
          ; A set with some non-numeric cardinality subsumes another set with non-numeric cardinality
          ; only if those two cardinalities are equivalent, and the type is subsumed.
          ((and (not (numberp cardinality1)) (not (numberp cardinality2)))
            (and (equal cardinality1 cardinality2) (compare-type (car type+mods1) (car type+mods2))))
          ; A set with some other non-numeric cardinality subsumes a set with numerical cardinality
          ; NOTE: might want to change this in the future somehow... e.g. (cardinality many.a) should not subsume (cardinality 2)
          ((and (not (numberp cardinality1)) (numberp cardinality2))
            (compare-type (car type+mods1) (car type+mods2)))
          ; A set with numeric cardinality subsumes another set with numeric cardinality only if the
          ; cardinalities are equivalent and the type is subsumed.
          ((and (numberp cardinality1) (numberp cardinality2))
            (and (= cardinality1 cardinality2) (compare-type (car type+mods1) (car type+mods2)))))))
    ; Both types are kinds
    ((and (listp type1) (listp type2) (equal (car type1) 'kind) (equal (car type2) 'kind))
      (compare-type (car (cadadr type1)) (car (cadadr type2))))
    ; The first type is 'entity.n and the second type is a set, event, action, or kind
    ((and (noun? type1) (listp type2))
      (or (equal type1 'entity.n) (equal type1 'entity.n.01)))
    ; Both types are nominals and the first type subsumes the second type
    ((and (noun? type1) (noun? type2)) (subsumes? type1 type2))
  )
) ; END compare-type