# EdmEvGeneration
simple script for generating EDM format event from Gridpack and Sherpack

## Setup

```
cmsrel CMSSW_9_3_13
cd CMSSW_9_3_13/src
cmsenv
git-cms-addpkg Configuration/Generator
git clone https://github.com/SiewYan/EdmEvGeneration.git
cd EdmEvGeneration
source setup.sh
cd $CMSSW_BASE/src
scram b -j 4
```

## Generate Events

Working in EdmEvGeneration, make your hadronizer and gridpack/sherpack available in ```hadronizers``` and ```tarball``` folder.

```
cd EdmEvGeneration
./create_hadronizer.sh \
hadronizers/Hadronizer_TuneCP5_13TeV_generic_LHE_pythia8_cff.py \ 
tarball/darkPhoton_m40_slc6_amd64_gcc630_CMSSW_9_3_8_tarball.tar.xz
```

After the execution, you will find ```Hadronizer_TuneCP5_13TeV_generic_LHE_pythia8_cff_py_LHE_GEN.py```, you may generate edm event via cms executable

```
cmsRun Hadronizer_TuneCP5_13TeV_generic_LHE_pythia8_cff_py_LHE_GEN.py
```

## Issue

Working in lxplus produce site wide error

```
[shoh@lxplus126 EdmEvGeneration]$ cmsRun Hadronizer_TuneCP5_13TeV_generic_LHE_pythia8_cff_py_LHE_GEN.py 
----- Begin Fatal Exception 12-Mar-2019 12:10:28 CET-----------------------
An exception of category 'StdException' occurred while
   [0] Initializing plug-in manager
Exception Message:
A std::exception was thrown.
boost::filesystem::status: Permission denied: "/afs/cern.ch/sw/lcg/external/fastjet/3.0.3/x86_64-slc6-gcc48-opt/lib"
----- End Fatal Exception -------------------------------------------------
```
