#!/bin/bash

set -e
set -o pipefail

RELEASE=${OPENPBTA_RELEASE:-20201215-data}
PREVIOUS=${OPENPBTA_RELEASE:-20201202-data}

# get access
# chopaws

# get merged files
#aws s3 --profile saml cp s3://d3b-bix-dev-data-bucket/hgg-dmg-integration/$RELEASE/ data/release_003_008/ --recursive

##### get base histology #####
# get the base file from a already merged histology base file
#aws s3 --profile saml cp s3://d3b-bix-dev-data-bucket/hgg-dmg-integration/$RELEASE/pbta-histologies.tsv data/release_003_008/pbta-histologies-base.tsv

#OR 
# merge new sample to previous release and get updated base histology
# aws s3 --profile saml cp s3://d3b-bix-dev-data-bucket/hgg-dmg-integration/$PREVIOUS/pbta-histologies.tsv data/release_003_008/pbta-histologies-base.tsv
# Rscript analyses/mol-clinical-annotation-files/code/00_add_new_pnoc008_histologies.R
 
##############################


# run fusion filtering
# analyses/fusion_filtering/run_fusion_merged_003_008.sh 

# run molecular subtyping
bash analyses/molecular-subtyping-HGG/run-molecular-subtyping-HGG_003_008.sh

# run update from path and clinical updates
bash analyses/molecular-subtyping-pathology/run-subtyping-aggregation.sh

# add molecular subtyping to base
# analyses/mol-clinical-annotation-files/run_mol_clinical_anno.sh 
