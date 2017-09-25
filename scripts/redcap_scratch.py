import dpath.util
import json
fp=open('/Users/rhancock/Downloads/apptest.json')
data = json.load(fp)
sections = dpath.util.values(data, "value/*/value/section_ID")

section_counts = {}

mappings = {'Bubble_Game' : 'bubble', 'Claw Game' : 'claw', 'Machine Game' : 'button', 'Match_by_Shape/Match_by_Color' : 'match', 'Matrix_Reasoning': 'matrix', 'Symbol_Digit_Coding': 'coding', 'Unlock_Food': 'unlock'}

for k in sections:
	if k in mappings.keys():
		section_counts[mappings[k]] = sections.count(k)


x=dpath.util.values(data, "value/*/value")
df=pd.DataFrame(x)
g=df.groupby(df.section_ID)

dpath.util.values(data, "*/*/audioFile")