(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(

  ;; NOTE: No need to duplicate these here from "favorite-vacation", since they're shared
  ;; among all rule files in the dialogue.

    ;; (countryside mountain lake river sea beach rural cabin)
    ;; (fly flying air airplan aircraft rail railway railroad train boat ship cruise bus car motor)
    ;; (park parks Yellowstone Grand Canyon Yosemite National State Adirondacks Adirondack Shenandoah Acadia 
    ;;   Olympic Zion Rockey Arches Great Smoky Teton Glacier)
    ;; (state Alabama Alaska Arizona Arkansas California Colorado Connecticut Delaware Florida Georgia Hawaii
    ;; Idaho Illinois Indiana Iowa Kansas Kentucky Louisiana Maine Maryland Massachusetts Michigan Minnesota
    ;; Mississippi Missouri Montana Nebraska Nevada New Hampshire New Jersey New Mexico New York North Dakota
    ;; Ohio Oklahoma Oregon Pennsylvania Philly Rhode South Carolina South Dakota Tennessee Texas Utah Vermont
    ;; Virginia Washington West Virginia Wisconsin Wyoming)
    ;; (city LA NYC SF DC SD Los Angeles San Francisco New York City Washinton DC San Diego Houston Chicago
    ;;   Dallas Phoenix Boston Seattle Nashivlle Portland Las Vegas Detroit Philadelphia Miami Atlanta Rochester
    ;;   Pittsburgh Montana)
    ;; (country USA United States Mexico Canada Germany Italy France Switzerland Austria Vienna Belgium Poland Netherland
    ;;  Amsterdam Denmark Czechia UK United Kingdom Bahamas)
    ;; (country-city Toronto Muncih Berlin Frankfurt Rome Milan Paris Strasburg Vienna Amsterdam)
    ;; (theme park Disneyland Universal studio Legoland Seaworld Hollywood)
    ;; (Beach Myrtle island cancun Maui Lanai Greek South Maya Bay Waikiki Copacabana Natadola 
    ;;   Tenerife Langkawi Sidari Whitehaven Lanikai Santorini Bora Bali Maldives Fiji Crete Gayman Anguilla)
    ;; (family grandchildren grandchild children child daughter daughters son sons spouse wife husband siblings brother brothers sister sisters
    ;;   parents mother father grandparents grandmother grandfather cousin cousins uncle aunt)
    ;; (friend friends)
  ))
   
;;  If you won a free trip with no restrictions, including price, where would you go and what would you do?
;;	gist: If you won a free trip where would you go?
;;	(0 if I win 1 free trip 0)  (0 I do not want 3 free trip 0)
;;	free-trip
;;	(0 won 1 free trip where 2 you go 0)

	

(READRULES '*specific-answer-from-free-trip-input*
  '(
    1 (0 city city city 0) ;; e.g. New York City
      2 ((If I win a free trip I would go 2 3 4 \.)  (free-trip)) (0 :gist)
    1 (0 city city 0) 
      2 ((If I win a free trip I would go 2 3 \.)  (free-trip)) (0 :gist)
    1 (0 city 0) 
      2 ((If I win a free trip I would go 2 \.)  (free-trip)) (0 :gist)
    1 (0 state state 0) 
      2 ((If I win a free trip I would go 2 3 \.)  (free-trip)) (0 :gist)
    1 (0 state 0) 
      2 ((If I win a free trip I would go 2 \.)  (free-trip)) (0 :gist) 
    1 (0 country country 0)  ;; e.g. United States
      2 ((If I win a free trip I would go 2 3 \.)  (free-trip)) (0 :gist)
    1 (0 country-city 0)
      2 ((If I win a free trip I would go 2 \.)  (free-trip)) (0 :gist)
    1 (0 country 0)
      2 ((If I win a free trip I would go 2 \.)  (free-trip)) (0 :gist)
    1 (0 theme theme theme 0) ;;Disyneyland theme park
      2 ((If I win a free trip I would go 2 3 4 \.)  (free-trip)) (0 :gist)
    1 (0 theme theme 0) ;;Disyneyland park
      2 ((If I win a free trip I would go 2 3 \.)  (free-trip)) (0 :gist)
    1 (0 theme 0) ;;Disyneyland
      2 ((If I win a free trip I would go 2 \.)  (free-trip)) (0 :gist)
    1 (0 beach beach 0) ;;South beach
      2 ((If I win a free trip I would go 2 3 \.)  (free-trip)) (0 :gist)
    1 (0 beach 0) ;;Fiji
      2 ((If I win a free trip I would go 2 3 \.)  (free-trip)) (0 :gist)
    1 (0 family 0) 
      2 ((If I win a free trip I would go with 2 \.)  (free-trip)) (0 :gist)
    1 (0 friend 0) 
      2 ((If I win a free trip I would go with 2 \.)  (free-trip)) (0 :gist)  
    1 (0 fly 0) ;;Great Smoky
      2 ((If I win a free trip I would come to the place by fly \.)  (free-trip)) (0 :gist) 

    
    1 (0 NEG 3 vacation 0)
      2((I do not want to have a free trip \.) (free-trip)) (0 :gist)
    1 (0 NEG 3 like 0)
      2((I do not want to have a free trip \.) (free-trip)) (0 :gist) 

    
    ;; (Not sure if this one is really necessary though, it doesn't
    ;; make much sense in context.)
    1 (1 NEG 3 family 0) 
      2 ((I do not want to have a free trip with 4 \.)  (free-trip)) (0 :gist)
    1 (1 NEG 3 friend 0) 
      2 ((I do not want to have a free trip with 4 \.)  (free-trip)) (0 :gist)
    1 (0)
       2 ((NIL Gist \: nothing found for what if I win a free trip \.) (free-trip)) (0 :gist)
))
       
       
 (READRULES '*thematic-answer-from-free-trip-input*
  '(

  ))

 (READRULES '*unbidden-answer-from-free-trip-input*
  '(
  ))
		
 (READRULES '*question-from-free-trip-input*
  '(
    ;;new question
    1 (0 how 2 you 1 have 1 vacation 0)
      2 (How can you take a vacation ?) (0 :gist)
    1 (0 how 2 you 1 take 1 vacation 0)
      2 (How can you take a vacation ?) (0 :gist)
    1 (0 what 2 you 0)
      2 (If you won a free trip where would you go ？) (0 :gist)
    1 (0 how 2 you 0)
      2 (If you won a free trip where would you go ?) (0 :gist)
  ))

(READRULES '*reaction-to-free-trip-input*

  ;; NOTE: These reactions should not just be duplicated from "favorite-vacations", since it's
  ;; entirely possible that they answer the same place for this question.

  '(1 (0 NEG want to have a free trip 0)
      2 (Having a trip is a good way to relax yourself \. I should try it\.) (100 :out)
    1 (0 city city city 0)
      2 (You have been there several time\, 6 7 8 is a good place to have a trip\.) (100 :out)
    1 (0 city city 0)
      2 (0 Los Angeles 0)
        3 (The weather and the food of 2 3 is great\. Good place to have the trip\.) (100 :out)
      2 (0 San Francisco 0)
        3 (You used been to 2 3 before for a week\. You can still remember the beautiful view that city\. Nice choice\!) (100 :out)
      2 (0 Las Vegas 0)
        3 (2 3 is a great place for gambling\, shopping and nightlife\, the perfect place to relax and have fun\.) (100 :out)
      2 (0 city city 0)
        3 (You haven\'t been 2 3 before\, but the place sounds great to have a trip\. ) (100 :out)
    1 (0 city 0)
      2 (You haven\'t been there before\. But I believe it must be a nice place\.) (100 :out)
    1 (0 state state 0)
      2 (I used to have a wonderful time in 6 7 \. It is an interesting place to travle\.) (100 :out)
    1 (0 state 0)
      2 (0 California 0) 
        3 (The sunshine of California is great and there is much warmer than Rochester\. ) (100 :out)
      2 (0 Philadelphia 0)
        3 (You have taken a trip to 2 \. The food there was great\.) (100 :out)
      2 (0 state 0)
        3 (2 is a great place to travel\. The time that you spent there is unforgettable\.) (100 :out)
    1 (0 country country 0)
      2 (6 7 is a good country to have a trip\. I will have a wonderful trip\.) (100 :out)
    1 (0 country-city 0)
      2 (You have never been to 6 before\. But my trip plan sounds very attractive\.) (100 :out)
    1 (0 country 0)
      2 (0 Germany 0)
          3 (The beer of 2 is very famous\. That\'s a great place to travel\.) (100 :out)
       2 (0 France 0)
          3 (The cuisines of France is great and it\'s a romantic place\. ) (100 :out)
       2 (0 Italy 0)
          3 (Love their great artworks\. Hope I can have the chance to travel Italy\.) (100 :out)
       2 (0 country 0)
          3 (You have never been to 2 \. But my trip plan sounds very attractive\.) (100 :out)
    1 (0 theme theme theme 0)
      2 (0 Disyneyland theme park 0)
        3 (2 3 4 is a dream place for you \. You love Mickey Mouse and Snow White\.) (100 :out)
      2 (0 theme theme theme 0)
        3 (I must have spent a wonderful time in 2 3 4 \. That\'s sweet\.) (100 :out)
    1 (0 theme theme 0)
      2 (0 Universal studio 0)
        3 (2 3 is a fancy place\. You have been there before and had lots of fun there\.) (100 :out)
      2 (0 theme theme 0)
        3 (My plan sounds fancy\, I will spent a wonderful time in 2 3 \. That\'s sweet\.) (100 :out)
    1 (0 theme 0)
      2 (Sounds I will have a wonderful time in 2 3 \. That\'s sweet\.) (100 :out)
    1 (0 beach beach 0)
      2 (The view of 6 7 is fascinating\. The sunshine and the warm sand are great\.) (100 :out)
    1 (0 in beach 0)
      2 (The view of 6 is fascinating\. The sunshine and the warm sand are great\.) (100 :out)
    1 (0 favorite vacation 1 with family 0)
      2 (It must be a wonderful time to have a trip with your family\.) (100 :out)
    1 (0 favorite vacation 1 with friend 0)
      2 (I think traveling with friends is impressive\.) (100 :out)
    1 (0 fly to the place 0)
      2 (It is a good way to go the place by 2 \.) (100 :out)
    1 (0 NIL Gist 0)
      2 (That is a good idea\!) (100 :out) 
  ))
); end of eval-when
