#!/bin/bash       
echo "Author: R.Castello (2017)"   
echo "This script replaces lines in a template mca provided as input and provide the final mca to be run by sos_plots.py"  
echo "You need to specify:"  
echo "- a file 'list.txt' with (on each line):  _signName _label _xSec of the signal you want to run on"  
echo "- a file 'input.txt' with (on each line) the strings of the mca (systematics variations, etc..) you want to replicate for each of the signal points"  
echo "- a name for the mca block for the signal (OUTPUT_FILE) which will be attached to the templaate mca"
echo "- a name for output mca (OUTPUT_MCA_FRDATA)"  
echo "- a name for output mca (OUTPUT_MCA_MCDATA)"  
echo "After running the script the mca_signal_block.txt with the signal block will be produced and attached to the template mca giving in output the final mca ready to be used."  
echo "==================================================="  

INPUT_FILE="input_TChiWZ.txt" #"input_TChiWZ_noMET.txt" #"input_T2tt_noISR.txt" #"input_T2tt_noISR.txt" # "input_TChiWZ_comb.txt" 
LIST="list_TN2N1_phenoFinal.txt"   #"list_TChiWZ.txt" #"list_pMSSM.txt" #"list_TN2N1.txt" #"list_onepoint.txt" #"list_T2tt.txt" # "list_onepoint.txt"
OUTPUT_FILE="mca_signal_block_TN2N1_phenoFinal.txt" 
OUTPUT_MCA_FRDATA="mca-2los-test2-mcdata-frdata_FastSimTN2C1_phenoFinal.txt"
OUTPUT_MCA_MCDATA="mca-2los-test2-mcdata_FastSimTN2C1_phenoFinal.txt"

cat $INPUT_FILE | while read line_input
do
    [[ $line_input = \#* ]] && continue
    echo $line_input
    cat $LIST | while read line
    do
	name=$(echo $line | awk '{ print $1}')
	label=$(echo $line | awk '{ print $2}')
	xsec=$(echo $line | awk '{ print $3}')
	echo $name", "$label", "$xsec
	new_line_input_1=${line_input/sig_NAME/$name}
	new_line_input_2=${new_line_input_1/sig_LABEL/$label}
	new_line_input_3=${new_line_input_2/sig_LABEL/$label}
	new_line_input=${new_line_input_3/sig_XSEC/$xsec}
	echo $new_line_input >> $OUTPUT_FILE
    done
    echo "#======= " >> $OUTPUT_FILE
done

#cat mca-2los-test2-mcdata-mcfakes_template.txt $OUTPUT_FILE >> $OUTPUT_MCA_MCDATA
#cat mca-2los-test2-mcdata-frdata_template.txt  $OUTPUT_FILE >> $OUTPUT_MCA_FRDATA 