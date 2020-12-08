## Merging and adding molecular subtype information

Base histology files:
 - The main histology file for CBTTC and PNOC003 which are part of v17 OpenPBTA was added from the v17 pbta-histologies.tsv file. 
 - For the new PNOC003 samples the base histology came from [base_histology in d3b-toolkit](https://github.com/d3b-center/d3b-bix-analysis-toolkit/blob/master/data/histologies/pnoc003_histologies_v17_candidate.csv)

 - For PNOC008, we received a file from ADAPT which was added [here](https://github.com/d3b-center/d3b-pnoc003-HGG-DMG-omics/blob/cohort_annotation/analyses/00.mol-clinical-annotation-files/input/pnoc008_histologies_candidate.tsv).

Edits to histology file
 - CNS_region=glioma_brain_region for new PNOC003 samples the base histology came from [base_histology in d3b-toolkit](https://github.com/d3b-center/d3b-bix-analysis-toolkit/blob/master/data/histologies/pnoc003_histologies_v17_candidate.csv) 
 -`Straned` value was changed to `stranded` for harmonization.
 - cohort_participant_id for PNOC003 samples in v17 was CXXXXX but since we need P-XX I've used the [bix-toolkit manifest](https://github.com/d3b-center/d3b-bix-analysis-toolkit/blob/master/data/histologies/pnoc003_histologies_v17_candidate.csv) to get the P-XX ids. 
 - P-19 OS_day was updated to 1563. 
 - "midline" from [base_histology in d3b-toolkit](https://github.com/d3b-center/d3b-bix-analysis-toolkit/blob/master/data/histologies/pnoc003_histologies_v17_candidate.csv) for PNOC003 samples not in v17 OpenPBTA were updated to "Midline". 
 - Autopsy tumor location is added from this [gsheet](https://docs.google.com/spreadsheets/d/1LRAuglLBzkKRhjzS9PtgVhqYMJqjlovDT-8-_jlJp5E/edit#gid=310829697) as primary_site
 - "BS_3ZPJAK9A" was set as WXS is now RNA-Seq with rna_library == "rna_exome"
 - "7316-716" was set to HGAT
 - P-07 TP53 status for BS_H8NWA41N (WGS) was set to "Yes" from @jainpayal022's [comment](https://github.com/d3b-center/d3b-pnoc003-HGG-DMG-omics/issues/150#issuecomment-723287114) 

## Cohort membership annotation description

pnoc003-dx (formerly, cohort_1)
  - only 1 PNOC003 primary Kids_First_Biospecimen_ID per 1 Kids_First_Participant_ID as per @jainpayal022's selection
   
   Panel | RNA-Seq |    WGS |    WXS 
   --- | --- | --- |---
1|      30   |   3   |   29 
   
pnoc003-dx-prog-pm (formerly, cohort_2)
  - 1 PNOC003 primary and ALL associated progression/autopsy samples as per @jainpayal022's selection
  
 RNA-Seq  |   WGS    | WXS 
 --- | --- | ---
 6    |  20     |  6 
  
pbta-hgat-dx (formerly, cohort_3a)
 - 1 (random) primary sample Kids_First_Biospecimen_ID per  experimental_strategy was add for each Kids_First_Participant_ID (within this file PNOC003 primary samples are from pnoc003-dx ). For PNOC008 only WXS and RNA-Seq from NANT were added.
 
 Panel | RNA-Seq |    WGS |    WXS 
   --- | --- | --- |---
   1    | 122  |    52    |  49 

pbta-hgat-dx-prog-pm (formerly, cohort_3b)
 - pbta-hgat-dx samples and associated 1 randomly selected progression sample per  experimental_strategy were added for CBTTC samples, for PNOC003 pnoc003-dx-prog-pm is used to get 1 primary and all associated progression/relapse samples as per @jainpayal022's selection)
 
  Panel | RNA-Seq |    WGS |    WXS 
   --- | --- | --- |---
  1  |   184  |   108   |   51
 
## TP53 and H3 mutation status annotation column description

## Inputs
```
input/50_RNAseq_only_mutations.maf.filter.txt
data/pbta-merged-chop-method-consensus_somatic.maf.gz 
data/pbta-consensus_seg_annotated_cn_autosomes.tsv.gz
```

TP53 cnv and snv status and H3 mutation status per sample_id; cell_line_composition is also used to match the cell_lines since sample_id is not unique for these cell_lines 
In addition for samples with only RNAseq available mutations in TP53 and histone gennes were identified using GATK RNAseq SNV calling [pipeline](https://cavatica.sbgenomics.com/u/d3b-bixu/rs-14jwqpdg-pnoc003-omics-analysis/apps/#d3b-bixu/rs-14jwqpdg-pnoc003-omics-analysis/d3b_gatk_rnaseq_snv_plus_vep/0) 

## age_at_diagnosis categorical values
The categories were described [here](https://github.com/d3b-center/bixu-tracker/issues/753#issuecomment-672277050) and coded in [here](https://github.com/d3b-center/d3b-pnoc003-omics/blob/data/clinical_annotation_file/analyses/7.%20Mol:clinical%20Annotation%20files/age_breaks_chisq.Rmd) to categorize patients per age in years

## OpenPBTA molecular subtyping,clinical and pathology feedback
In this [branch of OpenPBTA](https://github.com/kgaonkar6/OpenPBTA-analysis/tree/molecular_subtping_v18) molecular-subtyping-HGG and molecular-subtyping-pathology is run with the following inputs:

Inputs:
```
pbta-merged-chop-method-consensus_somatic.maf.gz
pbta-fusion-putative-oncogenic.tsv
pbta-cnv-consensus-gistic.zip
pbta-gene-expression-rsem-fpkm-collapsed.stranded.rds
pbta-gene-expression-rsem-fpkm-collapsed.polya.rds
pbta-fusion-arriba.tsv.gz
pbta-fusion-starfusion.tsv.gz
pbta-all-CN-cnv-consensus.seg.gz

```

## add ancestry and remove PNOC008 (from @tkoganti )
 ancestry for all samples in cohort3a from peddy [code](https://github.com/d3b-center/d3b-pnoc003-omics/tree/add_rnaseq_annotation/analyses/00.mol-clinical-annotation-files/ancestry_check)

short_ancestry | broad_ancestry
--- | ---
AFR | African
AMR | Ad Mixed American
EAS | East Asian
EUR | European
SAS | South Asian


## Output
```
output/annotation_files/
├── pbta-histologies.tsv
```

*Details about old columns updated :*
 
- integrated_diagnosis is updated for RNA-Seq-only samples from the H3_status column values since in OpenPBTA we haven't run RNAseq variant calling yet

 - molecular_subtype is updated for RNA-Seq-only samples from the H3_status column values since in OpenPBTA we haven't run RNAseq variant calling yet

*Details about new columns created :*

 - `TP53alteration_status` is 1 if either TP53_MOD_HIGH_mut_consensus==1 or TP53gain_consensus_cnv ==1 or TP53loss_consensus_cnv == 1 and TP53alteration_status is 0 is none of the columns for TP53 alteration are 1. For 50 RNAseq-only samples used we used TP53_MOD_HIGH_mut_rna_seq_snv == 1 `TP53alteration_status` is 1 else 0. 

 - `H3.status` is based on H3.3 mutation in [histone_gene]_MOD_HIGH_mut_consensus; where `histone_gene` are divided in H3.1 =c(HIST3H1B and HIST3H1C) and H3.3 is H3F3A if no histone gene mutation is found in consensus in either WGS (in addition WXS is also checked for PNOC003 samples) then wildtype. For 26 RNA-Seq only samples `H3.status`  is based on if [histone_gene]_MOD_HIGH_mut_rna_seq_snv equivalent to p.K28M or p.G35R and updated integrated_diagnosis and molecular_subtyping accordingly
 
 - `age_at_diagnosis_less_than_1_year` = ifelse (age_at_diagnosis_days<365 , "Yes","No")) 

 - `age_at_diagnosis_more_than_1_less_than_5_years` = ifelse(age_at_diagnosis_days > 365 & age_at_diagnosis_days < 1825, "Yes","No"))
 
 - `age_at_diagnosis_more_than_5_less_than_10_years` = ifelse (age_at_diagnosis_days > 1825 & age_at_diagnosis_days < 3650 , "Yes","No"))

 - `age_at_diagnosis_more_than_10_years` =  ifelse (age_at_diagnosis_days > 3650 , "Yes","No")) 
