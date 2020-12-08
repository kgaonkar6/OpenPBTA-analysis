library(tidyverse)
library(googlesheets4)

root_dir <- rprojroot::find_root(rprojroot::has_dir(".git"))
setwd(root_dir)

# Original histology from previors release
pbta_hist<- read_tsv(file.path(root_dir,
                               "data",
                               "release_003_008",
                               "pbta-histologies-base.tsv"))

# New PNOC008 in gsheet
new_pnoc008 <- read_sheet("https://docs.google.com/spreadsheets/d/1nqdCRCosj9RsGnvy8hkPpDZ2SLTNPPR1EzazP98xcpo/edit#gid=0") %>%
  dplyr::mutate(
    broad_histology= case_when(sample_type == "Tumor" 
                               ~"Diffuse astrocytic and oligodendroglial tumor",
                               TRUE ~ broad_histology),
    short_histology= case_when(sample_type =="Tumor" 
                               ~ "HGAT",
                               TRUE ~ short_histology)
    ) %>%
  dplyr::rename(
    CNS_region=cns_region) %>%
  as.data.frame() %>%
  mutate_at(c('os_days','age_last_update_days',
              'normal_fraction','tumor_fraction',
              'tumor_ploidy'),as.numeric) 

# rename some colnames to fit OpenPBTA
colnames(new_pnoc008)[which
                       (colnames(new_pnoc008) %in%
                           c("kids_first_biospecimen_id",
                             "kids_first_participant_id",
                             "notes",
                             "rna_library",
                             "os_days",
                             "os_status"
                           ))] <- c("Kids_First_Biospecimen_ID",
                                    "Kids_First_Participant_ID",
                                    "Notes",
                                    "RNA_library",
                                    "OS_days",
                                    "OS_status")

# bind new pnoc008 to histology file
bind_rows(pbta_hist,new_pnoc008) %>%
  # remove annotation that will come from this module
  #
  dplyr::select(
    # cohort membership as part of 01_cohort_membership.Rmd
    -starts_with("pnoc003"),-starts_with("pbta-hgat"),
    # HIST mutation status added as part of 02_get_alt.Rmd
    -starts_with("HIST"),
    # H3F3 mutation status added as part of 02_get_alt.Rmd
    -starts_with("H3"),
    # TP53 mutation status added as part of 02_get_alt.Rmd
    -starts_with("TP53"),
    # age group added as part of 03_additional_clinical_annotation.Rmd
    -starts_with("age_at_diagnosis_less"),
    -starts_with("age_at_diagnosis_more"),
    # remove ancestry 
    -starts_with("ancestry")
    ) %>%
  unique() %>%
  write_tsv(file.path(root_dir,
                      "data",
                      "release_003_008",
                      "pbta-histologies-base.tsv"))
