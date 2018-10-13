ebi_metagenomics_api_base = "https://www.ebi.ac.uk/metagenomics/api/v1"
noaa_climate_api_base = "https://www.ncdc.noaa.gov/cdo-web/api/v2/"
noaa_climate_api_token = "ZMotwncQdZGvdEvbPnlkaoSmPkIorlkM"
metacyc_pwy_api_base = "https://websvc.biocyc.org/getxml?META:"

tara_metagenomics_viral_fraction_shotgun_dna_study_id = "MGYS00001918"
tara_metagenomics_prokaryotic_fraction_metatranscriptome_rna_study_id = "MGYS00001482"
tara_metagenomics_protist_fraction_amplicon_dna_study_id = "MGYS00002392"
tara_metagenomics_protist_fraction_amplicon_rna_study_id = "MGYS00001789"
tara_metagenomics_prokayyotic_fraction_shotgun_dna_study_id = "MGYS00000410"
tara_metagenomics_viral_fraction_amplicon_dna_study_id = "MGYS00001811"
tara_metagenomics_prokaryotic_and_protist_fraction_amplicon_dna_study_id = "MGYS00000492"

# Pull all sample data from a study using the EBI API:

get_samples_by_study_id <- function (study_id, ebi_metagenomics_api_base = "https://www.ebi.ac.uk/metagenomics/api/v1") {
    query_url = paste(ebi_metagenomics_api_base, "/studies", "/", study_id, "/samples", sep="")
    api_response <- fromJSON(content(GET(query_url), "text"), flatten = TRUE)
    samples_df <- api_response$data
    samples_metadata <- api_response$data$`attributes.sample-metadata`
    next_url <- api_response$links$`next`
    while (!is.null(next_url)) {
        api_response <- fromJSON(content(GET(next_url), "text"), flatten = TRUE)
        samples_df <- rbind(samples_df, api_response$data)
        next_url <- api_response$links$`next`
    }
    
    samples_df
}
