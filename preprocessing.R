dependencies = readLines('depends.txt')

for(depend in dependencies){
    library(depend,character.only = TRUE)
}


tara_data = read_tsv('df_MASTERTABLE.txt')


tara_data %<>% mutate(virus = !grepl('^c',SAMPLE))

write_rds(tara_data,'tara_data.rds')
