
set -e
set -o pipefail

RELEASE=${OPENPBTA_RELEASE:-20201202-data}
PREVIOUS=${OPENPBTA_RELEASE:-20201109-data}

# get access
chopaws

# get merged files
aws s3 --profile saml cp s3://d3b-bix-dev-data-bucket/hgg-dmg-integration/$RELEASE/ data/release_003_008/ --recursive

# get previous histology
aws s3 --profile saml cp s3://d3b-bix-dev-data-bucket/hgg-dmg-integration/$PREVIOUS/pbta-histologies.tsv data/release_003_008/pbta-histologies-base.tsv

# merge new sample to get updated base histology
Rscript code/00_add_new_pnoc008_histologies.R

# run fusion filtering
analyses/fusion_filtering/run_fusion_merged_003_008.sh 

# run molecular subtyping
analyses/molecular-subtyping-HGG/run-molecular-subtyping-HGG_003_008.sh

# run update from path and clinical updates
analyses/molecular-subtyping-pathology/run-subtyping-aggregation.sh
