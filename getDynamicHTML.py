#!/usr/bin/python
#
# This script grabs the HTML of a dynamically rendered webpage from the NASA website. Each page corresponds to
# a different sol from the mars rover raw images archive
# Usage: python getDynamicHTML.py <starting sol number> <ending sol number>
# Example: python getDynamicHTML.py 1 5 will create five different HTML files each containing the
# HTML from Sols 1 through 5

import sys

from selenium import webdriver  
import time  

# Opening a browser using selenium
browser = webdriver.Chrome('/Users/ire/Desktop/chromedriver') 
print "Browser open..."

solStart = int(sys.argv[1])  
solEnd = int(sys.argv[2])

# Looping through the starting to ending sol
for i in xrange(solStart,solEnd):
	# Accessing a webpage for a specific sol
	browser.get('http://mars.jpl.nasa.gov/msl/multimedia/raw/?s=839#/?slide=%s' % i) 
	time.sleep(4)
	print ("Getting Sol number %s..." % i)

	# Finds the sol number embedded in the HTML
	solNum = browser.find_element_by_class_name('TotalRawImagesNote')
	solNumHTML = solNum.get_attribute('innerHTML')

	# Checks to see whether the HTML sol number corresponds to our counter. 
	# Some sols contain no pictures (i.e. there is not webpage for sole #5)
	if ("Total for Sol " + str(i)) in solNumHTML:
		element = browser.find_element_by_css_selector('#listImagesContent')
		elementHTML = element.get_attribute('innerHTML')

		# Write the HTML to a file
		f = open('index.%s.html' % i, 'w')
		f.write(elementHTML) 
		print ("...wrote Sol %s to file" % i)
	else:
		print ("---No Sol %s---" %i)

browser.quit() 
print "Complete"