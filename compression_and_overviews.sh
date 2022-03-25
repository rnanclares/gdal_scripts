#!/bin/bash

for imagen in *.tif; do
  echo "$imagen"
  gdal_translate -co COMPRESS=DEFLATE -co ZLEVEL=9 -co PREDICTOR=2 -co TILED=YES $imagen "$(basename "$imagen" .tif)"_comp.tif
  gdaladdo -minsize 256 --config COMPRESS_OVERVIEW DEFLATE --config INTERLEAVE_OVERVIEW PIXEL --config GDAL_NUM_THREADS ALL_CPUS -r average "(basename "$imagen" .tif)"_comp.tif
done
