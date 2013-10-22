#!/bin/bash 
set -x

BINDIR=`pwd -P`
TEMPLATEFILE="$BINDIR/TEMPLATEFILE"
TARGET=$1
OUTFILE=$2

export PDB_DIR="$BINDIR/PDBdir/"
export NO_REMOTE_PDB_DIR=1
unset MAFFT_BINARIES

t_coffee -in $TARGET -method sara_pair -template_file $TEMPLATEFILE,RNA -extend_mode rna2 -outfile $OUTFILE -relax_lib 0 -output clustalw,html  -transform dna2rna -cache=no -n_core 1 -pdb_min_sim 0  
