#!/bin/bash

set -e
set -o pipefail


# merge CBTN, PNOC003 and PNOC008 histologies and format
# Rscript code/00_merge_histologies.R						

# add new PNOC008
# Rscript code/00_add_new_pnoc008_histologies.R

# get cohort1 and cohort2 cohort3a and cohort3b membership annnotation
Rscript -e "rmarkdown::render('code/01_cohort_membership.Rmd')"	

# get alterations for TP53,H3 mutatiionns 
Rscript -e "rmarkdown::render('code/02_get_alt.Rmd')"

# get age categories for HGAT and tumor_location for autopsy samples
Rscript -e "rmarkdown::render('code/03_additional_clinical_annotation.Rmd')"

# get annotation files mereged with histology file
Rscript -e "rmarkdown::render('code/04_hgat_annotation_files.Rmd')"

# add ancestry and remove 008
papermill code/05_adding_ancestry.ipynb code/05_adding_ancestry.ipynb 

# qc histology file
Rscript -e "rmarkdown::render('code/06_qc_annotation_file.Rmd')"
