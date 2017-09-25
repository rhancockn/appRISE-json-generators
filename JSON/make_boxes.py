#!/usr/bin/python
#generate random letter name and letter sound JSON for the boxes game
#include a,b,c as practice trials for each

import json
import pandas
from collections import defaultdict
from random import shuffle
import numpy as np
import copy

#letters sorted by frequency as the first letter of a word
first_letters=[ 't', 'o', 'i', 's', 'w', 'p', 'h', 'f', 'm', 'd', 'r', 'e', 'l', 'n', 'g', 'u', 'v', 'y', 'j', 'k', 'q', 'x', 'z']

#letters sorted by overall frequency
frequent_letters=[ 'e', 't', 'o', 'i', 'n', 's', 'h', 'r', 'd', 'l', 'u', 'm', 'w', 'f', 'g', 'y', 'p', 'v', 'k', 'j', 'x', 'q', 'z']


def make_item(l, letters, suffix):

	stimuliImage = 'Letter_' + l.upper()
	correct = l + '_' + suffix
	

	foils = [x for x in letters if x !=l ]
	shuffle(foils)

	audio = foils[0:3] + [l]
	shuffle(audio)
	audio = [x + '_' + suffix + '.wav' for x in audio]

	item = {"stimuliImage" : stimuliImage, "stimuliAudio" : "false", "stimuliAudioFile" : '', "correct" : correct, "boxAudioFiles":audio }

	return(item)


def make_sets(letters, suffix):
	sets = []
	s = 2
	items = []

	for l in ['a', 'b', 'c']:
		items.append(make_item(l, letters+['a','b','c'], suffix))
	
	sets.append({1: items})

	items = []
	for i in range(len(letters)):
		items.append(make_item(letters[i], letters+['a','b','c'], suffix))
		
		if ((i+1) % 6) == 0:
			sets.append({s: items})
			s = s+1
			items = []


	s = s+1
	sets.append({s: items})

	return(sets)


letter_name = make_sets(first_letters, 'name')
letter_sound = make_sets(frequent_letters, 'sound')

d = {"letter_name" : letter_name, "letter_sound" : letter_sound}

fp = open('boxes.json', 'w+')
json.dump(d,fp)
fp.close()



