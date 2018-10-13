ebi_metagenomics_api_base = "https://www.ebi.ac.uk/metagenomics/api/v1"
tara_metagenomics_study_id = "MGYS00000410"

# Pull all Tara sample data from the EBI API:
query_url = paste(ebi_metagenomics_api_base, "/studies", "/", tara_metagenomics_study_id, "/samples", sep="")
tara_samples_api_response <- fromJSON(content(GET(query_url), "text"), flatten = TRUE)
tara_samples_df <- tara_samples_api_response$data
next_url <- tara_samples_api_response$links$`next`
while (!is.null(next_url)) {
    tara_samples_api_response <- fromJSON(content(GET(next_url), "text"), flatten = TRUE)
    tara_samples_df <- rbind(tara_samples_df, tara_samples_api_response$data)
    next_url <- tara_samples_api_response$links$`next`
}
