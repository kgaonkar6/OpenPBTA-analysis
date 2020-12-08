Running python scripts with different cohorts -

python3 code/01_matching_tumorsamples_with_germlinevcffiles.py
    -i inputs/cohort3a_manifest.txt -g inputs/cbttc_germlinevcf.manifest.csv
    -o inputs/cohort3a_CBTTC_germline_vcf_bsid_and_caseid.txt -c CBTTC -p PED_files

python3 code/01_matching_tumorsamples_with_germlinevcffiles.py
  -i inputs/cohort3a_manifest.txt -g inputs/pnoc003_germline_manifest.csv
  -o inputs/cohort3a_PNOC003_germline_vcf_bsid_and_caseid.txt -c PNOC003 -p PED_files




python3 code/02_matching_ancestry_with_tumor_BS_ID.py
  -i inputs/cbttc_het_check_files.txt -c inputs/cohort3a_CBTTC_germline_vcf_bsid_and_caseid.txt
  -o outfiles/CBTTC_samples_ancestry.txt

python3 code/02_matching_ancestry_with_tumor_BS_ID.py
  -i inputs/pnoc003_het_check_files.txt -c inputs/cohort3a_PNOC003_germline_vcf_bsid_and_caseid.txt
  -o  outfiles/PNOC003_samples_ancestry.txt
