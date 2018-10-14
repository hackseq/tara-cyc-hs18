library(reshape2)

tara_data = read_tsv('data/df_MASTERTABLE.txt')

tara_subset = tara_data[1:2843,]

calculate_distance_matrix <- function (df) {
    samples <- df %>% select(SAMPLE, PWY_NAME, LEVEL1, LEVEL2, RPKM)
    samples %<>% dcast(SAMPLE ~ PWY_NAME)
    samples <- replace(samples, is.na(samples), 0)
    dist(samples, diag = TRUE)
}

distance_matrix <- calculate_distance_matrix(tara_subset)
plot(hclust(distance_matrix))

