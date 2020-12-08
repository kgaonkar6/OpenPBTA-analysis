#!/usr/bin/env python
# Author - Teja Koganti (D3B)

# This script takes in a manifest file with
#               1.hetcheckfile - list of peddy output files with extension "het_check.csv"
#               2.file with germline BS_ID and cohort_participant_id

# The script merges ancestry information with cohort_participant_id using BS_ID



import pandas as pd
import numpy as np
import argparse
import  sys

parser = argparse.ArgumentParser()
parser.add_argument('-i', '--hetchecklistfile', required = True,
                    help = 'List of all the hetcheck files from peddy output')
parser.add_argument('-c', '--germlineandtumormergedfile', required = True,
                    help = 'Based on case_id, merged germline and tumor files')
parser.add_argument('-o', '--outfile', required = True,
                    help = "output filename")
args = parser.parse_args()


# Creating a germline_ancestry dataframe that has all the het)check output files from peddy
germline_ancestry = pd.DataFrame(columns=["BS_ID", "ancestry"])


for hetfile in open(args.hetchecklistfile, "r"):
    het_file = open(hetfile.strip("\n"), "r")
    line = (het_file.readlines()[1])
    germline_ancestry = germline_ancestry.append({'BS_ID': line.split(",")[0],
                                                  'ancestry': line.split(",")[11]}, ignore_index=True)

# Reading in file with germline BS_ID and cohort_participant_id
combined_germline_after_mergingtumorandnormal = pd.read_csv(args.germlineandtumormergedfile,
    sep="\t")


# Merging file with `cohort_participant_id` with peddy output and writing `ancestry` and ``cohort_participant_id` to output file
pd.merge(combined_germline_after_mergingtumorandnormal, germline_ancestry, on=['BS_ID'])[
    ["ancestry", "case_id"]].drop_duplicates().to_csv(args.outfile, sep="\t", index=None)
