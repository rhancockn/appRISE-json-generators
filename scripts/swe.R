nwords<-5 #number of words per bin

aoa<-read.csv('data/AoA_ratings_Kuperman_et_al_BRM.csv')
cuts<-seq(3,16,by=.5)
aoa$agebin<-cut(aoa$Rating.Mean,cuts)
smallcuts<-c(seq(3,6.9,by=.25),seq(7,16,by=.5))
aoa$agebin_small<-cut(aoa$Rating.Mean,smallcuts)
aoa$logfreq<- log10(as.numeric(as.character(aoa$Freq_pm)))
freqcuts<-seq(0,6,by=1)
aoa$freqbin<-cut(aoa$logfreq,freqcuts)
aoa$Word<-as.character(aoa$Word)
aoa$wordlen<-nchar(aoa$Word)
consonants<-c('b','c','d','f','g','h','j','k','l','m','n','p','q','r','s','t','v','x','z')
vowels<-c('a','e','i','o','u')
cvcs<-c()
for(c1 in consonants) {
	for(v in vowels) {
		for(c2 in consonants) {
			cvcs<-c(cvcs,sprintf('%s%s%s',c1,v,c2))
		}
	}
}

aoa$cvc<-((aoa$Word %in% cvcs) & (aoa$wordlen==3))
aoa$bin<-interaction(aoa$agebin,aoa$freqbin,aoa$wordlen)
write.csv(subset(aoa,cvc & logfreq >=0), 'generated/swe/cvcall.csv')

aoa<-subset(aoa, logfreq>=3)

df.words<-NULL
df.cvc<-NULL

for(b in unique(aoa$bin)) {
	w<-which(aoa$bin==b & aoa$cvc)
	if(length(w)>0) {
		i<-sample(w,min(nwords, length(w)))
		df.cvc<-rbind(df.cvc,aoa[i,])
	}
	
	w<-which(aoa$bin==b & !aoa$cvc)
	if(length(w)>0) {
		i<-sample(w,min(nwords,length(w)))
		df.words<-rbind(df.words,aoa[i,])
	}
}

write.csv(df.words, 'generated/swe/words.csv')
write.csv(df.cvc, 'generated/swe/cvc.csv')
