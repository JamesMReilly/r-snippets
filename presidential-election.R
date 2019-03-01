# wrangle presidential election data
library(dplyr)
library(politicaldata)

pres <- politicaldata::pres_results

pres <- pres %>% 
  filter(year%in% 2008:2016)


pres$state_name = tolower(state.name[match(pres$state,state.abb)]) # we need the full name of the state to join with the map


# get map data
library(maps)
library(sf)
pres_map <- maps::map("state", plot = FALSE, fill = TRUE) # acquirig the data frame

pres_map <- sf::st_as_sf(pres_map) # changing the lat-long format to a simple feature object

names(pres_map) <- c("geometry","state_name")

pres_map <- pres_map %>% filter(state_name != 'district of columbia')

# combine with election data
pres_map <- pres_map %>% 
  left_join(pres,by = 'state_name') # joining the map with the political data

# plotting with ggplot2
library(ggplot2)
gg <- ggplot(pres_map,
             aes(fill=dem-rep>0),
             col='black') +
  geom_sf(aes(alpha=abs(dem-rep))) +
  coord_sf(crs = "+proj=aea +lat_1=25 +lat_2=50 +lon_0=-100",ndiscr = 0) + # change the projection from mercator (blegh)
  scale_fill_manual(values=c("TRUE"="blue","FALSE"="red")) +
  scale_alpha(range=c(0.1,1)) +
  facet_wrap(~year) +
  theme_void() +
  theme(legend.position='none')

ggsave(plot = gg,filename = 'figures/us_election_2008_2012_2016.png',width=12,height=3,units='in')