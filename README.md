# WineFoodie

I love wine. What I don’t love is choosing which one to buy. I am not a wine connoisseur nor do I care to spend a lot of time researching how to pair wines with various foods. I am interested in a quick “good enough” immediate answer that I can get on the fly. 

#Problem
For a novice wine enthusiast the number of wine choices can be overwhelming, trying to select an appropriate wine for a specific food is even more challenging. Not being able to navigate the many wine varietals can deter people from even trying to pair food with wine.

#The solution
Eliminate much of the complexity by introducing a simplified guide to food and wine pairing that limits the number of choices. The user is given wine choices based a food category. The number of wines returned for the particular food category is limited to a handful of wines that are easy to choose from. 

# User Stories (in order of importance)

####Wines for Food Category
Returns wine varietals (i.e. cab sav, merlot, shiraz, etc…) with region matching a particular food category selected by the user. 

This is done using Snooth API. In this API each wine has three recommended recipes. The app fetches all recipes that match the food category and then retrieves all wines matching the food category. From the wine list the app retrieves all unique wine pairings for a food group based on recipes that match. 

####Group Wines
Wine can be arranged by color (i.e. red, white, rose, etc..)

####LCBO Lookup
Lookup wines matching a category in an LCBO catalogue and list all matching wines with price.

####Show wine detail
Detailed information from LCBO API.

####Find wine near you
Using LCBO API locate the wine in stores near you and show inventory.

![alt tag](https://github.com/mcivilis/WineFoodie/blob/master/Screenshots/screen_shot1.png)
