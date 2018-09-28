#!/bin/bash

export vect_path='FFP_CADASTRE_FORET_4326.shp'
export rast_path='SDC_forest_2013_2017_4326.tif'

# Get population extent and resolution
meta=`gdalinfo ${rast_path} | grep 'Pixel Size' | sed 's/Pixel Size = //g' | sed 's/(//g' | sed 's/)//g' | sed 's/ - /, /g'`
rez=`echo ${meta}| awk -F ',' '{print $1}'`
meta=`gdalinfo ${rast_path} | grep 'Lower Left' | sed 's/Lower Left  (//g' |  sed 's/) (/,/g'`
w=`echo ${meta}| awk -F ',' '{print $1}'`
s=`echo ${meta}| awk -F ',' '{print $2}'`
meta=`gdalinfo ${rast_path} | grep 'Upper Right' | sed 's/Upper Right (//g' |  sed 's/) (/,/g'`
e=`echo ${meta}| awk -F ',' '{print $1}'`
n=`echo ${meta}| awk -F ',' '{print $2}'`
#echo "${w} ${e} ${s} ${n} ${rez}"

# rasterize with default options
gdal_rasterize -burn 1 -tr ${rez} ${rez} -a_nodata 0 -te ${w} ${s} ${e} ${n} -ot Byte -of GTiff -co COMPRESS=LZW ${vect_path} ${vect_path%%.*}.tif

# rasterize with "all touched" option
gdal_rasterize -at -burn 1 -tr ${rez} ${rez} -a_nodata 0 -te ${w} ${s} ${e} ${n} -ot Byte -of GTiff -co COMPRESS=LZW ${vect_path} ${vect_path%%.*}_alltouched.tif
