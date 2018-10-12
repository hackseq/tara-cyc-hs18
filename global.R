dependencies = readLines('depends.txt')

for(depend in dependencies){
    library(depend,character.only = TRUE)
}


modules =list.files('modules',full.names = TRUE)


for(module in modules){
    source(module)
}


tara_data = read_tsv('df_MASTERTABLE.txt')
