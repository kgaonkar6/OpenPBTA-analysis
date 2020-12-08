library(tidyverse)
library(googlesheets4)

root_dir <- rprojroot::find_root(rprojroot::has_dir(".git"))
setwd(root_dir)

# Original histology
pbta_hist<- read_tsv(file.path(root_dir,
                               "analyses",
                               "mol-clinical-annotation-files",
                               "output",
                               "annotation_files",
                               "pbta-histologies.tsv"))

# New PNOC008
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
    CNS_region=cns_region) 

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
bind_rows(pbta_hist,new_pnoc008)
