set.seed(12345)

root_dir <- rprojroot::find_root(rprojroot::has_dir(".git"))
setwd(root_dir)

library(data.table)
get_alt<-function(gene){
  
  # consensus maf
  consensus_snv <- consensus_snv %>%
    # select only MODERATE/HIGH IMPACT mutations
    dplyr::filter((IMPACT %in% c("MODERATE","HIGH")))  %>%
    dplyr::select (c("Tumor_Sample_Barcode",
                     "Hugo_Symbol","HGVSp_Short")) %>%
    # select only gene
    dplyr::filter(Hugo_Symbol %in%  gene ) %>% 
    # unique so that 1 = mutation exists 0 mutation doesn't exist
    unique() %>% 
    dplyr::mutate(data_source="consensus_snv")
  
  rna_seq_snv <- rna_seq %>%
    # select only MODERATE/HIGH IMPACT mutations
    dplyr::filter((IMPACT %in% c("MODERATE","HIGH")))  %>%
    dplyr::select (c("Tumor_Sample_Barcode",
                     "Hugo_Symbol","HGVSp_Short")) %>%
    # select only gene
    dplyr::filter(Hugo_Symbol %in%  gene ) %>% 
    # unique so that 1 = mutation exists 0 mutation doesn't exist
    unique() %>% 
    dplyr::mutate(data_source="rnaseq_snv")
  
  consensus_cnv <- consensus_cnv %>%
    # select TP53
    dplyr::filter(gene_symbol %in% gene) %>% 
    dplyr::mutate(data_source="consensus_cnv")
  
  gene_alt_list<-list(#"strelka2"=strelka2,"mutect2"=mutect2,
                      "consensus_snv"=consensus_snv,"consensus_cnv"=consensus_cnv,"rna_seq_snv"=rna_seq_snv)
  
}