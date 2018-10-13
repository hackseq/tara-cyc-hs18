
tara_data = read_tsv('data/df_MASTERTABLE.txt')

calculate_distance_matrix <- function (df) {
    samples <- df %>% select(SAMPLE, PWY_NAME, LEVEL1, LEVEL2, RPKM)
    samples
}
