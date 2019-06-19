(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
    (year-num one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen twenty)
    (grade-num first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelveth)
    (alt-grade grade year years)
    (college university)
    (school-type high secondary primary graduate public private)
    (degree-type bachelor bachelors master masters phd doctor postdoctor postdoc)
    ))
   

;;	How far did you go in school?
;;	(0 I went to school 0)   
;;	education-how-far
;;	(How far did you go in school ?)
;;	(3 how far 3 go in school 3)

	

(READRULES '*specific-answer-from-education-how-far-input*
  '(
    1 (0 college 0)
      2 ((I went to school for college \.) (education-how-far)) (0 :gist)
  1 (0 school-type school 0)
    2 ((I went to school for 2 school \.) (education-how-far)) (0 :gist)
  1 (0 school-type 0)
    2 ((I went to school for 2 \.) (education-how-far)) (0 :gist)
  1 (0 degree-type 0)
    2 ((I went to school for 2 degree \.) (education-how-far)) (0 :gist)
  1 (0 grade-num alt-grade 0)
    2 ((I went to school for 2 grade \.) (education-how-far)) (0 :gist)
  1 (0 year-num alt-grade 0)
    2 ((I went to school for 2 years \.) (education-how-far)) (0 :gist)
   1 (0)
       2 ((NIL Gist \: nothing found for how far I went to school \.) (education-how-far)) (0 :gist)
))
       
       
 (READRULES '*thematic-answer-from-education-how-far-input*
  '())

 (READRULES '*unbidden-answer-from-education-how-far-input*
  '(
  ))
		
 (READRULES '*question-from-education-how-far-input*
  '(
  1 (0 how 2 you 2 go 1 school 0)
     2 (How can you go to school ?) (0 :gist)
  1 (0 how 2 you 2 taking classes 0)
     2 (How can you go to school ?) (0 :gist)
  1 (0 what 2 you 0)
     2 (How far did you go in school ?) (0 :gist)
  1 (0 how 2 you 3 school 0)
     2 (How far did you go in school ?) (0 :gist)
  ))

(READRULES '*reaction-to-education-how-far-input*
  '(1 (0 colledge 0)
    2 (It is so cool that I went to college\. I should have been pretty much into studying\.) (100 :out)
  1 (0 grade-num grade 0)
    2 (2 grade is still a decent enough education\. Enough to get me where I am today\.) (100 :out)
  1 (0 year-num years 0)
    2 (2 years is a decent amount of time for education\. You are sure I must have learned a lot in that time\.) (100 :out)
  1 (0 school-type school 0)
    2 (You really enjoyed 2 school\. You hope I had a good time there\.) (100 :out)
  1 (0 school-type 0)
    2 (You really enjoyed 2 \. You hope I had a good time there\.) (100 :out)
  1 (0 degree-type degree 0)
    2 (Getting my 2 degree sounds like an impressive goal\. You are sure I must have worked hard to get there\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (It\'s good that my education helped me get where I am today\.) (100 :out)
  ))
); end of eval-when
