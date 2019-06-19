
# Lissa tutorial (Ver 1 - 06/18/19):

This tutorial is meant to demonstrate how Lissa pattern transduction works.
There are two components to this tutorial: gist clause extraction, and ULF extraction.

## Running tests

To view and edit the rule files for both of these components, see `rules-input-gist.lisp` and `rules-input-ulf.lisp`.
Both files contain comments describing how the pattern matching algorithm and syntax work.

To test the components, start SBCL and do `(load "test")`. The program will prompt you for whether you're testing
the gist clause extraction or ULF extraction. Enter `g` for the former, and `u` for the latter. The program will also
prompt you if you want verbose printing, which will print the extracted and expected results for each test. The program
will run each test case and return the fraction that were correct.

Initially, the rule files aren't complete: the gist test cases get `10/15` correct, and the ULF test cases get `5/15` correct.
It's up to you to help improve them!

To view the test cases as well as to add your own, see `test.lisp`.

## Simulating Lissa

To see the gist clause extraction in action, you can start SBCL and do `(load "start")`. Lissa will ask a single question
about "how did you get here today?", and then will echo the extracted gist clause back to you.

For fun, you can also change Lissa's reactions to your answer, as well as reactions to a question you might ask, in
`rules-for-reaction.lisp` and `rules-for-question.lisp`, respectively. Note that the pattern matching syntax here is
the same as in the gist clause extraction, except without the topic key and with an :out directive instead of :gist.