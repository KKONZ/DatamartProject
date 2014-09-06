revenue_cube <- 
        tapply(sales_fact$amount_of_time,
               sales_fact[,c("prod", "month", "year", "lvl")],
               FUN=function(x){return(sum(x))})

dimnames(revenue_cube)


#slice
revenue_cube[, "1", "2012",]

revenue_cube["Book", "1", "2012",]

# Dice
revenue_cube[c("Room","Book"),
             c("1", "2", "3"),
             ,
             c("freshman", "junior")]


# Rollup
apply(revenue_cube, c("year", "prod"),
      FUN=function(x) {return(sum(x, na.rm=TRUE))})


# Drilldown
apply(revenue_cube, c("year", "month", "prod"), 
      FUN=function(x) {return(sum(x, na.rm=TRUE))})


# Pivot
apply(revenue_cube, c("year", "month"), 
      FUN=function(x) {return(sum(x, na.rm=TRUE))})

apply(revenue_cube, c("prod", "lvl"),
      FUN=function(x) {return(sum(x, na.rm=TRUE))})
