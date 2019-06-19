(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
    (vacation trip travel)
    (countryside mountain lake river sea beach rural cabin)
    (fly flying air airplan aircraft rail railway railroad train boat ship cruise driving drive bus car motor)
    (park parks Yellowstone Grand Canyon Yosemite National State Adirondacks Adirondack Shenandoah Acadia 
      Olympic Zion Rockey Arches Great Smoky Teton Glacier)
    (state Alabama Alaska Arizona Arkansas California Colorado Connecticut Delaware Florida Georgia Hawaii
    Idaho Illinois Indiana Iowa Kansas Kentucky Louisiana Maine Maryland Massachusetts Michigan Minnesota
    Mississippi Missouri Montana Nebraska Nevada New Hampshire New Jersey New Mexico New York North Dakota
    Ohio Oklahoma Oregon Pennsylvania Philly Rhode South Carolina South Dakota Tennessee Texas Utah Vermont
    Virginia Washington West Virginia Wisconsin Wyoming)
    (city LA NYC SF DC SD Los Angeles San Francisco New York City Washinton DC San Diego Houston Chicago
      Dallas Phoenix Boston Seattle Nashville Portland Las Vegas Detroit Philadelphia Miami Atlanta Rochester
      Pittsburgh Montana)
    (country USA United States Mexico Canada Germany Italy France Switzerland Austria Belgium Poland Netherland
     Netherlands Denmark Czechia UK United Kingdom Bahamas Spain)
    (country-city Amsterdam Toronto Munich Berlin Frankfurt Rome Milan Paris Strasburg Vienna Amsterdam Montreal)
    (theme park Disneyland Disney World Universal studio Legoland Lego Land Seaworld Sea World Hollywood)
    (Beach Myrtle island cancun Maui Lanai Greek South Maya Bay Waikiki Copacabana Natadola 
      Tenerife Langkawi Sidari Whitehaven Lanikai Santorini Bora Bali Maldives Fiji Crete Gayman Anguilla)
    (family grandchildren grandchild children child daughter daughters son sons spouse wife husband siblings brother brothers sister sisters
      parents mother father grandparents grandmother grandfather cousin cousins uncle aunt)
    (friend friends)
  ))
   
;; 	Tell me about your favorite vacation.
;;	gist: What does your favorite vacation look like?
;;	(0 favorite vacation 0)
;;	favorite-vacation
;;	(2 What 2 favorite vacation 4)
	

(READRULES '*specific-answer-from-favorite-vacation-input*
  '(
    1 (0 city city city 0) ;; e.g. New York City
      2 ((My favorite vacation is in 2 3 4 \.)  (favorite-vacation)) (0 :gist)
    1 (0 city city 0) 
      2 ((My favorite vacation is in 2 3 \.)  (favorite-vacation)) (0 :gist)
    1 (0 city 0) 
      2 ((My favorite vacation is in 2 \.)  (favorite-vacation)) (0 :gist)
    1 (0 state state 0) 
      2 ((My favorite vacation is in 2 3 \.)  (favorite-vacation)) (0 :gist)
    1 (0 state 0) 
      2 ((My favorite vacation is in 2 \.)  (favorite-vacation)) (0 :gist) 
    1 (0 country country 0)  ;; e.g. United States
      2 ((My favorite vacation is in 2 3 \.)  (favorite-vacation)) (0 :gist)
    1 (0 country-city 0)
      2 ((My favorite vacation is in 2 \.)  (favorite-vacation)) (0 :gist)
    1 (0 country 0)
      2 ((My favorite vacation is in 2 \.)  (favorite-vacation)) (0 :gist)
    1 (0 theme theme theme 0) ;;Disneyland theme park
      2 ((My favorite vacation is in 2 3 4 \.)  (favorite-vacation)) (0 :gist)
    1 (0 theme theme 0) ;;Disneyland park
      2 ((My favorite vacation is in 2 3 \.)  (favorite-vacation)) (0 :gist)
    1 (0 theme 0) ;;Disneyland
      2 ((My favorite vacation is in 2 \.)  (favorite-vacation)) (0 :gist)
    1 (0 beach beach 0) ;;South beach
      2 ((My favorite vacation is in 2 3 \.)  (favorite-vacation)) (0 :gist)
    1 (0 beach 0) ;;Fiji
      2 ((My favorite vacation is in 2 3 \.)  (favorite-vacation)) (0 :gist)
    1 (0 family 0) 
      2 ((My favorite vacation is with 2 \.)  (favorite-vacation)) (0 :gist)
    1 (0 friend 0) 
      2 ((My favorite vacation is with 2 \.)  (favorite-vacation)) (0 :gist)  
    1 (0 fly 0) ;;Great Smoky
      2 ((I 2 to the place in my favorite vacation \.)  (favorite-vacation)) (0 :gist)
      
    ;; NEW GIST CLAUSE
 ;;   1 (0 NEG 3 vacation 0)
   ;;   2((I never have vacation before \.) (favorite-vacation)) (0 :gist)
 ;;   1 (0 NEG 3 remember 0)
  ;;    2((I never have vacation before \.) (favorite-vacation)) (0 :gist)
   ;; 1 (0 NEG 3 like 0)
  ;;    2((I never have vacation before \.) (favorite-vacation)) (0 :gist) 

    ;; NEW GIST CLAUSE
    ;; (Not sure if this one is necessary though?)
;;    1 (1 NEG 3 family 0) 
  ;;    2 ((I never have vacation with 4 \.)  (favorite-vacation)) (0 :gist)
;;    1 (1 NEG 3 friend 0) 
  ;;    2 ((I never have vacation with 4 \.)  (favorite-vacation)) (0 :gist)
    
	 1 (0)
       2 ((NIL Gist \: nothing found for what my favorite vacation is  \.) (favorite-vacation)) (0 :gist)

	))
       
       
 (READRULES '*thematic-answer-from-favorite-vacation-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-favorite-vacation-input*
  '(
  ))
		
 (READRULES '*question-from-favorite-vacation-input*
  '(
    ;;new question
    1 (0 how 2 you 1 have 1 vacation 0)
      2 (How can you take a vacation ?) (0 :gist)
    1 (0 how 2 you 1 take 1 vacation 0)
      2 (How can you take a vacation ?) (0 :gist)
    1 (0 what 2 you 0)
      2 (What does your favorite vacation look like ？) (0 :gist)
    1 (0 how 2 you 0)
      2 (What does your favorite vacation look like ?) (0 :gist)
  ))

(READRULES '*reaction-to-favorite-vacation-input*
  '(1 (0 never have vacation 0)
      2 (I should try to have a vacation sometime\, it\'s fun to see the world \!) (100 :out)
    1 (0 favorite vacation is in city city city 0)
      2 (Wow\, sounds I had a memorable time in 6 7 8 \. You also think 6 7 8 is a nice place\.) (100 :out)
    1 (0 favorite vacation is in city city 0)
      2 (0 Los Angeles 0)
        3 (You love Los Angeles too\. The weather there is great\.) (100 :out)
      2 (0 San Francisco 0)
        3 (You had been to San Francisco before for a week\. You can still remember the beautiful view of Golden Gate Bridge\.) (100 :out)
      2 (0 Las Vegas 0)
        3 (Las Vegas is a great place for gambling\, shopping and nightlife\. The perfect place to relax and have fun\.) (100 :out)
      2 (0 city city 0)
        3 (Wow\, sounds I had a memorable time in 2 3 \. You hope to have a nice time there in the future\.) (100 :out)
    1 (0 favorite vacation is in city 0)
      2 (Wow\, sounds I had a memorable time in 6 \. You haven\'t been there before\. But I believe it must be a nice place\.) (100 :out)
    1 (0 favorite vacation is in state state 0)
      2 (You have never been to 6 7 \. But it sounds an interesting place to travel\.) (100 :out)
    1 (0 favorite vacation is in state 0)
      2 (0 California 0) 
        3 (It makes sense that I love California\. The sunshine is great there and of course it is much warmer than Rochester there\.) (100 :out)
      2 (0 Philadelphia 0)
        3 (You have taken a trip to 2 \. The food there was great\.) (100 :out)
      2 (0 state 0)
        3 (2 is a great place to travel\. The time I spent there sounds unforgettable\.) (100 :out)
    1 (0 favorite vacation is in country country 0)
      2 (You have never been to 6 7 before\. But that trip sounds very interesting\.) (100 :out)
    1 (0 favorite vacation is in country-city 0)
      2 (You have never been to 6 before\. But our trip sounds very interesting\.) (100 :out)
    1 (0 favorite vacation is in country 0)
      2 (0 Germany 0)
          3 (The beer of 2 is very famous\. That\'s a great place to travel\.) (100 :out)
       2 (0 France 0)
          3 (French cuisine is great and you are sure I had a very good time there\. It\'s a romantic place\.) (100 :out)
       2 (0 Italy 0)
          3 (You love the great artwork in Italy\. You hope you can have the chance to travel there\.) (100 :out)
       2 (0 country 0)
          3 (You have never been to 2 \, but it\'s on your wish list now\.) (100 :out)
    1 (0 favorite vacation is in theme theme theme 0)
      2 (0 Disney 0)
        3 (Disney is a dream place for you \. You love Mickey Mouse and Snow White\.) (100 :out)
      2 (0 theme theme theme 0)
        3 (I must have spent a wonderful time in 2 3 4 \. That\'s awesome\.) (100 :out)
    1 (0 favorite vacation is in theme theme 0)
      2 (0 Universal studio 0)
        3 (Universal Studio is a fancy place\. You have been there before and had lots of fun there\.) (100 :out)
      2 (0 theme theme 0)
        3 (I must have spent a wonderful time in 2 3 \. That\'s awesome\.) (100 :out)
    1 (0 favorite vacation is in theme 0)
      2 (I must have spent a wonderful time in 2 3 \. That\'s awesome\.) (100 :out)
    1 (0 favorite vacation is in beach beach 0)
      2 (The view of 6 7 is fascinating\. The sunshine and the warm sand are great\.) (100 :out)
    1 (0 favorite vacation is in beach 0)
      2 (The view of 6 is fascinating\. The sunshine and the warm sand are great\.) (100 :out)
    1 (0 never 3 with family 0)
      2 (Actually\, traveling with my 5 is great\. Next time you should try that\.) (100 :out)
    1 (0 never 3 with friends 0)
      2 (Actually\, traveling with friends is great\. You have always enjoyed going to a trip with your friends \.) (100 :out)
    1 (0 favorite vacation 1 with family 0)
      2 (It must be a wonderful time to have a trip with my family\.) (100 :out)
    1 (0 favorite vacation 1 with frinds 0)
      2 (It must be a wonderful time to have a trip with my friends\.) (100 :out)
    1 (0 fly to the place 0)
      2 (It is a good way to go the place by 2 \.) (100 :out)
    1 (0 NIL Gist 0)
      2 (Sounds great \!) (100 :out)
  ))
); end of eval-when
