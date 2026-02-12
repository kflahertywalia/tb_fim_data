###Subset all FIM data from GEI project data to just Tampa Bay

# Load required libraries
library(dplyr)
library(tidyr)
library(readr)
library(lubridate)
library(stringr)
library(here)
library(usethis)
library(tbeptools)

load(here("Output", "tb_all_c.RData"))

#Export species list
spp <- com %>%
  group_by(Scientificname,Commonname,species)%>%
  summarise(total_count = sum(number, na.rm = TRUE),
            n_observations=n())
write_csv(spp, here("Output", "tb_fim_species.csv"))
#add any new non-natives, invasives to fim_nonnative_list.csv

invlist <- read_csv(here("Output","fim_nonnative_list.csv"))%>%
  select(Scientificname,Taxa,Taxa_group,Taxa_Type,nonnative,invasive)
         
#filter by non-native, invasive species records
inv <- full_join(com,invlist, by ="Scientificname")%>%
  filter(nonnative=="Y")


