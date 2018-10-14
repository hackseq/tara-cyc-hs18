clustering_ui = function(id){
    ns = NS(id)
    tagList(plotOutput(ns('clustering'),height = '1000px',width = '1500px'))
}

clustering_server = function(input,output,session,groups){
    outptu$clustering = renderPlot({
        if (length(groups()) >= 1) {
            subset = groups()[[1]]
            
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
            
            subset %>%
                calculate_distance_matrix() %>%
                create_dendrogram() %>%
                render_dendrogram()
        }
    })
}