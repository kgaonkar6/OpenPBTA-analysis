#!/usr/bin/env python
# Author - Teja Koganti (D3B)

# This script takes files -
#               1. cbttc ancetsry file
#               2. pnoc003 ancestry file
#               3. annotation file
# The script merges ancestry  information from multiple cohort groups
# and adds that  to the annotations file


import pandas as pd
import numpy as np
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-c', '--cbttc_ancestryfile', required = True,
                    help = 'List of cbttc cohort_participant ids with ancestry')
parser.add_argument('-p', '--pnoc003_ancestryfile', required = True,
                    help = 'List of pnoc003 cohort_participant ids with ancestry')
parser.add_argument('-a', '--annotationsfile', required = True,
                    help = 'File with annotations')
parser.add_argument('-o', '--outfile', required = True,
                    help = "output filename")
args = parser.parse_args()


# Reading peddy output files from PNOC003 and CBTTC
pnoc003_ancestry = pd.read_csv(args.pnoc003_ancestryfile, sep="\t").drop_duplicates(
    ).rename(columns={"case_id": "cohort_participant_id"})
cbttc_ancestry = pd.read_csv(args.cbttc_ancestryfile, sep="\t").drop_duplicates(
    ).rename(columns={"case_id": "cohort_participant_id"})


# Reading annotations file and separating different. cohorts (these will be merged later - I also checked that the shape
#    of this dataframe is the same after concat)
annotations_file = pd.read_csv(args.annotationsfile, sep="\t")
annotations_cbttc = annotations_file[annotations_file["cohort"]=="CBTTC"]
annotations_pnoc003 = annotations_file[annotations_file["cohort"]=="PNOC003"]


# Merging ancestry with rest of annotations file
pnoc003_ancestry_and_annotations = pd.merge(pnoc003_ancestry, annotations_pnoc003, on=[
    'cohort_participant_id'], how="outer")
pnoc003_ancestry_and_annotations = pnoc003_ancestry_and_annotations.reindex(
    sorted(pnoc003_ancestry_and_annotations.columns), axis=1)

cbttc_ancestry_and_annotations = pd.merge(cbttc_ancestry, annotations_cbttc, on=[
    'cohort_participant_id'], how="outer")
cbttc_ancestry_and_annotations = cbttc_ancestry_and_annotations.reindex(
    sorted(cbttc_ancestry_and_annotations.columns), axis=1)

# Concat on all  cohorts
pd.concat([pnoc003_ancestry_and_annotations,
                            cbttc_ancestry_and_annotations]).to_csv(
    args.outfile, index=None, sep="\t")
