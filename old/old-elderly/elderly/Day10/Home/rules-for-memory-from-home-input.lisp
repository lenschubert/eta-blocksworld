(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

    ;; MEETING WITH KIM NOTES (8/8/2017)

    ;; They don’t have any memories

    ;; Everything in the past was awful
    ;; Don’t have positive memories

    ;; Maybe detect a couple common things, but other than that responses might
    ;; be pretty open ended, so just make a general "oh, that's nice" type comment

  (alt-pet pet pets cat cats dog dogs fish bird birds)

  ))
   

;;	I have many memories of the home I grew up in. Could you tell me about a positive memory you have of one of your homes?
;;	(0 memory I have of one of my homes 0)
;;	memory-from-home
;;	(What is a memory you have of one of your homes ?)
;;	(3 What 2 memory 6 your homes 3)


;; NOTE: New Gist Clause: "I do not have memory of any of my homes"

(READRULES '*specific-answer-from-memory-from-home-input*
  '(
  1 (0 alt-family 0)
    2 ((A memory I have of one of my homes is being with family \.) (memory-from-home)) (0 :gist)
  1 (0 alt-sitting 2 kitchen table 0)
    2 ((A memory I have of one of my homes is sitting around the kitchen table \.) (memory-from-home)) (0 :gist)
  1 (0 porch 0)
    2 ((A memory I have of one of my homes is sitting on the porch \.) (memory-from-home)) (0 :gist)
  1 (0 alt-fireplace 0)
    2 ((A memory I have of one of my homes is sitting by the fireplace \.) (memory-from-home)) (0 :gist)
  1 (0 alt-pet 0)
    2 ((A memory I have of one of my homes is being with pets \.) (memory-from-home)) (0 :gist)

  1 (0 NEG 1 have any memories 0)
    2 ((I do not have memory of any of my homes \.) (memory-from-home)) (0 :gist)
  1 (0 NEG 1 remember 2 anything 0)
    2 ((I do not have memory of any of my homes \.) (memory-from-home)) (0 :gist)
  1 (0 everything 3 was BADQUALITY 0)
    2 ((The memory I have of one of my homes is it was bad \.) (memory-from-home)) (0 :gist)
  1 (0 it 3 was BADQUALITY 0)
    2 ((The memory I have of one of my homes is it was bad \.) (memory-from-home)) (0 :gist)
  1 (0 NEG 3 positive memories 0)
    2 ((The memory I have of one of my homes is it was bad \.) (memory-from-home)) (0 :gist)
   1 (0)
    2 ((NIL Gist \: nothing found for memory I have of one of my homes \.) (memory-from-home)) (0 :gist)
))
            
 (READRULES '*thematic-answer-from-memory-from-home-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-memory-from-home-input*
  '(
  
  ))
		
 (READRULES '*question-from-memory-from-home-input*
  '(
  1 (0 what 2 you 0)
     2 (What is a memory you have of one of your homes ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (What is a memory you have of one of your homes ?) (0 :gist)
  1 (0 do 2 you 0)
     2 (What is a memory you have of one of your homes ?) (0 :gist)
  1 (0 is there 2 positive memory 1 you 0)
     2 (What is a memory you have of one of your homes ?) (0 :gist)
  ))

(READRULES '*reaction-to-memory-from-home-input*
  '(
  1 (0 memory I have of one of my homes 2 being with family 0)
    2 (The time I spend with family can leave the most permanent memories\.) (100 :out)
  1 (0 memory I have of one of my homes 2 sitting around the kitchen table 0)
    2 (Sitting around the kitchen table sounds like a very warm memory\.) (100 :out)
  1 (0 memory I have of one of my homes 2 sitting on the porch 0)
    2 (You\'re sure the time I spent on the porch was very relaxing\.) (100 :out)
  1 (0 memory I have of one of my homes 2 sitting by the fireplace 0)
    2 (Sitting by the fireplace sounds like a very comfortable memory\. You hope you can get a house with a fireplace one day\.) (100 :out)
  1 (0 memory I have of one of my homes 2 being with pets 0)
    2 (You\'re sure my pets were very cute\.) (100 :out)
  1 (0 memory I have of one of my homes 2 was bad 0)
    2 (Sometimes past homes can bring back bad memories\. Best to just not think of it\.) (100 :out)
  1 (0 NEG have memory of any 2 homes 0)
    2 (Sometimes it\'s easy to forget what happened in the past\. It\'s a good thing to not dwell too much in the past though\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (Thank me for telling you about my memories\.) (100 :out)
  ))
); end of eval-when
