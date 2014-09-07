# This is a basic conceptual cube construction for an outline of library resource utilization by student population.
# In this example there is no actual data from the university and the figures are sampled values.

 # The structure of this construction was based off the pragmatic blog programming techniques blog by Ricky Ho: 
 #                                                      http://horicky.blogspot.com/2013/07/olap-operation-in-r.html
 
student_table <- data.frame(key=c("freshman", "sophmore", "junior", "senior", "above"),
                            # switch name with somesort of STARID index
                            name = c("aalexander", "ajohnson", "aoriley", "amarquez", "ashoefnner"),
                            # indicates year of study, refactor this
                            year=c("0", "1", "2", "3", "4"))
                            # add information about the students GPA/performance 

month_table <- data.frame(key=1:12,
                          desc=c("Jan","Feb","Mar","Apr","May","Jun", "Jul", 
                                 "Aug", "Sep", "Oct", "Nov", "Dec"),
                          semester=c("spring", "spring", "spring", "spring", 
                                     "spring", "summer", "summer", "fall",
                                     "fall", "fall", "fall", "fall"))

# table of library resources

# Change this name to something more intuitive
prod_table <- 
        data.frame(key=c("Room", "Book", "Laptop"),
                   # change this to a more refined index
                   price=c(100, 200, 300))

# Function to generate 
gen_sales <- function(no_of_recs) {
        
        # Generate transaction data randomly
        lvl <- sample(student_table$key, no_of_recs, 
                      replace=T, prob=c(2,2,1,1,1))
        time_month <- sample(month_table$key, no_of_recs, replace=T)
        time_year <- sample(c(2012, 2013), no_of_recs, replace=T)
        prod <- sample(prod_table$key, no_of_recs, replace=T, prob=c(1, 3, 2))
        unit <- sample(c(1,2), no_of_recs, replace=T, prob=c(10, 3))
        amount_of_time <- unit*prod_table[prod,]$price
        
        sales <- data.frame(month=time_month,
                            year=time_year,
                            lvl=lvl,
                            prod=prod,
                            unit=unit,
                            amount_of_time=amount_of_time)
        
        # Sort the records by time order
        sales <- sales[order(sales$year, sales$month),]
        row.names(sales) <- NULL
        return(sales)
}

# Create resource fact table
sales_fact <- gen_sales(500)

head(sales_fact)

  month year      lvl   prod unit amount_of_time
1     1 2012 freshman Laptop    2            400
2     1 2012    above   Book    2            200
3     1 2012    above Laptop    1            200
4     1 2012 sophmore   Book    1            100
5     1 2012   senior   Book    1            100
6     1 2012   senior   Book    1            100
