#!/bin/bash 

suffix=".sh"

if [ ! -f runAll.sh ]; then
    echo "#!/bin/bash" >> runAll.sh
    chmod +x runAll.sh
    for f in ./file_*.sh; do
	name=$(basename "$f")
	echo "sbatch -J" ${name%$suffix} $name >> runAll.sh
    done
else
    for f in ./file_*.sh; do
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
