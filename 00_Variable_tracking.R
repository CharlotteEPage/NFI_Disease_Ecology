# 00_Variable_tracking

# This script is keeping track of variable creation. 
# Individual rda/csv files will be made for each variable (or group of variables if possible). 
# This script will load these files and create datasets to be used in transect-level and colony-level analysis

# Load libraries
library(tidyverse)

# Disease lesion analysis 
# ------------------
# Response variables 
# ------------------




# Disease dynamics analysis
# ------------------
# Response variables 
# ------------------

# A) Disease prevalence (% of surveyed community)
# B) Disease severity (area covered by lesions on colony, %)
# C) Disease occurence (prescence/abscence of disease signs)
# D) Partial mortality (% colony)

# -----------------------------------
# COLONY level variables
# -----------------------------------
# 1) Host size (Small, Medium, Large)
# 2) Growth form (Encrusting, Plating)
# 3) Colony colour morph (Purple, Brown)
# 4) Colony bleaching status (Brown, Pale)
# 5) Other colony mortality (%) 
# 6) + 14 other benthic cover categories 

# Raw disease data 
disecol <- read.csv(file= "Monti_disease_survey_comp.csv", header = TRUE)
# Cover data (not raw, has been grouped and transposed, see script "00_Benthic_community_clean" for raw data)
# Benthic data 
benthic <- read.csv(file= "Benthic_categories.csv", header = TRUE)

# Clean disease data 
colonyanalysis <- disecol %>% select(TP,Transect,Coral.ID,Growth_form,Colour_morph,
                                     Size,Healthy,Colour,Number,Area,Partial_mortality) 

colonyanalysis$TP <- relevel(colonyanalysis$TP, "December")

# Make other mortality variable
colony.analysis <- colonyanalysis %>% replace(is.na(.), 0) %>%
  mutate(Other_mortality = Partial_mortality - Area) 

# Make a variable that gives each transect a unique code for random effects structure 
colony.analysis$transect_ID <- paste(colony.analysis$TP, "_", colony.analysis$Transect)

# Join data frames together 

str(colony.analysis) 
str(benthic)

colony_level <- merge(colony.analysis,benthic, sort = FALSE)

# Write a final rda and csv file.
save(colony_level, file = "colony_level_analysis.rda")
write.csv(colony_level,file = "colony_level_analysis.csv")


# TRANSECT LEVEL TRANSECT
# -----------------------------------
# Response variables (transect level)
# -----------------------------------

# A) Disease occurance (Prevalence per transect)
# B) Disease severity (Mean area covered by lesions on colony per transect)

# ---------------------------------------------
# Benthic community (transect level)
# ---------------------------------------------

# 1) Site (Emily Bay, Slaughter Bay)
# 2) Time point (December, April)
# 3) Total hard coral cover 
# 4) Total Montipora cover 

# Summarise data to transect-level

# Select variables of interest 

# Save as a csv.
# Save as a rda.



