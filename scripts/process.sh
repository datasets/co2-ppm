#!/bin/bash

#Mauna Loa monthly data
files[0]='co2_mm_mlo.txt'
headers[0]='Year,Month,Decimal Date,Average,Interpolated,Trend,Number of Days'
# Mauna Loa annual data
files[1]='co2_annmean_mlo.txt'
headers[1]='Year,Mean,Uncertainty'
#Mauna Loa growth rate data
files[2]='co2_gr_mlo.txt'
headers[2]='Year,Annual Increase,Uncertainty'
# global monthly data
files[3]='co2_mm_gl.txt'
headers[3]='Year,Month,Decimal Date,Average,Trend'
#global annual data
files[4]='co2_annmean_gl.txt'
headers[4]='Year,Mean,Uncertainty'
#global growth rate data
files[5]='co2_gr_gl.txt'
headers[5]='Year,Annual Increase,Uncertainty'

rename () {
  echo $1 | \
    # replace underscores with dashes
    sed 's/_/-/g' | \
    # replace txt extension with csv
    sed 's/\.txt$/.csv/'
}

write_header () {
  # write the header to the output file
  echo $1 > $2
}

write_content () {
  cat $1 | \
    # delete note at top
    sed '/^#/ d' | \
    # remove leading whitespace
    sed 's/^[ ][ ]*//' | \
    # replace whitespace with commas
    sed 's/[ ][ ]*/,/g' \
    >> $2
}

mkdir -p archive
mkdir -p data

for index in "${!files[@]}"; do
  file="${files[$index]}"
  header="${headers[$index]}"
  # curl ftp://aftp.cmdl.noaa.gov/products/trends/co2/$file > archive/$file
  output=`rename $file`
  write_header "${header}" data/$output
  write_content archive/$file data/$output
done
