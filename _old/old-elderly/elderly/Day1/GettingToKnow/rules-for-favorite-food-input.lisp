(eval-when (load eval)
  (MAPC 'ATTACHFEAT
  '(
  (food-descs sweet sour savory salty bitter dry crunchy spicy)
  (food-categories vegan vegetarian seafood vegetables fruit dessert grain nuts dairy meat)
  (food-ethnicity Asian Chinese Mexican Japanese Italian Korean Peruvian Thai Ethiopian Indian Mediterranean Turkish Greek Cambodian German Polish Spanish)
  (more-common-food-ethnicity Asian Chinese Mexican Mediterranean Greek Turkish)
  (food-seafood fish cod eel herring salmon sardine sardines swordfish tilapia trout tuna
    caviar crab lobster shrimp oyster clam clams squid octopus calamari sushi)
  (food-vegetables salad celery broccoli garlic cauliflower cucumber spinach leek pumpkin
    beets kale zucchini cabbage carrot carrots lettuce asparagus potato tomato eggplant
    pepper quinoa avocado soy pickle pickles corn pea peas mushroom mushrooms onion onions)
  (food-fruit apple apples banana bananas orange oranges strawberry strawberries grape grapes pear pears cherry cherries peach peaches lemon lemons mango mangos blueberry blueberries
    berry berries watermelon watermelons melon melons grapefruit grapefruits pomegranate pomegranates blackberry blackberries apricot apricots cranberry cranberries coconut coconuts 
    tangerine tangerines cantaloupe cantaloupes honeydew honeydews olive olives plantains)
  (food-dessert cookie cookies brownies candy pie cheesecake chocolate custard pastry
    pastries ice cream doughnut donut doughnuts donuts shortcake sundae cake)
  (food-grain pasta spaghetti rice noodles oats oatmeal bread toast cereal bran pancake
    pancakes waffle waffles)
  (food-nuts almond almonds walnut walnuts peanut peanuts hazelnut hazelnuts pistachio pistachios
    cashew cashews pecan pecans chestnut chestnuts)
  (food-dairy butter cheese cheddar mozzarella parmesan milk yogurt pudding egg eggs omelette)
  (food-meat beef pork chicken lamb duck meatball meatballs sausage steak ribs pepperoni ham
    salami bacon turkey)
  (food-misc french fries hot-dog hot-dogs hot dog burger hamburger burgers hamburgers taco tacos stuffing pizza
    chili sandwich sandwiches sub subs bagel bagels curry soup stew bean beans)
  ))
   
;;  (what is your favorite food ?)
;;	(favorite-food)
;; 	from-favorite-food-input
;;  (0 food I like 0) (0 do not have a favorite food 0)
;;  	gist-question: (1 what 2 favorite 2 food 1) 


 (READRULES '*specific-answer-from-favorite-food-input*
  '(
  1 (0 food-seafood 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)
  1 (0 food-vegetables 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)
  1 (0 food-fruit food-dessert 0) ;; e.g. "apple pie", "strawberry shortcake"
     2 ((The food I like is 2 3 \.)  (favorite-food)) (0 :gist)
  1 (0 food-fruit 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)
  1 (0 food-dessert food-dessert 0) ;; e.g. "ice cream"
     2 ((The food I like is 2 3 \.)  (favorite-food)) (0 :gist)
  1 (0 food-dessert 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)
  1 (0 food-grain 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)
  1 (0 food-nuts 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)
  1 (0 food-dairy 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)
  1 (0 food-meat food-misc 0) ;; e.g. "turkey sandwich", "pork tacos"
     2 ((The food I like is 2 3 \.)  (favorite-food)) (0 :gist)
  1 (0 food-meat 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)
  1 (0 food-misc 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)
  1 (0 food-ethnicity 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)
  1 (0 food-categories 0)
     2 ((The food I like is 2 \.)  (favorite-food)) (0 :gist)
  1 (0 I 1 NEG 2 have 3 favorite 0)
      2 (I do not have a favorite food \.)
  1 (0)
     2 ((NIL Gist \: nothing found for the food I like \.)  (favorite-food)) (0 :gist)
  ))
       
       
 (READRULES '*thematic-answer-from-favorite-food-input*
    '())

 (READRULES '*unbidden-answer-from-favorite-food-input*
    '())
		
 (READRULES '*question-from-favorite-food-input*
    '(
    1 (0 what 2 you 0)
       2 (What is your favorite food ?) (0 :gist)
    1 (0 how 2 you 0)
       2 (What is your favorite food ?) (0 :gist)
	  1 (0 your favorite 0)
       2 (What is your favorite food ?) (0 :gist)
    1 (0 do you 2 eat 0)
       2 (What is your favorite food ?) (0 :gist)
    1 (0 can you 2 eat 0)
       2 (What is your favorite food ?) (0 :gist)
    ))

(READRULES '*reaction-to-favorite-food-input*
  '( 
  1 (0 food-seafood 0)
     2 (You really like 2 \! Seafood is one of your favorite types of food\.) (100 :out)
  1 (0 food-vegetables 0)
     2 (You like 2 \! It\'s nice since it is both healthy and tastes good\.) (100 :out)
  1 (0 food-fruit food-dessert 0) ;; e.g. "apple pie", "strawberry shortcake"
     2 (You think 2 3 is pretty tasty\. You definitely have a bit of a sweet tooth\.) (100 :out)
  1 (0 food-fruit 0)
     2 (You like 2 \! It\'s nice when food is healthy and tastes good\.) (100 :out)
  1 (0 food-dessert food-dessert 0) ;; e.g. "ice cream"
     2 (You think 2 3 is pretty tasty\. You definitely have a bit of a sweet tooth\.) (100 :out)
  1 (0 food-dessert 0)
     2 (You really like 2 \! You definitely have a bit of a sweet tooth\.) (100 :out)
  1 (0 food-grain 0)
     2 (You like 2 \! However\, it is a little bit heavy for you \. It\'s very filling\.) (100 :out)
  1 (0 food-nuts 0)
     2 (You love 2 \! Crunchy foods are the best\.) (100 :out)
  1 (0 food-dairy 0)
     2 (2 is very tasty\. However\, you cannot have much of it\. It sometime makes your stomach hurt\.) (100 :out)
  1 (0 food-meat food-misc 0) ;; e.g. "turkey sandwich", "pork tacos"
     2 (You like 2 3 as well \. However\, you cannot have much of it\. It\'s very filling\.) (100 :out)
  1 (0 food-meat 0)
     2 (You like 2 \! However\, you cannot have much of it\. It\'s very filling\.) (100 :out)
  1 (0 food-misc 0)
     2 (Nice\! You like 2 as well\. It\'s very tasty\.) (100 :out)
  1 (0 food-ethnicity 0)
     2 (0 italian 0)
	   3 (Your daugher loves italian food \. So you used to make pizza and pasta a lot when you was younger \.) (100 :out)
	 2 (0 food-ethnicity 0)
	   3 (You love 2 food \! It\'s good that there are a lot of 2 restaurants in Rochester \.) (100 :out)
     2 (You haven\'t tried 2 food yet\. You will have to taste it some time\.) (100 :out)
  1 (0 food-categories 0)
     2 (0 vegan 0)
        3 (You also like to eat 2 food every now and then\.) (100 :out)
     2 (0 vegetarian 0)
        3 (You also like to eat 2 food\.) (100 :out)
     2 (You try to include 2 in your diet \. It is very beneficial for health \.) (100 :out)
  1 (0 food-descs 0)
     2 (You also like to eat 2 food\.) (100 :out)
  1 (0 not have a favorite food 0)
     2 (You love eating\! There\'s lots of amazing food out there to taste\!) (100 :out)
  1 (0 NIL Gist 0)
     2 (There\'s lots of amazing food out there to taste\!) (100 :out)
	))
); end of eval-when
