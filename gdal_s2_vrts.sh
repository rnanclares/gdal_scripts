#!/bin/bash

for imagen in *.zip; do
  echo "$imagen"
  #vzip = '/vsizip//'
  unzip -Z -1 $imagen | grep -E B.._10m.jp2$ | sort | sed -e 's\^\/vsizip//'"$PWD/$(basename $imagen)"'/\' > bandList.txt
  gdalbuildvrt -resolution average -separate -r nearest -input_file_list bandList.txt "$(basename "$imagen" .zip)"_10m.vrt
  unzip -Z -1 $imagen | grep -E B0._20m.jp2$ | sort | sed -e 's\^\/vsizip//'"$PWD/$(basename $imagen)"'/\' > bandList20m.txt
  unzip -Z -1 $imagen | grep -E B8A_20m.jp2$ | sort | sed -e 's\^\/vsizip//'"$PWD/$(basename $imagen)"'/\' >> bandList20m.txt
  unzip -Z -1 $imagen | grep -E B1._20m.jp2$ | sort | sed -e 's\^\/vsizip//'"$PWD/$(basename $imagen)"'/\' >> bandList20m.txt
  gdalbuildvrt -resolution average -separate -r nearest -input_file_list bandList20m.txt "$(basename "$imagen" .zip)"_20m.vrt
  rm bandList*
done


