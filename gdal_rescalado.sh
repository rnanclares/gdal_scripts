#!/bin/bash
for imagen in ./tif/*.tif; do
  echo "$imagen"
  echo "$(basename -- $imagen)"
  echo $(basename "$imagen" .tif)
  
 gdal_translate -co COMPRESS=DEFLATE -co ZLEVEL=9 -co PREDICTOR=2 -co TILED=YES -scale 0 255 1 255 $imagen ./rescalados/"$(basename "$imagen" .tif)"_rescale.tif
done
