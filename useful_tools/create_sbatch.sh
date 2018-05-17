#!/bin/bash 

if [ "$1" == "-h" ] ; then
    echo ""
    echo "####################################################"
    echo "This script replaces lines in a template file (submit_template.sh) and create a workspace for the jobs submission."  
    echo "You need to specify/have:"  
    echo "- a template file 'submit_template.sh' in the directory where you are executing the script"
    echo "- a python executable file in your working directory" 
    echo "- a set of inputs for your jobs, meaning: model, partition (CPU or GPU), memory, input data folder, test dataset, nr. nodes for the ML algorithm."    
    echo "By invoking this script you will create a workspace with files having the righ formatting for the submission on sbatch system."
    echo "Author: roberto.castello@epfl.ch"
    echo "Date: 19/03/2018 "
    echo "####################################################"
    echo ""
  exit 0
fi

## STATIC inputs #####################################

TEMPLATE_FILE="submit_template.sh"
GPU_syntax="#SBATCH --partition=gpu --qos=gpu_free --gres=gpu:2"

######################################################
## CUSTOMIZABLE inputs ###############################
######################################################

MAIL="roberto.castello@epfl.ch"
CORES="1"
TIME="00:30:00" #set the maximum time in the format XX:YY:ZZ
VIRTUALENV="hyenergy_py3" ## your virtual env name
MEM="4G"  ## memory requirment for the node

MODEL="ELM" ## ML model name
PYTHON_EXECUTABLE="ELM_uncertainties_query" # becomes [..]_query.py or [..]_train.py or [..].py

MYDIR="energy-potential/Solar" # path should start from home
SCRATCHDIR="/scratch/rcastell" ## your scratch
DATADIR="\/scratch\/rcastell" ## --> needed for the different syntax N.B. it is enough to put your scratch location (modulo a dataset/ folder is existing) 

## Arrays 
PART_VEC=( "GPU" ) ## Partition: "CPU" or "GPU" or both
DATA_VEC=( "2012-2012_grid100_SIS" ) ## Dataset name
QUERY_VEC=( "grid1600" ) ## Query name
NODE_VEC=( "200" ) ## nr. nodes of ELM
EST_VEC=( "2" "5" "10" ) ## nr. estimators for the ensamble

######################################################
######################################################

for DATA in ${DATA_VEC[@]}
do
    echo "[MSG] Creating workspace for the dataset $DATA"
    echo ""
    ## == Creating dir if not already existing and copying the python executable into it

    if [ ! -d  $SCRATCHDIR\/workspace_$MODEL\_$DATA ]
    then
	mkdir $SCRATCHDIR\/workspace_$MODEL\_$DATA
	mkdir $SCRATCHDIR\/workspace_$MODEL\_$DATA\/output
    fi

    ## == Copying the python executable in the folder                                                                                                                                                         
    cp $HOME\/$MYDIR\/$PYTHON_EXECUTABLE.py $SCRATCHDIR\/workspace_$MODEL\_$DATA\/.

    ## == Printing lines of the template (can be skipped)
    #cat $TEMPLATE_FILE | while read line_input
    #do
    #    [[ $line_input = \#\#* ]] && continue
    #    echo $line_input
    #done

    for QUERY in ${QUERY_VEC[@]}
    do
	for PART in ${PART_VEC[@]}
	do
	    for NODE in ${NODE_VEC[@]}
	    do
		for EST in ${EST_VEC[@]}
		do
		    echo "..."
		    cp $TEMPLATE_FILE $SCRATCHDIR\/workspace_$MODEL\_$DATA\/.
		    
		    ## == Replacing the custom choice in a temporary file
		    sed -i "s/\_mem/$MEM/g"                  $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$TEMPLATE_FILE 
		    sed -i "s/\_time/$TIME/g"                $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$TEMPLATE_FILE 
		    sed -i "s/\_cores/$CORES/g"              $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$TEMPLATE_FILE 
		    sed -i "s/\_mail/$MAIL/g"                $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$TEMPLATE_FILE 
		    sed -i "s/\_virtenv/$VIRTUALENV/g"       $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$TEMPLATE_FILE
		    sed -i "s/\_datadir/$DATADIR/g"          $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$TEMPLATE_FILE
		    sed -i "s/\_model/$MODEL/g"              $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$TEMPLATE_FILE
		    sed -i "s/\_python/$PYTHON_EXECUTABLE/g" $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$TEMPLATE_FILE
		    sed -i "s/\_dataset/$DATA/g"             $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$TEMPLATE_FILE
		    sed -i "s/\_accel/$PART/g"               $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$TEMPLATE_FILE
		    sed -i "s/\_qry/$QUERY/g"                $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$TEMPLATE_FILE
		    sed -i "s/\_estimators/$EST/g"           $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$TEMPLATE_FILE
		    sed -i "s/\_node/$NODE/g"                $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$TEMPLATE_FILE
		    echo ".."  
		
		    ## == Adding the GPU syntax (if needed)
		    if [ $PART == GPU ] 
		    then
		    	sed -i "s/\_part/$GPU_syntax/" $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$TEMPLATE_FILE
		    else
		    	sed -i 's/\_part/\#\#/' $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$TEMPLATE_FILE
		    fi
	    
		    ## == customizing for train or validation ==
		    if [[ $PYTHON_EXECUTABLE == ELM_*_train ]]
		    then
		    	cp $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$TEMPLATE_FILE  $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$MODEL\_$PART\_N$NODE\_E$EST\_TRN.sh
		    elif [[ $PYTHON_EXECUTABLE == ELM_*_query ]]
		    then
		    	cp $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$TEMPLATE_FILE  $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$MODEL\_$PART\_N$NODE\_E$EST\_$QUERY\_QRY\.sh
		    elif [[ $PYTHON_EXECUTABLE == RF_* ]]
                    then
                        cp $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$TEMPLATE_FILE  $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$MODEL\_$PART\_N$NODE\_E$EST\_$QUERY\.sh		    
		    else
		    	echo "[WARNING] The python file you are trying to execute is not recognized"
		    fi
	    
		    ## == Cleaning
		    rm $SCRATCHDIR\/workspace_$MODEL\_$DATA\/$TEMPLATE_FILE
		    echo "."
		    echo ""  
		done
	    done
	done
    done
## == Creating a script (run.sh) in the workspace for the sbatch submission (N.B. not executing, just creating)

cd  $SCRATCHDIR\/workspace_$MODEL\_$DATA\/
suffix=".sh"

if [ ! -f runAll.sh ]; then
    echo "#!/bin/bash" >> runAll.sh
    chmod +x runAll.sh
    for f in ./*_*.sh; do
        name=$(basename "$f")
        echo "sbatch -J" ${name%$suffix} $name >> runAll.sh
    done
else
    for f in ./*_*.sh; do
        exist=false
        name=$(basename "$f")

        while IFS= read -r line; do
            if [[ $line == *"$name" ]] ; then
                exist=true
            fi
        done < runAll.sh   
        if [ $exist == false ]; then  
            echo "sbatch -J" ${name%$suffix} $name >> runAll.sh    
        fi
    done
fi

cd ../

## ==  Terminating

echo "[DONE] The files and relative scripts for the submission on batch queues have been created inside "$SCRATCHDIR"/workspace_"$MODEL"_"$DATA"/" 
done
