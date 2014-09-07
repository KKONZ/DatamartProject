



revenue_cube <- 
        tapply(sales_fact$amount_of_time,
               sales_fact[,c("prod", "month", "year", "lvl")],
               FUN=function(x){return(sum(x))})

dimnames(revenue_cube)




$prod
[1] "Book"   "Laptop" "Room"  

$month
 [1] "1"  "2"  "3"  "4"  "5"  "6"  "7"  "8"  "9"  "10" "11" "12"

$year
[1] "2012" "2013"

$lvl
[1] "above"    "freshman" "junior"   "senior"   "sophmore"





#slice
revenue_cube[, "1", "2012",]



        lvl
prod     above freshman junior senior sophmore
  Book     700       NA    100    200      900
  Laptop   200     1000     NA     NA      400
  Room      NA       NA     NA     NA      300
  
  
  
revenue_cube["Book", "1", "2012",]

   above freshman   junior   senior sophmore 
     700       NA      100      200      900
     
  
# Dice
revenue_cube[c("Room","Book"),
             c("1", "2", "3"),
             ,
             c("freshman", "junior")]



, , year = 2012, lvl = freshman

      month
prod    1    2   3
  Room NA 1200  NA
  Book NA  100 400

, , year = 2013, lvl = freshman

      month
prod     1    2   3
  Room  NA   NA  NA
  Book 100 1400 200

, , year = 2012, lvl = junior

      month
prod     1   2  3
  Room  NA  NA NA
  Book 100 200 NA

, , year = 2013, lvl = junior

      month
prod     1   2   3
  Room  NA  NA 300
  Book 100 300 300




# Rollup
apply(revenue_cube, c("year", "prod"),
      FUN=function(x) {return(sum(x, na.rm=TRUE))})



      prod
year    Book Laptop  Room
  2012 14700  21000 12600
  2013 18000  19200 14700
  
  
  

# Drilldown
apply(revenue_cube, c("year", "month", "prod"), 
      FUN=function(x) {return(sum(x, na.rm=TRUE))})


, , prod = Book

      month
year      1    2   3    4    5    6    7    8    9   10   11   12
  2012 1900  800 400 1200 1000  800 1100 1700 1000 1300 2300 1200
  2013 1600 2300 700 1700 1800 1000 1500 1900 1400 1300 1800 1000

, , prod = Laptop

      month
year      1    2    3    4    5    6    7    8    9   10   11   12
  2012 1600 1000 1200 1800 3000 3400 1200 2200 1200 2200  800 1400
  2013 1400 1800 3000  800 2000 1800 1400 1600 1000 1200 1200 2000

, , prod = Room

      month
year      1    2   3    4    5    6    7   8    9   10   11   12
  2012  300 1500 300 2400 1500 1500  300 300 1200 2400  600  300
  2013 1500  900 900  600 1500  600 1500 600 1800  600 1800 2400





# Pivot
apply(revenue_cube, c("year", "month"), 
      FUN=function(x) {return(sum(x, na.rm=TRUE))})
      
      
            month
year      1    2    3    4    5    6    7    8    9   10   11   12
  2012 3800 3300 1900 5400 5500 5700 2600 4200 3400 5900 3700 2900
  2013 4500 5000 4600 3100 5300 3400 4400 4100 4200 3100 4800 5400

apply(revenue_cube, c("prod", "lvl"),
      FUN=function(x) {return(sum(x, na.rm=TRUE))})


        lvl
prod     above freshman junior senior sophmore
  Book    4800     9500   5500   3400     9500
  Laptop  5600    11600   6400   4800    11800
  Room    3900     8100   5100   1500     8700
