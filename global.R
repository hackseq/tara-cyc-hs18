library(dplyr)
library(readr)
library(shiny)


source('modules/map.R')
source('modules/query.R')

tara_data = read_tsv('df_MASTERTABLE.txt')
