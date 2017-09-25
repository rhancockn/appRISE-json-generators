#!/usr/bin/python
#this script is only useful for resizing sets from the original JSON file
import json
fp=open('/Users/rhancock/playgroundJSON/games/unlockFoodTrials.json')
j=json.load(fp)
fp.close()

unlock = {}

for k in j.keys():
	s2 = 2
	items =[]
	for l in range(len(j[k])):
		for s in j[k][l].keys():
			items.append( {int(s2): j[k][l][s][0:3]})
			s2 = s2 + 1
			print(s2)
			items.append( {int(s2): j[k][l][s][3:6]})
			s2 = s2 + 1
	unlock[k] = items

fp=open('unlock.json', 'w+')
json.dump(unlock, fp)
fp.close()

