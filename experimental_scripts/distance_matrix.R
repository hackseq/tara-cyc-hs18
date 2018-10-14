library(reshape2)
library(dendextend)
library(ggplot2)

tara_data = read_tsv('data/df_MASTERTABLE.txt')

tara_subset = tara_data[1:2843,]

calculate_distance_matrix <- function (df) {
    samples <- df %>% select(SAMPLE, PWY_NAME, LEVEL1, LEVEL2, RPKM)
    samples %<>% dcast(SAMPLE ~ PWY_NAME)
    samples <- replace(samples, is.na(samples), 0)
    rownames(samples) <- samples$SAMPLE
    dist(samples, diag = TRUE)
}

create_dendrogram <- function(distance_matrix) {
    as.dendrogram(hclust(distance_matrix))
}

render_dendrogram <- function(dendrogram) {
    dendrogram %<>% ggplot()
}

tara_subset %>% 
    calculate_distance_matrix() %>%
    create_dendrogram() %>%
    render_dendrogram()
