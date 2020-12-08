## Ancestry check

- Using peddy tool to get ancestry for all samples in cohort3a

- All BS_ID's in cohort3a  are tumor. We use `cohort_participantid` to map germline VCF files to use as input for peddy tool

- Once peddy is run, we use `*het_check.csv` file to get the ancestry information

Steps -

1. First step is to match the tumor BS_ID with germline BS_ID and make a PED file using germline BS_ID as sample ID and gender from histology file.
  - PNOC003 and CBTTC samples were run separately

      python3 code/01_matching_tumorsamples_with_germlinevcffiles.py
        -i inputs/cohort3a_manifest.txt -g inputs/cbttc_germlinevcf.manifest.csv
        -o inputs/cohort3a_CBTTC_germline_vcf_bsid_and_caseid.txt -c CBTTC -p inputs/PED_files

      python3 code/01_matching_tumorsamples_with_germlinevcffiles.py
        -i inputs/cohort3a_manifest.txt -g inputs/pnoc003_germline_manifest.csv
        -o inputs/cohort3a_PNOC003_germline_vcf_bsid_and_caseid.txt -c PNOC003 -p inputs/PED_files

  - Output from this creates a `inputs/PED_files` folder
  - Second output is files with `VCF`, `BS_ID` and `cohort_participantid`


2. Using the output files from above step, run peddy in a while loop -
  - Create a peddy_out folder(not committed to repo) and run the while loop command within the folder
  - `while read VCF BSID caseID; do peddy --sites hg38 --plot --prefix  $caseID"_"$BSID "../germline_VCF_files/"$VCF "inputs/PED_files/"$caseID"_"$BSID"_PED.txt" ; done < inputs/cohort3a_PNOC003_germline_vcf_bsid_and_caseid.txt`


3. Collect all het_check folders from peddy output -
    - `ls -1 peddy_out/P*het_check.csv > inputs/pnoc003_het_check_files.txt`


4. Output files will have germline BS_ID and ancestry information. Match this with cohort participant_id -

    python3 code/02_matching_ancestry_with_tumor_BS_ID.py
      -i inputs/cbttc_het_check_files.txt -c inputs/cohort3a_CBTTC_germline_vcf_bsid_and_caseid.txt
      -o outfiles/CBTTC_samples_ancestry.txt

    python3 code/02_matching_ancestry_with_tumor_BS_ID.py
      -i inputs/pnoc003_het_check_files.txt -c inputs/cohort3a_PNOC003_germline_vcf_bsid_and_caseid.txt
      -o  outfiles/PNOC003_samples_ancestry.txt


5. Downloaded annotation file (`hgat_all_primary_TP53_SNV_CNV_consensus_nopnoc008.tsv`)  from annotations folder in repo and added ancestry column using the script below
      - `4.combine_annotation_and_ancestry`
