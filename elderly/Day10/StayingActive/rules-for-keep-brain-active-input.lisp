(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
  
    ;; MEETING WITH KIM NOTES (8/8/2017)

    ;; Reading the newspaper
    ;; Reading book
    ;; Groups activity
    ;; Play card games
    ;; Sudoku
    ;; Church
    ;; Work volunteer
    ;; Puzzles

    (alt-religion church synagogue mosque)
    (alt-learn learn learning education course courses study studying research researching)

  ))
   

;; 	I like to exercise my brain as well as my body. What are some ways you keep your brain active as you age?
;;	(0 to keep my mind active 0)
;;	keep-brain-active
;;	(How can you keep your brain active ?)
;;	(3 How 2 keep your brain active 3)
	
(READRULES '*specific-answer-from-keep-brain-active-input*
  '(
  1 (0 read 2 newspaper 0)
    2 ((To keep my mind active I read newspaper \.) (keep-brain-active)) (0 :gist)
  1 (0 read 2 book 0)
    2 ((To keep my mind active I read books \.) (keep-brain-active)) (0 :gist)
  1 (0 group 2 activity 0)
    2 ((To keep my mind active I do group activities \.) (keep-brain-active)) (0 :gist)
  1 (0 card games 0)
    2 ((To keep my mind active I play card games \.) (keep-brain-active)) (0 :gist)
  1 (0 board games 0)
    2 ((To keep my mind active I play board games \.) (keep-brain-active)) (0 :gist)
  1 (0 sudoku 0)
    2 ((To keep my mind active I play sodoku \.) (keep-brain-active)) (0 :gist)
  1 (0 crossword 0)
    2 ((To keep my mind active I do crossword puzzles \.) (keep-brain-active)) (0 :gist)
  1 (0 puzzles 0)
    2 ((To keep my mind active I play puzzles \.) (keep-brain-active)) (0 :gist)
  1 (0 alt-religion 0)
    2 ((To keep my mind active I go to 2 \.) (keep-brain-active)) (0 :gist)
  1 (0 volunteer 0)
    2 ((To keep my mind active I volunteer \.) (keep-brain-active)) (0 :gist)
  1 (0 alt-learn 0)
    2 ((To keep my mind active I learn more \.) (keep-brain-active)) (0 :gist)
  1 (0)
    2 ((NIL Gist \: nothing found for how to keep my mind active \.) (keep-brain-active)) (0 :gist)
))
            
 (READRULES '*thematic-answer-from-keep-brain-active-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-keep-brain-active-input*
  '(
  
  ))
		
 (READRULES '*question-from-keep-brain-active-input*
  '(
  1 (0 what 2 you 0)
     2 (How can you keep your brain active ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (How can you keep your brain active ?) (0 :gist)
  ))

(READRULES '*reaction-to-keep-brain-active-input*
  '(
  1 (0 to keep my mind active 2 read newspaper 0)
    2 (It\'s great that I read the newspaper\, it\'s important to stay in touch with the news\.) (100 :out)
  1 (0 to keep my mind active 2 read books 0)
    2 (There are so many good books out there\, you just wish you could read them all\.) (100 :out)
  1 (0 to keep my mind active 2 do group activities 0)
    2 (Doing group activities is good for keeping my social skills sharp\.) (100 :out)
  1 (0 to keep my mind active 2 play card games 0)
    2 (Card games are a lot of fun\, you are not great at them though\.) (100 :out)
  1 (0 to keep my mind active 2 play board games 0)
    2 (You\'re generally not a big fan of board games\. You love chess though\!) (100 :out)
  1 (0 to keep my mind active 2 play sodoku 0)
    2 (Sodoku is a nice way to pass time\, it can be challenging sometimes though\.) (100 :out)
  1 (0 to keep my mind active 2 do crossword puzzles 0)
    2 (I have to have a lot of random knowledge to do crossword puzzles\. They\'re lots of fun though\.) (100 :out)
  1 (0 to keep my mind active 2 play puzzles 0)
    2 (Doing puzzles is an excellent way to sharpen my mind and have fun at the same time\.) (100 :out)
  1 (0 to keep my mind active 2 go to alt-religion 0)
    2 (You think going to religious services is a good way to stay part of a community too\.) (100 :out)
  1 (0 to keep my mind active 2 volunteer 0)
    2 (It\'s great that I can still maintain a sense of my community by volunteering\.) (100 :out)
  1 (0 to keep my mind active 2 learn more 0)
    2 (It\'s amazing how even when I think I know it all\, there\'s always something more to learn\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (You love doing small puzzles every day to try to keep your brain active\.) (100 :out)
  ))
); end of eval-when
