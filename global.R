library(dplyr)
library(readr)
library(shiny)
library(leaflet)

modules =list.files('modules',full.names = TRUE)


for(module in modules){
    source(module)
}


tara_data = read_tsv('df_MASTERTABLE.txt')
