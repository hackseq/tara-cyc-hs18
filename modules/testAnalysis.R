test_analysis_ui = function(id){
    ns = NS(id)
    
    tagList(plotOutput(ns('simple'),height = '1000px',width = '1500px'))
}

# the server takes in the groups as an input
# it is a list of arbitrary size. the elements
# of the list are arbitrary subsets of the dataset
# if your analysis accepts less or more than the current
# length of the groups list, either throw a warning or 
# take n experiments. where n is whatever you need.
test_analysis_server = function(input,output,session,groups){
    
    output$simple = renderPlot({
        grp = groups() # just needed to keep the original form before preprocessing
        gr = grp
        
        if(length(gr)>=2){
            gr = gr[1:2] # this is a two group comparison. take the first 2 and ignore the rest
            
            gr %<>% lapply(function(x){
                reshape2::dcast(x,PWY_NAME~SAMPLE,value.var= 'RPKM') %>%
                    tibble::column_to_rownames('PWY_NAME') %>%  apply(2,function(y){
                        y[is.na(y)] = 0
                        y
                    })
            })
            
            # the existing of 0s are not universal so some common ground is found.
            # correct thing to do would be to fill the missing parts with zeroes
            # but here I am taking an intersection
            commonPaths = intersect(rownames(gr[[1]]),rownames(gr[[2]]))
            
            gr %<>% lapply(function(x){
                x[commonPaths,]
            })
            
            # here I do a simple wilcox test to get the most DE pathways.
            testRes = commonPaths %>% sapply(function(x){
                test = suppressWarnings(wilcox.test(gr[[1]][x,],gr[[2]][x,]))
                p = test$p.value
                return(p)
            }) %>% p.adjust(method = 'fdr')
            
            
            
            topPaths = testRes %>% sort %>% {.[1:min(100,length(.))]} %>% names
            
            toPlot = cbind(gr[[1]],gr[[2]])
            
            toPlot = toPlot[topPaths,]
            
            
            annotCol = data.frame( group = 
                                       c(rep(names(gr[1]),ncol(gr[[1]])),
                         rep(names(gr[2]),ncol(gr[[2]]))))
            
            colnames(toPlot) %<>% make.names(unique = TRUE)
            rownames(annotCol) = colnames(toPlot)
            
            
            pathwayHighLevel = do.call(rbind,grp[1:2]) %>% select(PWY_NAME,LEVEL1) %>% unique
            
            annotRow = data.frame(pathwayType = pathwayHighLevel$LEVEL1[match(rownames(toPlot),
                                                                              pathwayHighLevel$PWY_NAME)])
            
            rownames(annotRow) = rownames(toPlot)
            
            pheatmap::pheatmap(log(toPlot+1),cluster_cols = FALSE,
                               annotation_col = annotCol,
                               annotation_row = annotRow,
                               show_colnames = FALSE,
                               gaps_col = ncol(gr[[1]]))
            
        }
        

        
        
    
        
    })
    
}