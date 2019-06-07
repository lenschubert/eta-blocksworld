(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; MEETING WITH KIM NOTES (8/4/2017)

  ;; Volunteer with church / in schools / tutoring / RSVP (organization in town which helps older people volunteer)
  ;; Involved in politics
  ;; Visit other older people
  ;; Help friends in senior living community
  ;; Help with bills
  ;; Check on neighbor
  ;; Take care of a spouse
  ;; Help with home delivered meals
  ;; Donate money
  ;; Help teach

  (organization-types church school schools teach teaching community hospital hospitals tutor tutoring charity kitchen RSVP festival)
  (alt-volunteer volunteer volunteering assist assisting help helping teach teaching support supporting)
  (alt-donate donate donating)
  (alt-politics politics government council committee administration)
  (alt-visit visit visiting meet meeting)
  (alt-others others other another)
  (alt-money money cash income finance financial bills expenses pay paying credit)
  (alt-neighbor neighbor neighbors neighbour neighbours)
  (relative-types relative relatives family son daughter child children kids spouse husband wife grandson granddaughter grandchildren grandchild grandkids cousin niece nephew)
  (alt-deliver deliver delivered delivering)
  (alt-meal meal meals food dinner)

  ))
   

;;	Sometimes work is one way to give back. What are some ways you give back to your community, others in your life, or society as a whole?
;;	(0 way to give back to your community 0)
;;	give-back-to-community
;;	(What are some ways you give back to your community ?)
;;	(3 What 2 ways 3 give back to your community 3)

	

(READRULES '*specific-answer-from-give-back-to-community-input*
  '(
  1 (0 alt-volunteer 3 organization-types 0)
    2 ((A way to give back to your community is to volunteer at organization-types \.) (give-back-to-community)) (0 :gist)
  1 (0 community service 0)
    2 ((A way to give back to your community is to volunteer at community service \.) (give-back-to-community)) (0 :gist)
  1 (0 alt-politics 0)
    2 ((A way to give back to your community is to get involved in politics \.) (give-back-to-community)) (0 :gist)
  1 (0 alt-visit 1 alt-others 0)
    2 ((A way to give back to your community is to visit others \.) (give-back-to-community)) (0 :gist)
  1 (0 alt-volunteer friends 0)
    2 ((A way to give back to your community is to help friends \.) (give-back-to-community)) (0 :gist)
  1 (0 alt-volunteer 3 alt-money 0)
    2 ((A way to give back to your community is to help with money \.) (give-back-to-community)) (0 :gist)
  1 (0 check 2 alt-neighbor 0)
    2 ((A way to give back to your community is to check on neighbors \.) (give-back-to-community)) (0 :gist)
  1 (0 care 2 relative-types 0)
    2 ((A way to give back to your community is to care for a 4 \.) (give-back-to-community)) (0 :gist)
  1 (0 alt-deliver 1 alt-meal 0)
    2 ((A way to give back to your community is delivering meals \.) (give-back-to-community)) (0 :gist)
  1 (0 alt-donate 0)
    2 ((A way to give back to your community is donating money \.) (give-back-to-community)) (0 :gist)
  1 (0)
       2 ((NIL Gist \: nothing found for a way to give back to your community \.) (give-back-to-community)) (0 :gist)
 ))
         
 (READRULES '*thematic-answer-from-give-back-to-community-input*
  '(
  
  ))

 (READRULES '*unbidden-answer-from-give-back-to-community-input*
  '(
  
  ))
		
 (READRULES '*question-from-give-back-to-community-input*
  '(
  1 (0 what 2 you 0)
     2 (What are some ways you give back to your community ?) (0 :gist)
  1 (0 how 2 you 0)
     2 (What are some ways you give back to your community ?) (0 :gist)
  1 (0 do 2 you 2 alt-volunteer 0)
     2 (What are some ways you give back to your community ?) (0 :gist)
  ))

(READRULES '*reaction-to-give-back-to-community-input*
  '(
  1 (0 volunteer at organization-types 0)
    2 (0 church 0)
      3 (Helping with church seems like a good experience\. I get to have a direct part in spreading good morality\.) (100 :out)
    2 (0 school 0)
      3 (It\'s great that I am able to pass down my knowledge to future generations\!) (100 :out)
    2 (0 schools 0)
      3 (It\'s great that I am able to pass down my knowledge to future generations\!) (100 :out)
    2 (0 teach 0)
      3 (It\'s great that I am able to pass down my knowledge to future generations\!) (100 :out)
    2 (0 teaching 0)
      3 (It\'s great that I am able to pass down my knowledge to future generations\!) (100 :out)
    2 (0 tutor 0)
      3 (It\'s great that I am able to pass down my knowledge to future generations\!) (100 :out)
    2 (0 tutoring 0)
      3 (It\'s great that I am able to pass down my knowledge to future generations\!) (100 :out)
    2 (0 hospital 0)
      3 (It must be nice helping at a hospital\, knowing that I am helping people get healthy again\.) (100 :out)
    2 (0 hospitals 0)
      3 (It must be nice helping at a hospital\, knowing that I am helping people get healthy again\.) (100 :out)
    2 (0 charity 0)
      3 (Giving to charity is a great way to help those who need it most\.) (100 :out)
    2 (0 kitchen 0)
      3 (Helping make food for other people to eat is an awesome way to give back\!) (100 :out)
    2 (Volunteering is a great way to give back\, it\'s very satisfying to do work to help other people\.) (100 :out)
  1 (0 volunteer at community service 0)
    2 (Community service is a great way to give back\, it\'s very satisfying to do work to help other people\.) (100 :out)
  1 (0 get involved in politics 0)
    2 (Getting involved in local politics is pretty important\. I get to use my experience to help make important decisions about my community\.) (100 :out)
  1 (0 visit others 0)
    2 (Visiting other people is definitely a good way to make friends\!) (100 :out)
  1 (0 help friends 0)
    2 (It\'s always satisfying to help out a friend in need\.) (100 :out)
  1 (0 help with money 0)
    2 (It can feel pretty good to give financial assistance to people who need it\.) (100 :out)
  1 (0 check on neighbors 0)
    2 (It\'s very kind to check on my neighbords now and then\.) (100 :out)
  1 (0 care for a relative-types 0)
    2 (It must make my 5 very happy to know I am there to care for them\!) (100 :out)
  1 (0 delivering meals 0)
    2 (That\'s very kind\, to help deliver food for other people to eat\.) (100 :out)
  1 (0 donating money 0)
    2 (Giving to charity is a great way to help those who need it most\.) (100 :out)
  1 (0 NIL Gist 0)
    2 (You feel very satisfied when you have the chance to give back to the community\.) (100 :out)
  ))
); end of eval-when
