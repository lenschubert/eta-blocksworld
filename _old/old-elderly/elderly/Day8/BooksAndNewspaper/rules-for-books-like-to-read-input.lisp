(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
  (book-genre health fitness mystery mysteries suspense suspensful romance historical detective humor biographies
  autobiography art literature philosophy religion ethics science horror satire diaries cookbooks cookbook poetry
  fantasy funny comedy educational academic)
  (book-genre-two non historical science realistic alt-fiction)
  (alt-fiction fiction fictions)
  ))
   

;;	What kinds of books do you like to read?
;;	(0 I do not like to read books 0) 
;;	(0 I like 3 books 0)
;;	books-like-to-read
;;	(What kinds of books do you like to read ?)
;;	(3 What kinds of books 2 like to read 3)

	

(READRULES '*specific-answer-from-books-like-to-read-input*
  '(
  1 (0 book-genre-two book-genre-two 0)
    2 ((I like 2 3 books \.)  (books-like-to-read)) (0 :gist)
  1 (0 book-genre 0)
    2 ((I like 2 books \.)  (books-like-to-read)) (0 :gist)
  1 (0 audio 1 alt-book 0)
    2 ((I like audio books \.)  (books-like-to-read)) (0 :gist)
  1 (0 NEG 2 alt-read 0)
    2 ((I do not like to read books \.)  (books-like-to-read)) (0 :gist)
  1 (0)
    2 ((NIL Gist \: nothing found for the genre I like to read in books \.) (books-like-to-read)) (0 :gist)
))    
       
 (READRULES '*thematic-answer-from-books-like-to-read-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-books-like-to-read-input*
  '(
  1 (0 newspaper 0)
    2 ((I read newspaper \.)  (newspaper-how-often)) (0 :gist)
  ))
		
 (READRULES '*question-from-books-like-to-read-input*
  '(
  1 (0 what 2 you 0)
     2 (What kinds of books do you like to read ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (What kinds of books do you like to read ?) (0 :gist)
  1 (0 do you 1 like 0)
     2 (What kinds of books do you like to read ?) (0 :gist)
  1 (0 have you 2 read 0)
     2 (Have you read this book ?) (0 :gist)
  1 (0 have you 2 heard of 0)
     2 (Have you read this book ?) (0 :gist)
  1 (0 do you 2 read 0)
     2 (Do you like to read ?) (0 :gist)
  ))

(READRULES '*reaction-to-books-like-to-read-input*
  '( 
  1 (0 NEG like 1 read books 0)
    2 (It can be difficult to read sometimes\, it\'s okay to have fun doing other things\.) (0 :gist)
  1 (0 book-genre-two book-genre-two 0)
    2 (0 non alt-fiction 0)
      3 (Non fiction books can be interesting\, though you personally find them boring sometimes\.) (100 :out)
    2 (0 historical alt-fiction 0)
      3 (Historical fiction books can be interesting\, though you personally find them boring sometimes\.) (100 :out)
    2 (0 science alt-fiction 0)
      3 (You love science fiction books\! It\'s cool seeing the futuristic scenarios the authors make up\.) (100 :out)
    2 (0 realistic alt-fiction 0)
      3 (Realistic fiction books can be interesting\, though you personally find them boring sometimes\.) (100 :out)
    
  1 (0 book-genre 0)
    2 (0 health 0)
      3 (You think it\'s good to read health and fitness books\, so I can improve my own routines\.) (100 :out)
    2 (0 fitness 0)
      3 (You think it\'s good to read health and fitness books\, so I can improve my own routines\.) (100 :out)
    2 (0 mystery 0)
      3 (Mystery novels are fun to read\, they always keep you on the edge of your seat\.) (100 :out)
    2 (0 mysteries 0)
      3 (Mystery novels are fun to read\, they always keep you on the edge of your seat\.) (100 :out)
    2 (0 suspense 0)
      3 (Suspenseful novels are fun to read\, they always keep you on the edge of your seat\.) (100 :out)
    2 (0 suspensful 0)
      3 (Suspenseful novels are fun to read\, they always keep you on the edge of your seat\.) (100 :out)
    2 (0 detective 0)
      3 (Detective novels are fun to read\, they always keep you on the edge of your seat\.) (100 :out)
    2 (0 romance 0)
      3 (Romance novels are very cute\. You always find yourself rooting for the main character\.) (100 :out)
    2 (0 historical 0)
      3 (Historical novels can be interesting\, though you personally find them boring sometimes\.) (100 :out)
    2 (0 humor 0)
      3 (You love books that can cheer you up and make you laugh\.) (100 :out)
    2 (0 funny 0)
      3 (You love books that can cheer you up and make you laugh\.) (100 :out)
    2 (0 comedy 0)
      3 (You love books that can cheer you up and make you laugh\.) (100 :out)
    2 (0 biographies 0)
      3 (Biographies can be interesting\, though you personally find them boring sometimes\.) (100 :out)
    2 (0 autobiography 0)
      3 (Biographies can be interesting\, though you personally find them boring sometimes\.) (100 :out)
    2 (0 diaries 0)
      3 (Diaries can be interesting\, though you personally find them boring sometimes\.) (100 :out)
    2 (0 art 0)
      3 (Art novels are nice\, they help with my imagination and inspiration\.) (100 :out)
    2 (0 literature 0)
      3 (You never read academic books that often\, but it\'s awesome that people enjoy learning on their own\.) (100 :out)
    2 (0 philosophy 0)
      3 (You never read academic books that often\, but it\'s awesome that people enjoy learning on their own\.) (100 :out)
    2 (0 educational 0)
      3 (You never read academic books that often\, but it\'s awesome that people enjoy learning on their own\.) (100 :out)
    2 (0 academic 0)
      3 (You never read academic books that often\, but it\'s awesome that people enjoy learning on their own\.) (100 :out)
    2 (0 religion 0)
      3 (You think religious books can help somebody feel a sense of purpose and belonging\.) (100 :out)
    2 (0 ethics 0)
      3 (Ethics are pretty important to read about\, they help teach a person morality\.) (100 :out)
    2 (0 science 0)
      3 (Science is awesome\, it\'s good to follow the most recent developments in science and technology\.) (100 :out)
    2 (0 horror 0)
      3 (You don\'t like reading horror books\, they give you bad dreams at night\.) (100 :out)
    2 (0 satire 0)
      3 (There\'s some brilliant satire out there\. It\'s fun to read and makes you think twice about the things you believe in\.) (100 :out)
    2 (0 cookbook 0)
      3 (Cookbooks are always a good read\, they help me find interesting new recipes to try out\.) (100 :out)
    2 (0 cookbooks 0)
      3 (Cookbooks are always a good read\, they help me find interesting new recipes to try out\.) (100 :out)
    2 (0 poetry 0)
      3 (You love reading poetry\. It\'s so beautiful and artistic\.) (100 :out)
    2 (0 fantasy 0)
      3 (Fantasy novels are fun to read\. You love how immersive they are and how they let your imagination run wild\.) (100 :out)

  1 (0 audio 0)
    2 (You listen to audio books sometimes while doing other tasks\, like driving\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (You still have a lot of books on your reading list that you want to read eventually\.) (0 :out)
  ))
); end of eval-when
