set echo
setenv PATH $HOME/.local/bin:/afs/cern.ch/cms/lumi/brilconda-1.1.7/bin:$PATH
pip install --install-option="--prefix=$HOME/.local" brilws
#Runs from JSON file
# ---> already done UNCOMMENT <--------
#brilcalc lumi -b "STABLE BEAMS" -u /fb --normtag /afs/cern.ch/user/l/lumipro/public/normtag_file/normtag_DATACERT.json -i Cert_271036-284044_13TeV_23Sep2016ReReco_Collisions16_JSON.txt | grep "| 2" | cut -d "|" -f 2 | cut -d ":" -f 1 >runs36.459fbinv.txt

# Trigget.txt: file with HLT paths to check without the _v* sufix
#Prescales for given runs and HLT paths
foreach i ( `cat runs36.459fbinv.txt ` )
foreach j (`cat Triggers.txt`)
setenv p "${j}_v*"
brilcalc trg --prescale --hltpath "$p" -r ${i} >> Prescales${j}.txt
end
end

# Lumi for HLT paths using JSON file based on prescales , LS removal based on prescales of L1 seeds
foreach i (`cat Triggers.txt`)
setenv p "${i}_v*"
brilcalc lumi -u /fb --normtag /afs/cern.ch/user/l/lumipro/public/normtag_file/normtag_DATACERT.json -i Cert_271036-284044_13TeV_23Sep2016ReReco_Collisions16_JSON.txt --hltpath "$p" >> Lumi${i}.txt &
end

#L1seedsForPath.txt: txt files with L1 seeds to check for a given HLT path
#LS removal based on prescales of seelted individual L1 seeds
foreach i (`cat Triggers.txt`)
foreach j (`cat L1seedsFor${i}.txt`)
python stripPrescaledLumis.py ${i} ${j}
compareJSON.py --sub Cert_271036-284044_13TeV_23Sep2016ReReco_Collisions16_JSON.txt StripLumisForPath_${i}_withLowestSeed_${j}.json > LSfor_${i}_withLowestSeed_${j}.json
cp StripLumisForPath_${i}_withLowestSeed_${j}.json RemovedLS_fromCert_271036-284044_13TeV_23Sep2016ReReco_Collisions16_JSON_${i}_withLowestSeed_${j}.json
end
end

#Reorganization
foreach i (`cat Triggers.txt`)
mkdir -p ${i}
mv *${i}*.* ${i}/
end
