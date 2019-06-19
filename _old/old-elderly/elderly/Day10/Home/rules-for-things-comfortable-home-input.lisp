(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

    ;; MEETING WITH KIM NOTES (8/8/2017)

    ;; Relational:
    ;; Parts of the home that remind them of their family
    ;; Sitting around kitchen table
    ;; Porch
    ;; spending time with people

    ;; Complaining: everything was awful, don’t have positive memory

    (alt-sitting sitting sit seat)
    (alt-spending spending spend being be hang hanging talk talking invite inviting)
    (alt-people people person friend friends alt-family)
    (alt-family family children grandchildren child grandchild son daughter grandson granddaughter niece nephew)
    (alt-sleepware bed mattress pillow pillows blanket blankets comforter quilt bedding sheets)
    (alt-comfortable comfortable soft cozy snug warm pleasant comfy smooth)
    (alt-furniture furniture sofa sofas couch couches chair chairs)
    (alt-fireplace fireplace furnace stove hearth)

  ))
   
;;  What are things you would do to make you feel comfortable in your home?
;;	(0 I would 6 at home to make me feel comfortable 0)
;;	things-comfortable-home
;;	(What would you do to make you feel comfortable in your home ?)
;;	(3 What 2 you do 2 make you feel comfortable 2 home 3)
	

(READRULES '*specific-answer-from-things-comfortable-home-input*
  '(
  1 (0 remind 2 of 2 alt-family 0)
    2 ((I would be reminded of family at home to make me feel comfortable \.) (things-comfortable-home)) (0 :gist)
  1 (0 alt-sitting 2 kitchen table 0)
    2 ((I would sit around the kitchen table at home to make me feel comfortable \.) (things-comfortable-home)) (0 :gist)
  1 (0 porch 0)
    2 ((I would spend time on the porch at home to make me feel comfortable \.) (things-comfortable-home)) (0 :gist)
  1 (0 alt-fireplace 0)
    2 ((I would use the fireplace at home to make me feel more comfortable \.) (things-comfortable-home)) (0 :gist)
  1 (0 alt-spending 3 alt-people 0)
    2 ((I would spend time with people at home to make me feel comfortable \.) (things-comfortable-home)) (0 :gist)
  1 (0 decorations 0)
    2 ((I would have decorations at home to make me feel more comfortable \.) (things-comfortable-home)) (0 :gist)
  1 (0 alt-sleepware 0)
    2 ((I would use good sleepware at home to make me feel more comfortable \.) (things-comfortable-home)) (0 :gist)
  1 (0 alt-comfortable 3 alt-furniture 0)
    2 ((I would use good furniture at home to make me feel more comfortable \.) (things-comfortable-home)) (0 :gist)
  1 (0)
    2 ((NIL Gist \: nothing found for things I would do at home to make me feel comfortable \.) (things-comfortable-home)) (0 :gist)
))
            
 (READRULES '*thematic-answer-from-things-comfortable-home-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-things-comfortable-home-input*
  '(
  
  ))
		
 (READRULES '*question-from-things-comfortable-home-input*
  '(
  1 (0 what 2 you 0)
     2 (What would you do to make you feel comfortable in your home ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (What would you do to make you feel comfortable in your home ?) (0 :gist)
  ))

(READRULES '*reaction-to-things-comfortable-home-input*
  '(
  1 (0 I would be reminded of family at home to make me feel comfortable 0)
    2 (Having good memories of a place can make it feel very warm and cozy\.) (100 :out)
  1 (0 I would sit around the kitchen table at home to make me feel comfortable 0)
    2 (You can imagine having a common spot to sit and spend my evening would be very relaxing\.) (100 :out)
  1 (0 I would spend time on the porch at home to make me feel comfortable 0)
    2 (It\'s very nice to just be able to sit on the porch and watch things happen outside\.) (100 :out)
  1 (0 I would use the fireplace at home to make me feel more comfortable 0)
    2 (You really love sitting by the fireplace and getting warm\, especially in the freezing winters here\.) (100 :out)
  1 (0 I would spend time with people at home to make me feel comfortable 0)
    2 (Inviting friends often is one way to keep my home comfortable\. It helps prevent loneliness as well\!) (100 :out)
  1 (0 I would have decorations at home to make me feel comfortable 0)
    2 (You have a lot of fun decorating your own spaces in a way that reflects your personality\.) (100 :out)
  1 (0 I would use good sleepware at home to make me feel comfortable 0)
    2 (Good bedding is important\, part of a house being comfortable is being able to sleep well at night\.) (100 :out)
  1 (0 I would use good furniture at home to make me feel comfortable 0)
    2 (You sometimes think that furniture can be too comfortable\! It is nice having soft couches to relax on though\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (You think that being comfortable in my home can come even from simple changes\, like nice decorations and cozy furniture\.) (100 :out)
  ))
); end of eval-when
