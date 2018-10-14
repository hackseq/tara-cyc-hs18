dependencies = readLines('depends.txt')

for(depend in dependencies){
    library(depend,character.only = TRUE)
}


tara_data = read_csv('data/df_MASTERTABLE_plus_metadata.csv')


tara_data %<>% mutate(virus = !grepl('^c',SAMPLE))

write_rds(tara_data,'data/tara_data.rds')


globalMeans = tara_data %>% group_by(PWY_NAME) %>% summarise(mean = mean(RPKM))
write_rds(globalMeans,'data/global_means.rds')
