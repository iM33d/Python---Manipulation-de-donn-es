import time, sys
import os
import shutil


Creation d'un fichier copie
fname = './copy'
with open(fname, 'a'):
	try:
	  os.utime(fname, None)
	except OSError:
	  pass

fname = './copy2'
with open(fname, 'a'):
        try:
        os.utime(fname, None)
	except OSError:
	pass


#Copie du contenu du fichier de depart dans copy
from shutil import copyfile
copyfile(sys.argv[1],'copy')


#Suppression de la premiere ligne
with open('copy', 'r') as fin:
    data = fin.read().splitlines(True)
with open('copy', 'w') as fout:
    fout.writelines(data[1:]) 


#Split du premier champ avant les :
with open('copy', 'r+') as file:
	for line in file:
		sys.stdout = file
		sys.stdout.write(line.split(':')[1])
		sys.stdout.flush()
#		print >>file, line.split(':')[1]


