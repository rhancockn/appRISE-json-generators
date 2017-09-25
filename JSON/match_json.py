import json
import pandas
from collections import defaultdict
from random import shuffle
import numpy as np

colors = ['RED', 'BLUE', 'GREEN', 'YELLOW']
shapes = ['CAN', 'FRUIT', 'GRASS']
creatures = ['GOAT', 'BIRD', 'DOG']
idx=[0,1,2]
trials = []

trial_types=['s',  's',  's',  's',  's',  's',  'c',  'c',  'c',  'c',  'c',  'c',   's', 'c',  'c',  's', 'c', 's',  's',  'c',  'c',   's',  'c',  's']

for t in trial_types:
	shuffle(colors)
	shuffle(idx)
	correctSelection = shapes[idx[0]] + '_' + colors[idx[0]]
	foil = shapes[idx[1]] + '_' + colors[idx[1]]
	location = [0,1]
	signs = [correctSelection, foil]
	shuffle(location)
	signs=[signs[location[0]]] + [signs[location[1]]]
	
	#shape
	if t == 's':
		characterName = creatures[idx[0]]
		
		thought = shapes[idx[0]]
		
	#color
	elif t == 'c':
		characterName = colors[idx[0]] + '_MONSTER'
		thought = colors[idx[0]]

	
	d={"characterName" : characterName, "correctSelection": correctSelection, "correctLocation": location[0], "thought" :  thought, "leftSign" : signs[0], "rightSign": signs[1]}
	trials.append(d)

fp=open('match.json', 'w+')
json.dump(trials, fp)
fp.close()
