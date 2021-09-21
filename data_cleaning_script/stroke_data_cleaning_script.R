

# Cleaning Script for Stroke Datasets

## Loading in libraries

library(tidyverse)
library(janitor)
library(here)
library(sf)



## Stroke activity by local authority area.

stroke_activitybyca <- read_csv("raw_data/stroke_activitybyca.csv") %>%
  clean_names()

head(stroke_activitybyca)

stroke_activitybyca %>%
  distinct(ca)



### subsetting data


stroke_ca_2 <- stroke_activitybyca %>%
  select(financial_year, ca, admission_type  ,age_group, sex, diagnosis, number_of_discharges, crude_rate)



## Stroke activity by health board region.

stroke_activitybyhbr <- read_csv("raw_data/stroke_activitybyhbr.csv") %>%
  clean_names()

head(stroke_activitybyhbr)



stroke_activitybyhbr %>%
  distinct(hbr)


## subsetting data

stroke_hbr_2 <- stroke_activitybyhbr %>%
  select(financial_year, hbr, admission_type, age_group, sex, diagnosis, number_of_discharges, crude_rate)



## Subsetting stroke mortality by local authority area data.

stroke_mortalitybyca <- read_csv("raw_data/stroke_mortalitybyca.csv") %>%
  clean_names()

head(stroke_mortalitybyca)



stroke_mortalitybyca_2 <- stroke_mortalitybyca %>%
  select(year, ca, age_group, sex, diagnosis, number_of_deaths, crude_rate)




## Subsetting stroke mortality by health board region data.

stroke_mortalitybyhbr <- read_csv("raw_data/stroke_mortalitybyhbr.csv") %>%
  clean_names()

head(stroke_mortalitybyhbr)




stroke_mortalitybyhbr_2 <- stroke_mortalitybyhbr %>%
  select(year, hbr, age_group, sex, diagnosis, number_of_deaths, crude_rate)




## Reading in local authority data zone data.

la_data_zones <- read_csv("raw_data/data_zones.csv")


data_zones <- read_csv("raw_data/data_zones.csv")

la_zones_clean <- data_zones %>%
  select(LA_Code, LA_Name) %>%
  distinct()


## Reading in health board region data.

hbr_zones_all <- read_csv("raw_data/hbr_zones_all.csv")

hbr_zones_clean_2 <- hbr_zones_all %>%
  select(HB, HBName)


## Combining datasets with local authority and health board area names.


comb_stroke_activityca <- left_join(stroke_ca_2, la_zones_clean, by = c("ca" ="LA_Code"))


comb_stroke_activityhbr <- left_join(stroke_hbr_2, hbr_zones_clean_2, by = c("hbr" ="HB"))


comb_stroke_mortalityca <- left_join(stroke_mortalitybyca_2, la_zones_clean, by = c("ca" ="LA_Code"))


comb_stroke_mortalityhbr <- left_join(stroke_mortalitybyhbr_2, hbr_zones_clean_2, by = c("hbr" ="HB"))


## Writing datasets to csv files

write.csv(comb_stroke_activityca, "clean_data/comb_stroke_activity_ca.csv")

write.csv(comb_stroke_activityhbr, "clean_data/comb_stroke_activityhbr.csv")

write.csv(comb_stroke_mortalityca, "clean_data/comb_stroke_mortalityca.csv")

write.csv(comb_stroke_mortalityhbr, "clean_data/comb_stroke_mortalityhbr.csv")





