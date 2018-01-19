library(tidyverse)
library(viridis)

serengeti = read_csv("http://datadryad.org/bitstream/handle/10255/dryad.86348/consensus_data.csv")
serengeti.Site = split(serengeti, serengeti$SiteID)
serengeti.behaviours = serengeti[10:11] # a data frame/tibble is a list of columns/variables!
plot_by_species = split(serengeti[10:11], serengeti$Species) #split by species
to_plot = plot_by_species[1:10] #so I don't forget to subset



### Q1: apply the summary function to each of the different species

par(mfrow=c(2,5))
lapply(plot_by_species[1:10], plot)

### Q2: apply the plot function to the first 10 species
# and have the names of the species on the given plots

##############
#
# Cam Solution 1
#
###############

#make a function that plots the data and adds a name
behaviour_name_plot = function(data){
  plot(data[[1]], main=names(data) )
} 


#test the function
#passes my unit test and does what I expect
behaviour_name_plot(to_plot[2])

#but when I lapply it... the scope is the level below the names of the list
# which is not expected. It puts the column names as the title!
# so my solution to get the names on the plot is no good with lapply!
par(mfrow=c(2,5))
lapply(to_plot, behaviour_name_plot)


#but if I loop over them it works as I would expect
#so lapply and loops are not as equivalent as I would like
par(mfrow=c(2,5))

for(i in 1:10){
  behaviour_name_plot(to_plot[i])
}


##############
#
# Cam Solution 2
#
###############

# by making the function accept 2 arguments, I can pass
# the names of the plots and the plot data into the function.
# I then use mapply to run the function with the two sets of variables passed in
?mapply


apply_behaviour_name_plot = function(data, name_dat){
  plot(data[[1]], main=name_dat, xlab=names(data)[1], ylab=names(data[2]) )
} 

par(mfrow=c(2,5))

mapply(apply_behaviour_name_plot, to_plot, names(to_plot))


#things I don't like:

# mapply is format: mapply(function, data)
# lapply is format: lapply(data, function)
#why are these opposite?


#mapply is also not as intuitive as a loop, if I wasn't comfortable with
#the vernacular of R I'm not sure I would have been able to google the right 
#questions!

# I can't apply my function 'as is'... I needed to rewrite the function to
# accomidate the names() usage... so although the mapply is efficient, it 
# requires more 'upstream work' then a good old for loop.




#Jonathan Kennel

plot_by_species = split(serengeti, serengeti$Species) #split by species

par(mfrow=c(2,5))

lapply(plot_by_species[1:10], 
		function(x) plot(Standing~Resting, x, main = Species[1]))



#Nia solution

#read in data
serengeti = read_csv("http://datadryad.org/bitstream/handle/10255/dryad.86348/consensus_data.csv")
 
#Split dataset on species and extract columns 10 and 11 (behaviours)
serengeti.Species2 = split(serengeti[10:11], serengeti$Species)
 
#Set up multi-paneled plot
par(mfrow=c(2,5))
 
#Plots 1-10 with name
lapply(names(serengeti.Species2[1:10]), function(x) plot(serengeti.Species2[[x]], main = x))




