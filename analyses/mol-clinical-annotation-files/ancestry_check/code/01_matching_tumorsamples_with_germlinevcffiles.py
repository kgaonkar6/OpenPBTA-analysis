#!/usr/bin/env python
#Author - Teja Koganti (D3B)
# This script takes in a manifest file with
#               1.germline VCF files
#               2. cohort3 manifest file with BS_ID, cohort_participant_id
#               3. cohort name

# The script merges the  two dataframes using cohort_participantid
# It also creates  a PED file in the PED-files folder for each sample


import pandas as pd
import numpy as np
import argparse
import  sys


parser = argparse.ArgumentParser()
parser.add_argument('-i', '--cohort3manifestfile', required = True,
                    help = 'path to the cohort3 manifestfile')
parser.add_argument('-g', '--germlinevcfmanifest', required = True,
                    help = 'path to the germlinevcfmanifest')
parser.add_argument('-o', '--outfile', required = True,
                    help = "output filename")
parser.add_argument('-c', '--cohortname', required = True,
                    help = "Name of cohort")
parser.add_argument('-p', '--pedfilefolder', required = True,
                    help = "Path to folder where  PED files can be  created")
args = parser.parse_args()


input_sample_bsid = pd.read_csv(args.cohort3manifestfile, sep="\t")
input_sample_bsid = input_sample_bsid.rename(columns = {"Kids_First_Biospecimen_ID": "Kids_First_Biospecimen_ID_tumor",
                                                       "experimental_strategy": "experimental_strategy_tumor"})

manifest_from_cavatica = pd.read_csv(args.germlinevcfmanifest, sep=",")
manifest_from_cavatica = manifest_from_cavatica.rename(columns={"case_id": "cohort_participant_id",
                                                               "Kids First Biospecimen ID": "Kids_First_Biospecimen_ID_germline",
                                                               "experimental_strategy": "experimental_strategy_germline"})


## Only choosing cohort   samples from cohort3a
input_sample_bsid = input_sample_bsid[input_sample_bsid["cohort"] == args.cohortname]

# combinging cohort3a and VCF manifest based on cohort id

combined_germline_after_mergingtumorandnormal = pd.merge(input_sample_bsid, manifest_from_cavatica, on=['cohort_participant_id'])[[
    "Kids_First_Biospecimen_ID_germline", "cohort_participant_id",
    "experimental_strategy_germline", "name", "gender"]].drop_duplicates()


# Changing names so that CBTTC column names are consistent witn PNOC003 files
combined_germline_after_mergingtumorandnormal = combined_germline_after_mergingtumorandnormal[[
    "name", "Kids_First_Biospecimen_ID_germline", "cohort_participant_id", "gender"]].rename(columns = {
    "name": "VCF", "cohort_participant_id": "case_id",
    "Kids_First_Biospecimen_ID_germline" : "BS_ID"})


# Writing to output file
combined_germline_after_mergingtumorandnormal.to_csv(args.outfile,
                                                     sep="\t", index=None)


# Creates individual PED.txt files for every sample in a folder called PED_files

for index, row in combined_germline_after_mergingtumorandnormal.iterrows():
    gender = ""
    pedfile = open(args.pedfilefolder+"/"+row["case_id"]+"_"+row["BS_ID"]+"_PED.txt", "w")
    if row["gender"] == "Female":
        gender = "2"
    else:
        gender = "1"
    pedfile.write("ignored\t"+row["BS_ID"]+"\t0\t0\t"+gender+"\t2\n")
    pedfile.close()
