#!/bin/bash


files=data/*

for i in $files
do
  cwltool  Screw/cwl/tools/preprocess.cwl --toConvert $i --format "farlik2016"
done

mkdir meth meth_sym prop_meth cov_bw subset

mv *.meth meth
mv *meth.sym meth_sym
mv *prop_meth.bw prop_meth
mv *.cov.bw cov_bw


files=meth_sym/*
for i in $files
do
  cwltool Screw/cwl/tools/subsetByBed.cwl --bedFile hg19_enhancer_atlas_cd34.bed --toSubset $i
done

mv *meth.sym subset

cwltool Screw/cwl/tools/clustering.cwl --pairDirectory subset --annotation heatmap.txt



