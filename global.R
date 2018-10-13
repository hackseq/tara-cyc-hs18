dependencies = readLines('depends.txt')

for(depend in dependencies){
    library(depend,character.only = TRUE)
}


modules =list.files('modules',full.names = TRUE)


for(module in modules){
    source(module)
}



# rds files are created at preprocessing.R
tara_data = read_rds('data/tara_data.rds')
# global_mean is pathway_means accross all samples
# meant as a preliminiary comparison baseline
# doesn't make too much sense as there are bacteria and viruses in this thing
global_means = read_rds('data/global_means.rds')