set THIS_DIR=%1

cd %THIS_DIR%
dir /b /s *.tif > tiff_list.txt
REM Builds a VRT. A VRT is basically just a XML file saying what all the source tif files are.
gdalbuildvrt -srcnodata 255 -vrtnodata 255 -a_srs EPSG:27700 -input_file_list tiff_list.txt %THIS_DIR%.vrt

 

REM This is what actually does the mosaicing.
gdal_translate -of GTiff -co TILED=YES -co BIGTIFF=YES -co COMPRESS=JPEG -co JPEG_QUALITY=80 -co BLOCKXSIZE=512 -co BLOCKYSIZE=512 -co PHOTOMETRIC=YCBCR %THIS_DIR%.vrt %THIS_DIR%.tif
Echo "Created"

REM Now creating pyramids.
gdaladdo %THIS_DIR%.tif -r average --config COMPRESS_OVERVIEW JPEG --config JPEG_QUALITY_OVERVIEW 60 --config INTERLEAVE_OVERVIEW PIXEL --config PHOTOMETRIC_OVERVIEW YCBCR 2 4 8 16 32 64 128 256 512
Echo "Tiled"
cd ..