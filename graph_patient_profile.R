#patient profile data for AEs

#Library
library(tidyverse)
library(ggplot2)
library(lubridate)
library(plotly)
library(haven)
library(date)
library(patientProfilesVis)
library(pander)
library(clinUtils)

#Load data
dmae <- read_sas("https://github.com/philbowsher/Foundation-of-the-R-Workflow-workshop-2019-09-06/raw/master/Examples/data/dmae.sas7bdat", 
                 NULL)

#Data cleaning
dmae$aestdt<-ymd(dmae$AESTDTC, truncated=2)
dmae$aeendt<-ymd(dmae$AEENDTC, truncated=2)

dmae1<-subset(dmae, USUBJID=="STUDY_E-308301")

#Graph
library(plotly)
fig <- plot_ly(dmae1, color = I("gray80"))
fig <- fig %>% add_segments(x = ~aestdt, xend = ~aeendt, y = ~USUBJID, yend = ~USUBJID, showlegend = FALSE)
fig <- fig %>% add_markers(x = ~aestdt, y = ~USUBJID, name = "AE Start date", color = I("green"))
fig <- fig %>% add_markers(x = ~aeendt, y = ~USUBJID, name = "AE End date", color = I("red"))
fig <- fig %>% layout(
  title = "Patient profile",
  xaxis = list(
    type = 'date',
    tickformat = "%d %B (%a)<br>%Y"),
  margin = list(l = 65)
)

fig

