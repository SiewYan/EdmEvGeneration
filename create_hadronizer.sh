#!/bin/bash

set -e

Nevent=1000

if [ -z $1 ];then
    echo "ERROR, please supply fragment"
    exit
else
    frag=$1
    name=`ls $frag | awk -F '/' '{print $NF}' | awk -F '.' '{print $1}'`
    echo "Receive fragment file = $frag"
    echo "Name = ${name}"
    if [ -f ${CMSSW_BASE}/Configuration/GenProduction/python/ThirteenTeV/Hadronizer/${name}.py ];then
	rm ${CMSSW_BASE}/Configuration/GenProduction/python/ThirteenTeV/Hadronizer/${name}.py
    fi
fi

if [ -z $2 ];then
    echo "ERROR, please supply gridpack/sherpack"
    exit
else
    tar=$2
    tarname=`echo $tar | awk -F "/" '{print $NF}' | awk -F "_" '{print $1"_"$2}'`
    echo "Receive gridpack file = $tar"
fi

#if [ "$PWD" == "$CMSSW_BASE" ];then
#    name=`echo "$PWD" | awk -F '/' '{print $NF}'`
#fi

##add externalLHEProducer
flag1=`grep "externalLHEProducer" $1 | awk -F '=' '{print $1}'`

if [ "$flag" != "externalLHEProducer" ];then
    CONFIG=${name}_cfi.py
    cat > ${CONFIG} <<EOF                                                                                                                                                                         
import FWCore.ParameterSet.Config as cms 
externalLHEProducer = cms.EDProducer('ExternalLHEProducer',
args = cms.vstring('${CMSSW_BASE}/src/EdmEvGeneration/$tar'),
nEvents = cms.untracked.uint32(1000),
numberOfParameters = cms.uint32(1),
outputFile = cms.string('cmsgrid_final.lhe'),
scriptName = cms.FileInPath('GeneratorInterface/LHEInterface/data/run_generic_tarball_cvmfs.sh')
)

EOF

    cat $frag >> ${CONFIG}
fi

mv ${CONFIG} $CMSSW_BASE/src/Configuration/GenProduction/python/ThirteenTeV/Hadronizer/${name}.py
echo "Custom hadronizer is resided in Configuration/GenProduction/python/ThirteenTeV/Hadronizer/${name}.py"
eval cd $CMSSW_BASE/src/Configuration/GenProduction/python/
scram b -j3
eval cd $CMSSW_BASE/src/EdmEvGeneration
scram b -j3

echo "

cmsDriver.py Configuration/GenProduction/python/ThirteenTeV/Hadronizer/${name}.py \
--mc -n $Nevent -s LHE,GEN --datatier GEN,GEN-SIM --eventcontent LHE,RAWSIM --fileout=${tarname}.root \
--conditions auto:run2_mc_FULL --beamspot Realistic25ns13TeVEarly2017Collision  --no_exec --python_filename=${tarname}_cff_GEN.py

"

begin=$(date +"%s")

cmsDriver.py Configuration/GenProduction/python/ThirteenTeV/Hadronizer/${name}.py \
--mc -n $Nevent -s LHE,GEN --datatier GEN,GEN-SIM --eventcontent LHE,RAWSIM --fileout=${tarname}.root \
--conditions auto:run2_mc_FULL --beamspot Realistic25ns13TeVEarly2017Collision  --no_exec --python_filename=${tarname}_cff_GEN.py

begin=$(date +"%s")
echo "cmsRun ${tarname}_cff_GEN.py"
termin=$(date +"%s")
difftimelps=$(($termin-$begin))
echo "$(($difftimelps / 60)) minutes and $(($difftimelps % 60)) seconds elapsed for Script Execution."

#--no_exec

#-s LHE,GEN --datatier GEN,GEN-SIM --eventcontent LHE,RAWSIM
