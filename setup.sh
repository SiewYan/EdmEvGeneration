#!/bin/bash

mkdir -p $CMSSW_BASE/src/Configuration/GenProduction/python/ThirteenTeV/Hadronizer/
mkdir -p $CMSSW_BASE/src/Configuration/Generator/python/PSweightsPythia/
wget -P $CMSSW_BASE/src/Configuration/Generator/python/PSweightsPythia/ https://raw.githubusercontent.com/cms-sw/cmssw/master/Configuration/Generator/python/PSweightsPythia/PythiaPSweightsSettings_cfi.py