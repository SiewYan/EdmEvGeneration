#!/bin/bash

begin=$(date +"%s")
echo "cmsRun darkPhoton_m200_cff_GEN.py"
cmsRun darkPhoton_m200_cff_GEN.py 
termin=$(date +"%s")
difftimelps=$(($termin-$begin))
echo "$(($difftimelps / 60)) minutes and $(($difftimelps % 60)) seconds elapsed for Script Execution."
