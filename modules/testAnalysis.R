test_analysis_ui = function(id){
    ns = NS(id)
    
    tagList(plotOutput(ns('simple'),height = '1200px',width = '1200px'))
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
            withProgress({
                gr = gr[1:2] # this is a two group comparison. take the first 2 and ignore the rest
                
                gr %<>% lapply(function(x){
                    reshape2::dcast(x,PWY_NAME~SAMPLE,value.var= 'RPKM') %>%
                        tibble::column_to_rownames('PWY_NAME') %>%  apply(2,function(y){
                            y[is.na(y)] = 0
                            y
                        })
                })
                
                
                commonPaths = intersect(rownames(gr[[1]]),rownames(gr[[2]]))
                exclusiveInG1 = rownames(gr[[1]])[!rownames(gr[[1]]) %in% rownames(gr[[2]])]
                exclusiveInG2 = rownames(gr[[2]])[!rownames(gr[[2]]) %in% rownames(gr[[1]])]
                
                dummyG1 = matrix(0,ncol = ncol(gr[[1]]),nrow = length(exclusiveInG2)) %>% as.data.frame()
                rownames(dummyG1) = exclusiveInG2
                colnames(dummyG1) = colnames(gr[[1]])
                
                dummyG2 = matrix(0,ncol = ncol(gr[[2]]),nrow = length(exclusiveInG1)) %>% as.data.frame
                rownames(dummyG2) = exclusiveInG1
                colnames(dummyG2) = colnames(gr[[2]])
                gr[[1]] = rbind(gr[[1]],dummyG1)
                gr[[2]] = rbind(gr[[2]],dummyG2)
                
                
                gr %<>% lapply(function(x){
                    x[c(commonPaths,exclusiveInG1,exclusiveInG2),]
                })
                
                # here I do a simple wilcox test to get the most DE pathways.
                testRes = rownames(gr[[1]]) %>% sapply(function(x){
                    test = suppressWarnings(wilcox.test(gr[[1]][x,] %>% unlist,gr[[2]][x,] %>% unlist))
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
                
                pheatmap::pheatmap(apply(log(toPlot+1),2,scale01),cluster_cols = FALSE,
                                   annotation_col = annotCol,
                                   annotation_row = annotRow,
                                   show_colnames = FALSE,
                                   gaps_col = ncol(gr[[1]]),color = viridis::viridis(20),fontsize = 15)
            },value = 1,message = 'Plotting heatmap')
            
            
        }
        

        
        
    
        
    })
    
}


scale01 = 
function (x) 
{
    scaleToInt(x, 1, 0)
}

scaleToInt = function (x, max, min) 
{
    scaleFun = scaleIntervals(max(x, na.rm = TRUE), min(x, na.rm = TRUE), 
                              max, min)
    scaleFun(x)
}

scaleIntervals = function (max, min, maxOut, minOut) 
{
    a = (max - min)/(maxOut - minOut)
    b = max - maxOut * a
    if (a != 0) {
        return(teval(paste0("function(x){(x - ", b, ")/", a, 
                            "}")))
    }
    else {
        mean = (maxOut - minOut)/2
        return(teval(paste0("function(x){out = rep(", mean, ",length(x));names(out)=names(x);return(out)}")))
    }
}

teval = function (daString, ...) 
{
    eval(parse(text = daString), ...)
}
