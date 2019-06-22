
# Eta Blocksworld (Ver 1 - 06/21/19):

NOTE: Readme to be updated soon.

The dialogue can be run by starting SBCL and doing `(load "start.lisp")`. The dialogue begins
with a getting-to-know question (currently just asking the user for their name), listens for a 
reply, and reacts to that.

Then the system asks 10 "prompt" questions. Currently, the gist clause extracted for each
user query is just the query itself prepended by "Spatial question :". The system will
currently just react to each query by echoing the query back to the user. Additionally,
for spatial questions, the system will try to extract ulf from the gist clauses and attach
those as features to that action in the dialogue plan.

The most pressing things to do right now:
* Connect inputs/outputs with Georgiy's blocksworld system:
  - Text would need to be taken from the ASR output rather than the command line. Much of this functionality should already be
    in place from the elderly study, however.
  - The ulf extracted at each step would need to be relayed to Georgiy's system for processing.
  - The output response from Georgiy's system would need to be hooked back up to the response rule
    file (which currently just echoes the user's query back to them - see `rules/spatial-question/rules-for-spatial-question-reaction.lisp`).

* Expanding the gist clause rule files:
  - Creating rules to catch non-query questions and inputs from the user - see `rules/choose-reaction-to-input.lisp`. Currently,
    in that file, the only question that's detected is "what is your name", from the getting-to-know stage, in case the user asks
    the system for its name. We would need to expand that with possible questions that aren't actual queries. We can't simply detect
    any wh_ question for example, since some wh_ questions will be queries and should be processed differently.
  - Creating the rules to simplify user queries before the ulf is extracted, by smoothing over interjections for instance. These should
    be implemented in `rules/spatial-question/rules-for-spatial-question-input.lisp`.
  - Finding some way to use the previous utterance to help extract gist clauses. Not yet sure how this should be done, but it would be
    impemented in `rules/choose-gist-clause-trees-for-input.lisp`.

* Expanding the ulf rule files:
  - Len is primarily working on this, and I will incorporate his changes in `rules/spatial-question/rules-for-spatial-question-ulf.lisp`.