
# Eta Blocksworld (Ver 1 - 06/21/19):

## How to run

Start SBCL in the top level directory and enter `(load "start.lisp")`. The dialogue will prompt
you for an ID (just enter anything here). It will then begin with a getting-to-know question
(currently just asking you for your name), and then will give a series of 10 prompts.

Eta has two modes: text mode, and live mode. In `start.lisp`, the mode can be changed at the very
top of the file. Use `(defparameter *mode* nil)` for text mode, and `(defparameter *mode* t)` for live mode.

In text mode, simply enter the query into the command line when the system prompts you to do so. The system will
output the gist clause that was extracted, the corresponding ulf that it extracted, and will then react by
echoing your query back to you (if it was a spatial question).

In live mode, the system will await for an input to be set in `input.lisp` as `(setq *next-input* "Input here")`,
where the value of \*next-input\* is a string. If the input was a spatial question, the system will output the
extracted ulf to `ulf.lisp` as `(setq *next-ulf* '(((PRES BE.V) THERE.PRO ...) ?))`, where the value of \*next-ulf\* is
some list.

**NOTE**: the value of \*next-ulf\* might not necessarily be a ulf; it could be `(:out SOME RESPONSE ...)`. The
ulf could also have an additional *poss-ques* wrapper around it, e.g. `'(POSS-QUES (((PRES BE.V) THERE.PRO ...) ?))`.
Currently, both of these should be dealt with by Georgiy's system externally to Eta, although this should be changed in
the future.

Finally, in the case of a spatial question, the system will await a response in `reaction.lisp` as
`(setq *next-reaction* "Reaction here")`, where the value of \*next-reaction\* is a string. If the input
was not a spatial question, the system will skip this step and form a reaction as normal. Finally, the
system will output the reaction to `output.txt`, on a single line prepended by `#: ` (it will also form
initial prompts this way).

## Task breakdown

* Connect inputs/outputs with Georgiy's blocksworld system **(mostly done by this point)**:
  - Text would need to be taken from the ASR output rather than the command line. Much of this functionality should already be
    in place from the elderly study, however.
  - The ulf extracted at each step would need to be relayed to Georgiy's system for processing.
  - The output response from Georgiy's system would need to be hooked back up to the response rule
    file (which currently just echoes the user's query back to them - see `rules/spatial-question/rules-for-spatial-question-reaction.lisp`).

* Expanding the gist clause rule files:
  - Creating rules to catch non-query ("small talk") questions and inputs from the user - see `rules/spatial-questions/rules-for-spatial-question-input.lisp` and `rules/choose-reaction-to-input.lisp`.
  - Creating the rules to detect and preprocess spatial questions (primarily removing prefixed and suffixed utterances that the user might attach to their queries) **(mostly done by this point)** - see `rules/spatial-question/rules-for-spatial-question-input.lisp`.
  - Finding some way to use the previous utterance to help extract gist clauses. Not yet sure how this should be done, but it would be
    impemented in `rules/choose-gist-clause-trees-for-input.lisp`.

* Expanding the coverage of the ulf rule files:
  - Len is primarily working on this, and I will incorporate his changes in `rules/spatial-question/rules-for-spatial-question-ulf.lisp`.

* Overall finding more elegant ways to implement Eta functionality, such as how it awaits a reaction from an external system currently.