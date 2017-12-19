import json
import pandas
from collections import defaultdict
from random import shuffle
import sys
#dfall = pandas.read_csv("/Users/rhancock/Box Sync/brainLENS_sync/iPadScreener/LiteracyStimuli/generated/ppvt/ppvt.csv")
dfall = pandas.read_csv(sys.argv[1])


vocab = []
bins =dfall.set.unique()

for b in bins:
	df = dfall[dfall.set==b]
	df = df.reset_index(drop=True)

	trials = []
	for i in range(df.shape[0]):
		trial_dict={"activeCells": ["true", "true", "true", "true"], "numCOlumns" : "2", "numRows" : "2"}
		trial_dict["correct"] = df.word[i] + "_word.jpg"
		trial_dict["audioFile"] = df.word[i] + "_word.wav"

		animations = [df.word[i], df['filler1.word'][i], df['filler2.word'][i], df['filler3.word'][i]]
		shuffle(animations)
		animations=[x + "_word.jpg" for x in animations]
		trial_dict["animationKeys"] = animations

		trials.append(trial_dict)


	vocab.append({b:trials})


dict = {"receptive_vocabulary": vocab}
fp=open('ppvt.json', 'w+')
json.dump(dict, fp)
fp.close()
