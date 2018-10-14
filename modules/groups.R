group_ui = function(id){
    ns = NS(id)
    tagList(
        checkboxGroupInput(ns('group_checkbox'),
                           label = 'Groups'),
        actionButton(ns('remove'),'Remove selected', width = 200)
    )
}


group_server = function(input,output,session,mapSelection,tableSelection,map_or_table){
    groups = reactiveVal(value = list())

    observe({
        tableSelection()$subset
        if(map_or_table() == 'map'){
            if(!is.null(mapSelection()$subset)){
                newGroup = list(
                    mapSelection()$subset
                )
                isolate({
                    gr = groups()
                    
                    names(newGroup) = mapSelection()$name
                    
                    groups(c(groups(),newGroup))
                })
            }
        } else if(map_or_table() =='table'){
            if(!is.null(tableSelection()$subset)){
                newGroup = list(
                    tableSelection()$subset
                )
                isolate({
                    gr = groups()
                        
                    names(newGroup) = tableSelection()$name
                        
                    groups(c(groups(),newGroup))
                })
                
            }
            
        }
        
        
    })

    observe({
        updateCheckboxGroupInput(session,'group_checkbox',choices = names(groups()))
    })
    
    observeEvent(input$remove,{
        # remove selected groups on button press
        groups(groups()[!names(groups()) %in% input$group_checkbox])
    })
    
    selectedGroups = reactive({
        groups()[input$group_checkbox]
    })
    
    
    return(selectedGroups)
}