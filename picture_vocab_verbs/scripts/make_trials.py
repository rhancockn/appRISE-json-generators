#!/usr/bin/env python
import pandas
import numpy as np
import os
import glob
verbs = pandas.read_excel('../VerbsDB1.2/VerbsDatabaseRuEng 1.2.xlsx')
verbs=verbs[verbs['agree.pct']>75]
verbs=verbs[verbs['reject']!=1]

from nltk.corpus import wordnet as wn
wn.ensure_loaded()

words = []
synsets = []
imageability = []

for i,row in verbs.iterrows():
	w = row['root_en']
	imgno = row['imgno']
	w_synsets = wn.synsets(w,wn.VERB)
	if len(w_synsets)>0:
		words.append(w)
		imageability.append(row['imageabilitymean'])
		synsets.append(w_synsets[0])
		f=glob.glob('../VerbsDB1.2/Pictures/cropped/resized/%d. *.jpg' % imgno)
		if len(f)>0:
			os.rename(f[0], '../VerbsDB1.2/Pictures/cropped/resized/%s.jpg' % w)

#sort by imageability
idx = np.argsort(-1.0*np.array(imageability))
words=[words[i] for i in idx]
synsets=[synsets[i] for i in idx]
#calculate the distance between each word
dist = np.zeros((len(words),len(words)))
for i in range(len(words)):
	for j in range(len(words)):
	 dist[i,j]=wn.path_similarity(synsets[i],synsets[j])

#make pairs
d=[]
block = 0
words_seen=[]
for i in range(len(words)):
	if i%6 == 0:
		block=block+1
	
	ind = np.argpartition(-1.0*dist[i,:],4)

	if words[ind[0]] not in words_seen:
		words_seen.append(words[ind[0]])
		d.append({'filename':words[ind[0]] + '.jpg', 
			'word':words[ind[0]],
			'filler1.filename':words[ind[1]] + '.jpg',
			'filler1.word':words[ind[1]],
			'filler2.filename':words[ind[2]] + '.jpg',
			'filler2.word':words[ind[2]],
			'filler3.filename':words[ind[3]] + '.jpg',
			'filler3.word':words[ind[3]],
			'set':block
			})
	

df=pandas.DataFrame(d)
df.to_csv('ppvt.csv')


