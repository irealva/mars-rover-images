mars-rover-images
=================

getPics.sh is a script that downloads raw images from the Mars Curiosity Rover archive. The images are organized by Sol, which refers to a Martian solar day. 
The archive can be found here: http://mars.jpl.nasa.gov/msl/multimedia/raw/?s=#/?slide=845

Use
-------
getPics.sh is the main program, but it calls on getDynamicHTML.py to retrieve a dynamically rendered HTML page for each Sol.

To run the script:
  sh getPics.sh <starting sol number> <ending sol number>
  
Example - getting all images from Sol #1 to Sol #6:
  sh getPics.sh 1 6

Output
-------
A folder for each sol containing all the full size raw images available in the NASA archive. 

NASA Image Policy
-------
Go to: http://www.jpl.nasa.gov/imagepolicy/




