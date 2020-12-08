library(tidyverse)

root_dir <- rprojroot::find_root(rprojroot::has_dir(".git"))
setwd(root_dir)


# Base histology from v17 PBTA
pbta_v17 <- read_tsv(file.path(root_dir,
                           "analyses",
                           "mol-clinical-annotation-files",
                           "input",
                           "pbta-histologies.tsv"),
                 col_types = cols(.default = "c"))

pnoc003_new_manifest <- read_csv(file.path(root_dir,
                                           "analyses",
                                           "mol-clinical-annotation-files",
                                           "input",
                                           "pnoc003_histologies_v17_candidate.csv"),
                                 col_types = cols(.default = "c")) %>%
  dplyr::filter(!kids_first_biospecimen_id %in% pbta_v17$Kids_First_Biospecimen_ID) %>%
  dplyr::mutate(pathology_free_text_diagnosis=NA_character_,
                CNS_region=glioma_brain_region)


# ADAPT provided bas PNOC008 histology file
pnoc008_new_manifest <- read_tsv(file.path(root_dir,
                                           "analyses",
                                           "mol-clinical-annotation-files",
                                           "input",
                                           "pnoc008_histologies_candidate.tsv"),
                     col_types = cols(.default = "c")) %>%
  dplyr::mutate(
                "broad_histology"="Diffuse astrocytic and oligodendroglial tumor",
                "short_histology"="HGAT") %>%
  dplyr::rename(
                CNS_region=cns_region) 

# merge manifest
new_manifest <- bind_rows(
                           pnoc003_new_manifest,
                           pnoc008_new_manifest) 

# rename some colnames to fit OpenPBTA
colnames(new_manifest)[which
                        (colnames(new_manifest) %in%
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

# save
bind_rows(pbta_v17,new_manifest) %>%
  dplyr::mutate(experimental_strategy = if_else(Kids_First_Biospecimen_ID=="BS_3ZPJAK9A","RNA-Seq",experimental_strategy),
                RNA_library = if_else(Kids_First_Biospecimen_ID=="BS_3ZPJAK9A","rna_exome",RNA_library)) %>%
  dplyr::mutate(short_histology = if_else(sample_id == "7316-716","HGAT",short_histology),
                broad_histology = if_else(sample_id == "7316-716","Diffuse astrocytic and oligodendroglial tumor",broad_histology)) %>%
  unique() %>%
  write_tsv(file.path(root_dir,
                      "analyses",
                      "mol-clinical-annotation-files",
                      "input","pbta-base-histologies.tsv")) 
