#!/bin/bash

## ====== Settings

#SBATCH --nodes 1
## --> nr. nodes is >1 for MPI

## specific for GPU nodes (free account)
_part

#SBATCH --mem _mem
#SBATCH --ntasks 1
#SBATCH --cpus-per-task _cores
#SBATCH --time _time

#SBATCH --workdir ./output
#SBATCH --mail-type=ALL
#SBATCH --mail-user=_mail

echo STARTING AT $(date)

## ====== Specify here the needed modules 

module purge 
module load gcc cuda python/3.6.1
#module load netcdf/4.4.1.1
source activate _virtenv

## ===== Specify here the commands to execute 

## Convert the jupyter notebook in python
#jupyter nbconvert --to=python _python.ipynb

## Run. Argument to pass (in order): data location, dataset name, query name, #estimators, # nodes, partition (CPU or GPU) 
python $SCRATCH/workspace__model__dataset/_python.py _datadir _dataset _qry _estimators _node _accel

source deactivate

echo FINISHED AT $(date)
