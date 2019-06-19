;; Gist clause extraction
;; simple nested rules + features + wildcards
;;
;; "How did you get here today?"

(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
    ; Many features are already defined in core/general-word-data.lisp, make sure to check there before defining any
    ; new features here.
    (walk walk walked stroll run ran hike hiked)
    (ride ride rode ridden)
    (drive drive driven drove)
    ; | "feat" here just to emphasize that the head represents a feature which is attached to all the subsequent words.
    ; | Sometimes a word itself can be used as a feature (useful in the case of synonyms/tenses, such as with "drive" above),
    ; | but this isn't always necessarily desirable (we may need to match 'mother' specifically, but not 'father', for instance).
    ; V
    (feat-someone someone someone\'s somebody\'s somebody another feat-relationships)
    (feat-relationships wife husband spouse dad father mom mother son grandson daughter granddaughter child friend friend\'s mate mate\'s)
    (feat-car-poss-by-me my a)

    ;; ============================
    ;; TODO: ADD MORE FEATURES HERE
    ;; ============================

  ))

  ;
  ; The following "choice packet" defined below is parsed into a rule tree,
  ; which matches patterns recursively:
  ; If a particular pattern fails to match to the input, the pattern matching
  ; algorithm will backtrack and attempt to match the next sibling, and so on.
  ; If no patterns at some depth successfully match, the algorithm backtracks
  ; to the previous level of patterns and continues. The top-level (0) pattern
  ; (scroll down to the bottom of the choice packet), which matches anything,
  ; ensures that if no pattern is matched, a special "NIL Gist" will be extracted.
  ;
  (READRULES '*specific-answer-from-example-input*
  '(
  ; | The '1', '2', etc. preceeding each rule indicates the level of that
  ; | rule in a tree structure. Each non-leaf node represents a pattern rule,
  ; | and each leaf node represents a directive (in this case, create and store
  ; | a gist clause, as indicated by the (0 :gist) tag).
  ; V
    1 (0 drive 0)
       ; | The '0' in each of these patterns simply matches zero or more characters.
       ; | They are generally only used in the beginning and end of a pattern so the
       ; | pattern can be matched at any point in a longer chunk of text.
       ; V
      2 (0 friend drive 0)
         ; | The first element of the below list, (Someone drove me here today \.),
         ; | represents the gist clause to be extracted, the second element,
         ; | (example), represents the topic key, which is beyond the scope of
         ; | this tutorial.
         ; V
        3 ((Someone drove me here today \.) (example)) (0 :gist)
        ;        | The '2' here represents a wildcard which matches up to 2 arbitrary
        ;        | tokens. Wildcards are very useful in taking into account long-term
        ;        | dependencies in an input, and allowing for more robust matching.
        ;        V
      2 (0 drive 2 by feat-someone 0)
        3 ((Someone drove me here today \.) (example)) (0 :gist)
    ; The following numbers show how indexing works in the
    ; reassembly patterns (i.e. the gist clause). In this case,
    ; the '3' in the gist clause corresponds to the 3rd token in the pattern,
    ; which in turn is the wildcard '1', and therefore will match whatever that
    ; wildcard matched to (e.g. "my"). Likewise, '4' corresponds to 'feat-someone',
    ; and will be matched to whichever specific word in the input had that feature.
    ;    1 2    3 4            5
    ;    | |    | |            |
      2 (0 with 1 feat-someone 0)
        3 ((I drove here today with 3 4 \.) (example)) (0 :gist)

      2 (0 myself 0)
        3 ((I drove myself here today \.) (example)) (0 :gist)
      2 ((I drove myself here today \.) (example)) (0 :gist)
    1 (0 ride 0)
      2 (0 got a ride 0)
        3 ((Someone drove me here today \.) (example)) (0 :gist)
      2 (0 with feat-someone 0)
        3 ((Someone drove me here today \.) (example)) (0 :gist)
      2 ((I drove myself here today \.) (example)) (0 :gist)
    1 (0 car 0)
      2 (0 feat-car-poss-by-me car 0)
        3 ((I drove myself here today \.) (example)) (0 :gist)
      2 (0 my own car 0)
        3 ((I drove myself here today \.) (example)) (0 :gist)
      2 (0 feat-someone car 0)
        3 ((Someone drove me here today \.) (example)) (0 :gist)
    1 (0 walk 0)
      2 ((I walked here today \.) (example)) (0 :gist)
    1 (0 bus 0)
      2 ((I took the bus here today \.) (example)) (0 :gist)
    
    ;; =========================
    ;; TODO: ADD NEW RULES HERE
    ;; =========================

    1 (0)
      2 ((NIL Gist \: nothing found \.) (example)) (0 :gist)

  ))
  

  ; The following can be ignored for the purposes of this tutorial.
  ; In a nutshell though, thematic-answer-... is meant to detect long-form
  ; responses, unbidden-answer-... is meant to detect gist clauses which
  ; may be an answer to a prompt other than the current one, and
  ; question-... is meant to detect questions by the user.
  (READRULES '*thematic-answer-from-example-input*
    '())

  (READRULES '*unbidden-answer-from-example-input*
    '())
		
  (READRULES '*question-from-example-input*
    '())

); end of eval-when
