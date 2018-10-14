clustering_ui = function(id){
    ns = NS(id)
    tagList(plotOutput(ns('clustering'),height = '1000px',width = '1500px'))
}

clustering_server = function(input,output,session,groups){
    output$clustering = renderPlot({
        if (length(groups()) >= 1) {
            subset = groups()[[1]]
            
            subset %<>% mutate(SAMPLE = SAMPLE %>% abbreviate(minlength = 9))
            sampleDictionary = subset %>%select(SAMPLE,BIOME) %>% unique
            
            
            barPalette = c('#7DD4A6','#C15BC5','#D65242','#415455',
                           '#D2A75C','#8FD25B','#D15B86','#A5B5BE','#727EC6',
                           '#567441','#754334','#5E3A60','#77B0D0',"#CCEBC5",
                           "#D9D9D9","#FCCDE5")
            
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
            
            dendro = subset %>%
                calculate_distance_matrix() %>%
                create_dendrogram()
            
            colors= sampleDictionary$BIOME[match(labels(dendro),sampleDictionary$SAMPLE)] %>% 
                toColor(.,palette = barPalette[seq_along(unique(.))])
            
            par(mar=c(10,1,1,1))
            dendro %>%
                plot(axes=FALSE)
            colored_bars(colors$cols,dend = dendro,rowLabels = '')
            legend('topright',cex = 2,legend = names(colors$palette), fill = colors$palette)
            
        }
    })
}



toColor = function (vector, palette = NULL, NAcolor = "white") 
{
    if (class(vector) == "factor") {
        vector = as.character(vector)
    }
    if (!is.null(palette) & !is.null(names(palette))) {
        assertthat::assert_that(all(vector %in% names(palette)))
    }
    if (is.null(names(palette)) & !is.null(palette)) {
        names(palette) = unique(vector)
    }
    out = replaceElement(vector, dictionary = palette, NAreplace = NAcolor)
    names(out) = c("cols", "palette")
    return(out)
}

replaceElement = function (vector, dictionary = NULL, labels = NULL, NAreplace = NA) 
{
    if (class(vector) == "factor") {
        vector = as.character(vector)
    }
    uniq = unique(vector) %>% trimNAs
    if (is.null(dictionary[1])) {
        dictionary = rainbow(length(uniq))
    }
    if (is.null(labels) & !is.null(names(dictionary))) {
        labels = names(dictionary)
    }
    else if (is.null(labels) & is.null(names(dictionary))) {
        labels = uniq
    }
    cols = vector(length = length(vector))
    for (i in 1:length(dictionary)) {
        vector[vector == labels[i]] = dictionary[i]
    }
    vector[is.na(vector)] = NAreplace
    if (length(dictionary) > 0) {
        names(dictionary) = labels
    }
    out = list(newVector = vector, dictionary = dictionary)
    return(out)
}

trimNAs = function (aVector) 
{
    return(aVector[!is.na(aVector)])
}
