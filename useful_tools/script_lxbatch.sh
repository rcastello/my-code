#!/bin/zsh 

# script variables
RUNDIR= /afs/cern.ch/user/c/castello/WorkArea/Physics/zbb/CMSSW_4_4_4_gensim_amcATnlo/src/amc@NLO_gensim
OUTDIR= aMCatNLO_centralvalue
FILENAME= eebb_aMCatNLO_Pythia6Q_cff_py_GEN

# The batch job directory (will vanish after job end):
BATCH_DIR=$(pwd)
echo "Running at $(date) \n        on $HOST \n        in directory $BATCH_DIR."

# set up the CMS environment
cd $RUNDIR
eval `scramv1 runtime -sh`
rehash

cd $BATCH_DIR
echo Running directory changed to $(pwd).

##### RECO-ID ###############################
##cp $RUNDIR/Zbb/fit_Isolation_VS_VBTF.py .
##cp $RUNDIR/Zbb/fit_VBTF_VS_Track_data.py .

###### isolation #######################
#cp $RUNDIR/Zbb/fit_Isolation_VS_VBTF.py .

cp $RUNDIR/$FILENAME.py .
#cp $RUNDIR/CMSSW_4_4_4/src/PhysicsTools/TagAndProbe/test/fit/templateGsf.root .
#cp $RUNDIR/CMSSW_4_4_4/src/PhysicsTools/TagAndProbe/test/fit/template_medium.root .

# Execute.
time cmsRun $FILENAME.py >& $FILENAME.log

## MC
#time cmsRun fitIsolation_vsVBTF_mc.py datalike_mc >& file.log
#time cmsRun fitVBTF_vsTrack_mc.py datalike_mc >& file.log

echo "\nDirectory content after running cmsRun, zipping log file and merging histogram files:"
ls -lh

# Copy everything you need to MPS directory of your job,
# but you might want to copy less stuff to save disk space:
# (separate cp's for each item, otherwise you loose all if one file is missing):
rfcp *.log $RUNDIR/$OUTDIR/.
rfcp *.root $RUNDIR/$OUTDIR/.