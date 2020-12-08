# Description 
Merged NGS and clinical files generated and used for modules in d3b-pnoc003-HGG-DMG-omics. 

20201202 release  s3://d3b-bix-dev-data-bucket/hgg-dmg-integration/20201202-data/

### metadata
FileName |  Description | Owner | Sample list
--- | --- | --- | ---
pbta-histologies.tsv | clinical and annotation information for samples | @kgaonkar6 | v17 PBTA + all PNOC003 + till P-23 008



### To-Do 

### DNA-Seq

FileName |  Description | Owner | Sample list
--- | --- | --- | ---
pbta-all-CN-cnv-consensus.seg.gz |consensus CNV files including neutral copy number| @zhangb1 | v17 PBTA + PNOC003 + 21 008
pbta-cnv-consensus-gistic.zip | gistic file | @zhangb1 | v17 PBTA + PNOC003 + 21 008
pbta-consensus_seg_annotated_cn_autosomes.tsv.gz | consensus CNV from open PBTA method| @zhangb1 | v17 PBTA + PNOC003 + 21 008
pbta-consensus_seg_annotated_cn_x_and_y.tsv.gz | consensus CNV from open PBTA method chr X and Y | @zhangb1 | v17 PBTA + PNOC003 + 21 008
pbta-merged-chop-method-consensus_somatic.maf.gz | merged maf file from CHOP method 2 of 4  | @zhangb1 | v17 PBTA + PNOC003 + 21 008
Strexome_targets_intersect_sorted_padded100.GRCh38.withCCDS.bed |  Strexome bed that is intersected with CCDS BED | @tkoganti | 
xgen-exome-research-panel-targets_hg38_ucsc_liftover.100bp_padded.sort.merged.withCCDS.bed | PNOC008 BED intersected with CCDS | @tkognati |  
StrexomeLite_hg38_liftover_100bp_padded.bed | hg38 targeted panel regions used for all variant callers, each region padded by 100 bp | @tkoganti | 
CCDS.bed | Coding genes list from  https://ftp.ncbi.nlm.nih.gov/pub/CCDS/current_human/CCDS.current.txt| @tkoganti | 
pbta-sv-manta.tsv.gz | manta SV annotated by annotSV | @zhangb1 @kgaonkar6 | v17 PBTA + PNOC003 + 2 WGS 008

### RNA-Seq 

FileName |  Description | Owner | Sample list 
--- | --- | --- | ---
gencode.v35.basic.annotation.gtf | GENCODE V35 hg38 gene annotation on primary assembly (reference chromosomes and scaffolds) | @tkoganti | NA
pbta-fusion-arriba.tsv.gz | Fusion - Arriba TSV, annotated with FusionAnnotator | @kgaonkar6 | v17 PBTA + PNOC003 + 21 008
pbta-fusion-putative-oncogenic.tsv | Filtered and prioritized fusions | @kgaonkar6 |  v17 PBTA + PNOC003 + 21 008
pbta-fusion-starfusion.tsv.gz | Fusion - STARFusion TSV | @kgaonkar6 | v17 PBTA + PNOC003 + 21 008
pbta-gene-expression-rsem-fpkm-collapsed.polya.rds | Gene expression - RSEM FPKM for poly-A samples (geneid-level) collapsed to gene symbol | @kgaonkar6 | v17 PBTA + PNOC003 + 21 008
pbta-gene-expression-rsem-fpkm-collapsed.stranded.rds | Gene expression - RSEM FPKM for stranded  samples (geneid-level) collapsed to gene symbol | @kgaonkar6 | v17 PBTA + PNOC003 + 21 008
pbta-gene-expression-rsem-fpkm.polya.rds | Gene expression - RSEM FPKM for poly-A samples (geneid-level) | @kgaonkar6 | v17 PBTA + PNOC003 + 21 008
pbta-gene-expression-rsem-fpkm.stranded.rds | Gene expression - RSEM FPKM for stranded  samples (geneid-level) | @kgaonkar6 | v17 PBTA + PNOC003 + 21 008
pbta-gene-expression-rsem-tpm-collapsed.polya.rds | Gene expression - RSEM FPKM for poly-A samples (geneid-level) collapsed to gene symbol | @kgaonkar6 | v17 PBTA + PNOC003 + 21 008
pbta-gene-expression-rsem-tpm-collapsed.stranded.rds | Gene expression - RSEM TPM for stranded  samples (geneid-level) collapsed to gene symbol | @kgaonkar6 | v17 PBTA + PNOC003 + 21 008
pbta-gene-expression-rsem-tpm.polya.rds | Gene expression - RSEM TPM for poly-A samples (geneid-level) collapsed to gene symbol | @kgaonkar6 | v17 PBTA + PNOC003 + 21 008
pbta-gene-expression-rsem-tpm.stranded.rds | Gene expression - RSEM TPM for stranded  samples (geneid-level) collapsed to gene symbol  | @kgaonkar6 | v17 PBTA + PNOC003 + 21 008
pbta-hgat-dx-gene-expression-rsem-fpkm-uncorrected.rds | pbta-hgat-dx uncorrected fpkm (n = 122) | @komalsrathi  | pbta-hgat-dx n = 122
pbta-hgat-dx-gene-expression-rsem-tpm-uncorrected.rds | pbta-hgat-dx uncorrected tpm  (n = 122) | @komalsrathi  | pbta-hgat-dx n = 122
pbta-hgat-dx-gene-expression-rsem-tpm-corrected.rds | pbta-hgat-dx corrected tpm (n = 122) | @komalsrathi | pbta-hgat-dx n = 122
pbta-hgat-dx-gene-expression-rsem-fpkm-corrected.rds | pbta-hgat-dx corrected fpkm (n = 122) | @komalsrathi | pbta-hgat-dx n = 122
pbta-gene-expression-rsem-tpm-collapsed.combined.rds | full combined tpm (n = 1049) | @komalsrathi |  v17 PBTA + PNOC003 + 21 008
pbta-gene-expression-rsem-fpkm-collapsed.combined.rds | full combined fpkm (n = 1049) | @komalsrathi |  v17 PBTA + PNOC003 + 21 008
50_RNAseq_only_mutations.maf.filter.txt | GATK variant calling for RNA-Seq for 50 only-RNA-Seq sample set | @zhangb1 | 50 RNA-Seq samples from v17PBTA
pbta-hgat-dx-prog-pm-tgen-gtex-gene-expression-rsem-tpm-uncorrected.rds | pbta-hgat-dx-prog (n = 184) + tgen (n = 5) + gtex brain (n = 1152) uncorrected tpm matrix (total n = 1341) | @komalsrathi | pbta-hgat-dx-prog (n = 184) + tgen (n = 5) + gtex brain (n = 1152)
pbta-hgat-dx-prog-pm-tgen-gtex-gene-expression-rsem-tpm-corrected.rds | pbta-hgat-dx-prog (n = 184) + tgen (n = 5) + gtex brain (n = 1152) corrected tpm matrix (total n = 1341) | @komalsrathi | pbta-hgat-dx-prog (n = 184) + tgen (n = 5) + gtex brain (n = 1152)
