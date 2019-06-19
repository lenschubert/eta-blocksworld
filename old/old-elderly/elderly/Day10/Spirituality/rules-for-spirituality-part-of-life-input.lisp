(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

    ;; MEETING WITH KIM NOTES (8/8/2017)

    ;; Pray
    ;; Go to services
    ;; Watching tv programs
    ;; Doing meditation
    ;; Reading books
    ;; Being in nature

    (alt-watch watch watching listen listening)
    (alt-read read reading)
    (alt-give give giving show showing teach teaching)
    (alt-hope hope purpose meaning belonging belong mission destiny)
    (alt-charity charity volunteer volunteering)

  ))
   

;; 	Many people I've talked with, tell me they find ways to experience and express some form of spirituality either parts of organized religion or not.
;;	What ways is spirituality a part of your life?
;;	(0 spirituality is not a part of my life 0)
;;	(0 spirituality is a part of my life 0)
;;	spirituality-part-of-life
;;	(What ways is spirituality a part of your life ?)
;;	(3 What ways 2 spirituality a part of your life 3)
	
(READRULES '*specific-answer-from-spirituality-part-of-life-input*
  '(
  1 (0 pray 0)
    2 ((Spirituality is a part of my life by praying \.) (spirituality-part-of-life)) (0 :gist)
  1 (0 go 1 services 0)
    2 ((Spirituality is a part of my life by going to services \.) (spirituality-part-of-life)) (0 :gist)
  1 (0 alt-watch 3 programs 0)
    2 ((Spirituality is a part of my life by watching programs \.) (spirituality-part-of-life)) (0 :gist)
  1 (0 meditation 0)
    2 ((Spirituality is a part of my life by doing meditation \.) (spirituality-part-of-life)) (0 :gist)
  1 (0 being 2 nature 0)
    2 ((Spirituality is a part of my life by being in nature \.) (spirituality-part-of-life)) (0 :gist)
  1 (0 alt-read 1 books 0)
    2 ((Spirituality is a part of my life by reading books \.) (spirituality-part-of-life)) (0 :gist)
  1 (0 alt-give 4 alt-hope 0)
    2 ((Spirituality is a part of my life by giving me hope \.) (spirituality-part-of-life)) (0 :gist)
  1 (0 alt-charity 0)
    2 ((Spirituality is a part of my life by doing charity \.) (spirituality-part-of-life)) (0 :gist)
  1 (0 giving 1 back 0)
    2 ((Spirituality is a part of my life by doing charity \.) (spirituality-part-of-life)) (0 :gist)
  1 (0 NEG 1 sure 0)
    2 ((Spirituality is not a part of my life \.) (spirituality-part-of-life)) (0 :gist)
  1 (0 NEG 1 know 0)
    2 ((Spirituality is not a part of my life \.) (spirituality-part-of-life)) (0 :gist)
  1 (0 it 2 NEG 0)
    2 ((Spirituality is not a part of my life \.) (spirituality-part-of-life)) (0 :gist)
  1 (0 NEG 1 spiritual 0)
    2 ((Spirituality is not a part of my life \.) (spirituality-part-of-life)) (0 :gist)
  1 (0 am 2 athiest 0)
    2 ((Spirituality is not a part of my life \.) (spirituality-part-of-life)) (0 :gist)
  1 (0)
    2 ((NIL Gist \: nothing found for if spirituality is a part of my life \.) (spirituality-part-of-life)) (0 :gist)
))
            
 (READRULES '*thematic-answer-from-spirituality-part-of-life-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-spirituality-part-of-life-input*
  '(
  
  ))
		
 (READRULES '*question-from-spirituality-part-of-life-input*
  '(
  1 (0 what religion 2 you 0)
     2 (Are you religious ?) (0 :gist)
  1 (0 are 2 you 2 religious 0)
     2 (Are you religious ?) (0 :gist)
  1 (0 do 2 you 2 follow 0)
     2 (Are you religious ?) (0 :gist)
  1 (0 are 2 you 2 spiritual 0)
     2 (Are you religious ?) (0 :gist)
  1 (0 is spirituality 4 your life 0)
     2 (Are you religious ?) (0 :gist)
  1 (0 what 2 you 0)
     2 (What ways is spirituality a part of your life ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (What ways is spirituality a part of your life ?) (0 :gist)
  ))

(READRULES '*reaction-to-spirituality-part-of-life-input*
  '(
  1 (0 spirituality is a part of my life 2 praying 0)
    2 (Sometimes praying can help guide my choice in tough decisions\.) (100 :out)
  1 (0 spirituality is a part of my life 2 going to services 0)
    2 (Going to services sounds like a good way of being part of a community\.) (100 :out)
  1 (0 spirituality is a part of my life 2 watching programs 0)
    2 (Watching programs about spirituality must be very educational\.) (100 :out)
  1 (0 spirituality is a part of my life 2 doing meditation 0)
    2 (You think it\'s very good for a person to spend some time meditating every day\.) (100 :out)
  1 (0 spirituality is a part of my life 2 being in nature 0)
    2 (Spending time in nature every day can be very refreshing\.) (100 :out)
  1 (0 spirituality is a part of my life 2 reading books 0)
    2 (Reading books about spirituality must be very educational\.) (100 :out)
  1 (0 spirituality is a part of my life 2 giving me hope 0)
    2 (It\'s good to stay hopeful about the future and to understand my purpose in the world\.) (100 :out)
  1 (0 spirituality is a part of my life 2 doing charity 0)
    2 (It\'s awesome that giving back to the community is meaningful to me\!) (100 :out)
  1 (0 spirituality is NEG 2 part of my life 0)
    2 (It\'s okay to not be spiritual\, there are other ways to find meaning in life\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (It\'s important to find meaning in my life\. You think spirituality is a common way to do this\, though there are others too\.) (100 :out)
  ))
); end of eval-when
