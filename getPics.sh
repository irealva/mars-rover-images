#!/bin/sh
#
# This script grabs mars rover rawimages from the NASA website 
# Usage: ./getPics <starting sol number> <ending sol number>
# Example: ./MSLget.sh 1 5 will grab all images from sol 1 through 5

SOL=$1
END_SOL=$2

echo "Starting SOL is" $SOL
echo "Ending SOL is" $END_SOL

# Python script to create an HTML file with the dynamically rendered webpage containing the mars rover pictures
# The HTML contains the file names for the pictures
python getDynamicHTML.py ${SOL} ${END_SOL}

while (( ${SOL} <= ${END_SOL} ))
do
	if [ -f index.${SOL}.html ] 
	then
		# Creates a text file with all the images found on the HTML file
		cat index.${SOL}.html | grep msl-raw-images | awk -F\<img\ src=\" '{ print $2 }' | awk -F\" '{ print $1 }' | sort | uniq > images.${SOL}.1.txt  
		
		# Creates another text file containing only the larger images
		# These are the ones without thm.jpg in the name and the ones that contain "_F" in the name
		grep thm\.jpg images.${SOL}.1.txt | awk -F\-thm.jpg '{ print $1".JPG" }' >> images.${SOL}.2.txt
		cat images.${SOL}.2.txt | grep _F >> images.${SOL}.3.txt

		echo "Found images for Sol" $SOL

		((SOL=SOL+1))
	else
		((SOL=SOL+1))
	fi
done

echo "----Done creating text files of image lists----"

SOL=$1
END_SOL=$2

# The following code downloads the images
while (( ${SOL} <= ${END_SOL} ))
do
	if [ -f images.${SOL}.3.txt ]
	then
		# Download images
		wget -nc --directory-prefix=images.${SOL} -i images.${SOL}.3.txt 
		echo "Downloaded images for SOL" $SOL
		((SOL=SOL+1))
	else
		((SOL=SOL+1))
	fi
done

echo "----Done with download----"

mkdir html
mv *.html html

mkdir txt
mv *.txt txt


