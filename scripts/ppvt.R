library(imager)
agreement_threshold <- .75
familiarity_threshold <- 4
aoa<-read.csv('data/AoA_ratings_Kuperman_et_al_BRM.csv')
imgs<-read.csv('data/BOSS/imagenames.csv')
ratings<-read.csv('data/BOSS/ratings.csv')
ratings<-subset(ratings, FHrejected==0)
recordings<-read.table('data/recordings.txt')
recording_words<-sub('_word.wav','', recordings$V1)

#bin AoA
cuts<-seq(3,16,by=.5)
aoa$agebin<-cut(aoa$Rating.Mean,cuts)
smallcuts<-c(seq(3,6.9,by=.25),seq(7,16,by=.5))
aoa$agebin_small<-cut(aoa$Rating.Mean,smallcuts)

#merge data
imgs<-merge(imgs,aoa,by.y='Word', by.x='word')
imgs<-merge(imgs,ratings,by.x='filename',by.y='Filename.English')
imgs$usage<-0
imgs$target<-0

#set target=1 for any words that don't have an audio asset so that they don't get selected
imgs$target<-!(imgs$word %in% recording_words)


#need large bins for enough items
ppvt<-data.frame(aoa_bin=factor(levels=levels(aoa$agebin)), filename=factor(levels=levels(imgs$filename)), word=factor(levels=levels(imgs$word)))
ppvt$filler1.filename<-ppvt$filename
ppvt$filler1.word<-ppvt$word
ppvt$filler2.filename<-ppvt$filename
ppvt$filler2.word<-ppvt$word
ppvt$filler3.filename<-ppvt$filename
ppvt$filler3.word<-ppvt$word

for (age in levels(imgs$agebin)) {
	possible_imgs<-subset(imgs, (Modal.name.agreement.... >= agreement_threshold) & (agebin == age)  )
	
	#for each age bin, select items with high agreement
	#while possible targets (with high agreement) and fillers (ignoring agreement) remain
	#use images up to twice
	while( (sum(possible_imgs$target==0)>=1) & (sum(possible_imgs$usage < 2) >=3) ) {
		poss_targets=which(possible_imgs$target==0)
		if (length(poss_targets)>1) {
			target_i<-sample(poss_targets,1)
		}
		else {
			target_i=poss_targets
		}
		filler_i<-sample(setdiff(which(possible_imgs$usage < 2),target_i),3)
		
		d<-data.frame(aoa_bin=age, filename=possible_imgs$filename[target_i], word=possible_imgs$word[target_i], filler1.filename=possible_imgs$filename[filler_i[1]], filler1.word=possible_imgs$word[filler_i[1]], filler2.filename=possible_imgs$filename[filler_i[2]], filler2.word=possible_imgs$word[filler_i[2]], filler3.filename=possible_imgs$filename[filler_i[3]], filler3.word=possible_imgs$word[filler_i[3]])
		ppvt<-rbind(ppvt,d)
		possible_imgs$target[target_i]<-1
		possible_imgs$usage[c(target_i,filler_i)]<-possible_imgs$usage[c(target_i,filler_i)]+1
		
	}
}

ppvt$trial<-1:dim(ppvt)[1]
ppvt$set<-as.numeric(ppvt$aoa_bin)
write.csv(ppvt, 'generated/ppvt/ppvt.csv')


