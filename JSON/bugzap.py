#!/usr/bin/python
import json
import pandas
from collections import defaultdict
from random import shuffle
import numpy as np

Rc = {
  "type" : "blackout",
  "frogColor" : "green",
  "frogSide" : "right",
  "rotation" : "0deg",
  "rightBug" : "green",
  "leftBug" : "blue",
  "rightSpotlight" : "true",
  "leftSpotlight" : "false"
}

Lc = {
  "type" : "blackout",
  "frogColor" : "blue",
  "frogSide" : "left",
  "rotation" : "180deg",
  "rightBug" : "green",
  "leftBug" : "blue",
  "rightSpotlight" : "false",
  "leftSpotlight" : "true"
}

Li = {
  "type" : "blackout",
  "frogColor" : "blue",
  "frogSide" : "left",
  "rotation" : "180deg",
  "rightBug" : "green",
  "leftBug" : "blue",
  "rightSpotlight" : "true",
  "leftSpotlight" : "false"
}

Ri = {
  "type" : "blackout",
  "frogColor" : "green",
  "frogSide" : "right",
  "rotation" : "0deg",
  "rightBug" : "green",
  "leftBug" : "blue",
  "rightSpotlight" : "false",
  "leftSpotlight" : "true"
}

items = list(np.repeat([Rc,Lc,Ri,Li],6))
shuffle(items)

fp = open('bugzap2.json', 'w+')
json.dump(items,fp)
fp.close()