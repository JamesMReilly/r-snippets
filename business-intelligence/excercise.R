library(abind)

fakeNameGen <- function() {
  
  # step 2, vectors of names
  v1 = c("Jim", "Matthew", "Reilly")
  v2 = c("LeBron", "Tom", "Brady")
  
  # step 5 + 6, creating a vector using abind that combines v1,v2
  names = abind(v1,v2, rev.along=2)
  
  # step 7 name the columns/rows
  rownames(names) <- c("Jim", "Nick")
  colnames(names) <- c("First", "Middle", "Last")
  
  # step 8, extract the values
  firsts = names[,1]
  middles = names[,2]
  lasts = names[,3]
  
  # step 9 sample a random name
  fakeName = paste(sample(firsts, 1), sample(middles, 1), sample(lasts, 1))
  
  return(fakeName)
}

# step 10, use a function to do all the above work
fakeNameGen()


##################################

# step 0, create 3 trips
trip1 <- c(68, 2.9, 4.86)
trip2 <- c(130, 6.1, 3.93)
trip3 <- c(271, 12.3, 4.51)

trips = abind(trip1,trip2,trip3, rev.along=2)

rownames(trips) <- c("Chicago", "Aurora", "Springfield")
colnames(trips) <- c("Miles", "Gallons", "Price/Gallon")

# Price = Gallons * Price/Gallon
priceOfTrip = trips[,2] * trips[,3]

# Total Distance = Sum(miles)
totalDistance = sum(trips[,1])

# Average Distance = Total Distance / # Trips
averageDistance = totalDistance / length(trips[,1])

# Average cost per gallon = Mean(Price/Gallon)
averageCost = mean(trips[,3])

# Cost per mile = PriceOfTrip / Miles
costPerMile = priceOfTrip / trips[,1]

# Miles -> Kilometer (1 mile = 1.67 kilometers)
kilometers = 1.67 * trips[,1]

modes = factor(c("Highway", "City", "Mixed"))

trip1[4] <- as.character(modes)[2]
trip2[4] <- as.character(modes)[3]
trip3[4] <- as.character(modes)[1]

trip4 <- c(10, .3, 2.93, as.character(modes)[2])
trip5 <- c(4, .12, 3.04, as.character(modes)[2])
trip6 <- c(93, 3.2, 3.58, as.character(modes)[3])
trip7 <- c(201, 6.86, 3.61, as.character(modes)[1])

moreTrips = abind(trip1,trip2,trip3,trip4,trip5,trip6,trip7, rev.along = 2)

rownames(moreTrips) <- c("Chicago", "Aurora", "Springfield", "Waukesha", "Brookfield", "Ashland", "Green Bay")


fuelEconomy <- function(trips){
  mpg = as.numeric(trips[,1]) / as.numeric(trips[,2])
  return(rownames(trips[order(mpg),])[1])
}

fuelEconomy(moreTrips)

