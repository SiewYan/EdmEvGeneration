import os
import FWCore.ParameterSet.Config as cms
import FWCore.Utilities.FileUtils as FileUtils
#mylist = FileUtils.loadListFromFile('---')

process = cms.Process("lambda")

process.load("FWCore.MessageService.MessageLogger_cfi")

process.maxEvents = cms.untracked.PSet( input = cms.untracked.int32(-1) )

process.option = cms.untracked.PSet( wantSummary = cms.untracked.bool(True) )

process.source = cms.Source("PoolSource",
        fileNames = cms.untracked.vstring(
        'file:$CMSSW_BASE/src/EdmEvGeneration/sherpa_HAHM_variableMW_UFO_Zpmumu_LO_13TeV_MASTER_cff_py_GEN.root'
        )
)

process.lamb = cms.EDAnalyzer("LambdaAnalyzer",
                              genSet = cms.PSet(
                                                genProduct = cms.InputTag('generator'),
                                                lheProduct = cms.InputTag('externalLHEProducer'),
                                                genParticles = cms.InputTag('prunedGenParticles'),
                                                pdgId = cms.vint32(1, 2, 3, 4, 5, 6, 11, 12, 13, 14, 15, 16, 21, 23, 24, 25, 52, 55, 54), #52 DM; 55 Zp; 54 hs 
                                                ),
                              electronSet = cms.PSet(
                                                electrons = cms.InputTag('slimmedElectrons'),
                                                vertices = cms.InputTag('offlineSlimmedPrimaryVertices'),
                                                ),
                              muonSet = cms.PSet(
                                                muons = cms.InputTag('slimmedMuons'),
                                                ),
                              jetSet = cms.PSet(
                                                vertices = cms.InputTag('offlineSlimmedPrimaryVertices'),
                                                jets = cms.InputTag('slimmedJets'),
                                                met = cms.InputTag('slimmedMETs'),
                                                genjets = cms.InputTag('slimmedGenJets'),
                                                ),
                              #fatJetSet = cms.PSet(
                              #                  jets = cms.InputTag('slimmedJetsAK8'),
                              #                  ),
                              histFile = cms.string('%s/src/EdmEvGeneration/EdmEvAnalyzer/data/HistList.dat' % os.environ['CMSSW_BASE']),
                              )

process.TFileService = cms.Service("TFileService",
                                    fileName = cms.string("sherpa_HAHM_variableMW_UFO_Zpmumu_LO_13TeV.root"),
                                    closeFileFast = cms.untracked.bool(True)
                                    )

process.p = cms.Path(process.lamb)
