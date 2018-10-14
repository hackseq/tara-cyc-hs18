library(data.tree)
library(networkD3)

dataset <- read.table("data/df_MASTERTABLE.txt", sep = "\t", header = TRUE)

dataset$pathString <- paste("pathway",
                            dataset$LEVEL1,
                            dataset$LEVEL2,
                            dataset$LEVEL3,
                            sep = "/")

tree <- as.Node(dataset)

biosynthesis_tree <- tree$Biosynthesis

pathway_network <- ToDataFrameNetwork(tree, "name")

simpleNetwork(pathway_network[-3], fontSize = 12)

plot(biosynthesis_tree)
