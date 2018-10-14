Microbial community metabolism in oceans drives biogeochemical cycling through vast networks of metabolic and gene transfer. Many global consortia have been created to characterize the role of viruses in various ocean phenomena, mostly through metagenomic shotgun sequencing and bioinformatic analysis. Several of these studies are available for analysis online, however little information has been made to aggregate this information and provide consistent annotation of metabolic pathways present. Our goal at Hackseq was to further characterize ocean viromes globally using all publicly available data through novel pathway-centric approaches derived by the Hallam Lab at UBC. This has allowed for a unified database of ocean viromes, allowing for the identification of known and novel metabolic hotspots. 

Considering the complexity and extent of data collected, our group created an R Shiny application to provide users an intuitive platform to explore and analyze this data. Our application's main feature, a map displaying sample collection locations, allows users to select samples and obtain all relevant information collected, including location temperature and salinity, depth, and metabolic pathway abundance. To give users the ability to compare the metabolic activity various samples, an analysis feature was created. Heatmaps of pathway abundance and sample clustering are currently available for comparison, allowing trends to be uncovered. Ultimately, our application provides a platform for researchers to start generating hypotheses for future sample expeditions or metabolic pathway investigations. Of equal importance, our interface design and straightforward analysis methods makes the application available to individuals interested in simply playing with the data to obtain a greater appreciation and understanding of the complexities of ocean viromes.  


# TaraCyc

TaraCyc contains the first ever large-scale mapping of viral metabolomics data collected from ocean environments around the world. The Tara Oceans Project travelled worldwide collecting water samples for shotgun metagenomic sequencing. This genomic data has been mapped to metabolomic pathways. Recently, viruses have been shown to encode proteins that interact with host metabolic pathways in ways not previously explored, such as a set of cyanophage that modified photosynthetic activity in infected cyanobacteria in order to promote viral replication [(Thompson et al)](http://www.pnas.org/content/pnas/108/39/E757.full.pdf).

The TaraCyc website contains all of this analysed metaviriome data with an interactive, user-friendly interface. The website can be accessed at: [Tara Viral Voyager](http://oganm.com/shiny/taracyc/).

## Website Use

The Map page contains an interactive map with filtering options to visulaize the distribution of viral samples and the data associated with them. Filtered dataset can also be saved for analysis. The Analysis page allows options for analysing the the groups generated on the map page. Users can generate heatmaps, BLANK.

## Source Code Information

### Software Requirements:

R

#### Packages

- dplyr
- readr
- shiny
- leaflet
- DT
- magrittr
- httr
- jsonlite
- shinydashboard
- glue
- mapedit
- sf
- reshape2
- tibble
- pheatmap
- shinythemes

### Installation Instructions:

1. Clone the git repository to local environment
2. Open the project in R Studio
3. Open the InstallDependencies.R script and run with "Source on Save" selected
4. Open the server.R script and select "Run App"

### Data Explanation

#### Parameters To Filter With
* Sample: Sample IDs begin with c (bacterial fraction), ERR (viral fraction), or F (combined)
* Sample Type: SINGLE (only one sample), MULTI (multiple samples analysed together)
* Depth (categorical values that describe the functional depth - metres below surface vary by environment):
  * DCM - deep chlorophyll maximum
  * SRF - surface water layer
  * MES - mesopelagic
  * Mix - 
  * MULTI - 
* Depthm - the depth in meters below the surface 
* Pathway Level 1-3: Categories of metabolic activity at varying levels of granularity. Level 1 is the most broad and Level 3 is the most specific
* Pathway Common Name: Single metabolic pathway
* Geo Region: Broad geographic region from which 1+ samples were collected
* RPKM - Reads per kilobase of transcript per million mapped reads (essentially, a normalized genomic abundance measure for genes involved in a given pathway)
