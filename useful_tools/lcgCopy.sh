#!/bin/sh
#for i in `seq 100 420` ; do
file=open('sample.txt',r)
for line in file; do
    $i=line
    lcg-cp -v -n 10 srm://storm-se-01.ba.infn.it/cms/store/user/castello/DoubleElectron/ZbbSkimSummer11_PAT42X_05Aug_EleMay10_merge/8c400e1e15d0783f01cf6878ab05abcc/$i srm://srm-cms.cern.ch:8443/srm/managerv2?SFN=/castor/cern.ch/user/c/castello/Zbb/PATtuple2011_test/$i
    edmEventSize -v -a /castor/cern.ch/user/c/castello/Zbb/PATtuple2011_test/$i
done
file.close()