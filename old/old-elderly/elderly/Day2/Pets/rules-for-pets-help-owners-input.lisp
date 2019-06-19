(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
  (per-ref me us we you them people person owner owners)
  (verb-make make makes making cause causes causing help helps helping keep keeps keeping get gets getting)
  (verb-show show shows showing give gives giving)
  (verb-love love loves appreciate appreciates)
  (noun-love love kindness appreciation)
  (noun-problems problems troubles)
  (noun-purpose purpose meaning)
  (noun-exercise exercise busy outside activity)
  (noun-happiness happiness wellness pleasure delight gladness satisfaction contentness joy therapy)
  (noun-partner partner partners helper helpers therapist therapists company companion)
  (relax relaxing relaxed relaxation)
  (stress stressed anxious)
  (protect protecting protects)
  ))

;;	How do pets help their owners ?
;;	pets-help-owners
;;	(0 I believe pets help their owners 0)
;;	from-pets-help-owners-input
;;		gist question: (1 how 2 pets help 3)

	
(READRULES '*specific-answer-from-pets-help-owners-input*
  '(
  1 (0 verb-make 1 per-ref 2 noun-exercise 0) ;; "getting us to go outside", "keeps me busy"
     2 ((I believe pets help their owners by getting them exercise \.)  (pets-help-owners)) (0 :gist)
  1 (0 verb-show 1 per-ref 2 noun-exercise 0) ;; "giving us much needed exercise"
     2 ((I believe pets help their owners by getting them exercise \.)  (pets-help-owners)) (0 :gist)
  1 (0 verb-make 1 per-ref 2 GOODSTATE 0) ;; "make me really happy", "keeping us cheerful"
     2 ((I believe pets help their owners by making them happy \.)  (pets-help-owners)) (0 :gist)
  1 (0 verb-make 1 per-ref 2 less BADSTATE 0) ;; "making me feel less sad"
     2 ((I believe pets help their owners by making them happy \.)  (pets-help-owners)) (0 :gist)
  1 (0 verb-show 1 per-ref 2 noun-happiness 0) ;; "show me happiness", "giving me therapy"
     2 ((I believe pets help their owners by making them happy \.)  (pets-help-owners)) (0 :gist)
  1 (0 forget 3 noun-problems 0) ;; "help me forget about all my troubles"
     2 ((I believe pets help their owners by making them happy \.)  (pets-help-owners)) (0 :gist)
  1 (0 get 4 noun-love 0) ;; 
     2 ((I believe pets help their owners by showing them love \.)  (pets-help-owners)) (0 :gist)
  1 (0 verb-show 1 per-ref 2 noun-love 0) ;; "show us lots of love", "give me kindness"
     2 ((I believe pets help their owners by showing them love \.)  (pets-help-owners)) (0 :gist)
  1 (0 per-ref 1 verb-love 0) ;; "owners love their pets", "we love our pets"
     2 ((I believe pets help their owners by showing them love \.)  (pets-help-owners)) (0 :gist)
  1 (0 verb-make 1 per-ref 2 noun-purpose 0) ;; "helping us have a purpose"
     2 ((I believe pets help their owners by helping them have a purpose \.)  (pets-help-owners)) (0 :gist)
  1 (0 verb-show 1 per-ref 2 noun-purpose 0) ;; "showing me meaning in life"
     2 ((I believe pets help their owners by helping them have a purpose \.)  (pets-help-owners)) (0 :gist)
  1 (0 being 2 noun-partner 0) ;; "being a good partner", "being my best therapist"
     2 ((I believe pets help their owners by keeping them company \.)  (pets-help-owners)) (0 :gist)
  1 (0 keeping 2 company 0) ;; "keeping us company"
     2 ((I believe pets help their owners by keeping them company \.)  (pets-help-owners)) (0 :gist)
  1 (0 keeping 1 per-ref 2 lonely 0) ;; "keeping a person from being lonely"
     2 ((I believe pets help their owners by keeping them company \.)  (pets-help-owners)) (0 :gist)
  1 (0 helping 3 loneliness 0) ;; "helping with my loneliness"
     2 ((I believe pets help their owners by keeping them company \.)  (pets-help-owners)) (0 :gist)
  1 (0 good company 0) ;; "they are good company"
     2 ((I believe pets help their owners by keeping them company \.)  (pets-help-owners)) (0 :gist)
  1 (0 companionship 0) ;; "their companionship"
     2 ((I believe pets help their owners by keeping them company \.)  (pets-help-owners)) (0 :gist)
   1 (0 relax 0) ;; 
     2 ((I believe pets help their owners by making them relaxed \.)  (pets-help-owners)) (0 :gist)
  1 (0 stress 0) ;; 
     2 ((I believe pets help their owners by making them relaxed \.)  (pets-help-owners)) (0 :gist)
  1 (0 protect 0) ;; 
     2 ((I believe pets help their owners by protecting their owners \.)  (pets-help-owners)) (0 :gist)
   1 (0)
      2 ((NIL Gist \: nothing found for how I believe pets help their owners \.) (pets-help-owners)) (0 :gist)
))
       
       
 (READRULES '*thematic-answer-from-pets-help-owners-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-pets-help-owners-input*
  '(

  ))
		
 (READRULES '*question-from-pets-help-owners-input*
  '(
  1 (0 what do you 0)
     2 (How do pets help their owners ?) (0 :gist)
  ))

(READRULES '*reaction-to-pets-help-owners-input*
  '( 
  1 (0 getting them exercise 0)
     2 (You think getting exercise as I get older is important and pets definitely help with that\.) (100 :out)
  1 (0 making them happy 0)
     2 (That\'s great\. It\'s awesome how pets can give their owners joy even during unhappy times\.) (100 :out)
  1 (0 showing them love 0)
     2 (The relationship that a person can form with their pet really is quite amazing\.) (100 :out)
  1 (0 helping 3 purpose 0)
     2 (It\'s great how pets can help show us meaning in life\.) (100 :out)
  1 (0 keeping them company 0)
     2 (It really is nice that our pets can also be such loyal partners\.) (100 :out)
  1 (0 making them relaxed 0)
     2 (It\'s really nice that pets can help in soothing their ownser\'s stress \.) (100 :out)
  1 (0 protect 2 owners 0)
     2 (It\'s great how pets can help us in everyday life \.) (100 :out)
  
  1 (0 NIL Gist 0)
     2 (You think pets can help people quite a lot\.) (100 :out)
	))
); end of eval-when
