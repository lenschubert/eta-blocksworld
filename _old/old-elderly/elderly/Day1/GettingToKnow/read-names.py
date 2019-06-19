
"""
Created on Tue Jun 06 19:34:17 2017

@author: Dr Razavi
"""
# in the current wd there should be a folder named \dataTxtFiles in which there
# are different folders each belongs to one annotator.
# The program extracts Silence information from all files in the first expert's
# folder, then add labels from other's folders to that. At the end the output
# will be guided into a output file which is located in the wd and it's name
# should be given as the input when you call the python file
#

# Note: the corresponding files which in different expert's folders (ones that should
# be merged) must have the exact same names

#
#  To load the file type:
# python file.txt
#

import sys
import re

def readNames(input_file, output_file):
    with open(input_file) as f:
    	content = f.read()
    name_vector = re.findall(r'[a-zA-Z]+', content)
    # you may also want to remove whitespace characters like `\n` at the end of each line
    with open(output_file,'w+') as g:
    	for item in name_vector:
      		g.write("%s " % item) 
   #print w[0:10]
    g.close()
    f.close()


def main():
    readNames(sys.argv[1],sys.argv[2])

if __name__ == '__main__':
    main()


