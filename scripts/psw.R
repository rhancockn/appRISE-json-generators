confusable<-list(c('b','d','p','f'),c('n','m'),c('d','t'), c('a','o','e','i','u'), c('g','h'), c('l','r'))

df.all<-NULL

for (f in dir(path='data/MRC',pattern='psw.*.txt',full.names=TRUE)) {
	df<-NULL
	
	psws<-read.table(f,header=TRUE)
	psws$STRING<-as.character(psws$STRING)
	for (w in psws$STRING) {
		chars<-strsplit(w,'')[[1]]
		foils<-c()
		k<-0
		while(length(foils)<3 & k<100) {
			new_chars<-chars
			for(i in 1:floor(runif(1,1,length(confusable)))) {
				alts<-sample(confusable,1)[[1]]
				in_alts<-which((new_chars %in% alts))
				if(length(in_alts)>1) {
					new_chars[sample(in_alts,1)]<-sample(alts,1)
				}
				if(length(in_alts)==1) {
					new_chars[in_alts]<-sample(alts,1)
				}
				k<-k+1
			}
			foils<-unique(c(foils, paste(new_chars,collapse='')))
		}
		if(length(unique(c(foils,w)))==4) {
			df<-rbind(df,c(w,foils))
		}
		
	}
	df<-df[sample.int(dim(df)[1]),]
	df<-as.data.frame(df)
	colnames(df)<-c('target','filler1','filler2','filler3')
	df$model<-basename(f)
	df.all<-rbind(df.all,df)
	
	#less phonologically confusable 
	psws<-psws[sample.int(dim(psws)[1]),]
	psws<-subset(psws,!(STRING %in% df$target))
	df2<-NULL
	for(i in seq(1,dim(psws)[1],by=4)) {
		df2<-rbind(df2,c(psws$STRING[i:(i+3)]))
	}
	df2<-as.data.frame(df2)
	colnames(df2)<-c('target','filler1','filler2','filler3')
	df2$model<-paste('r',basename(f),sep='_')
	df.all<-rbind(df.all,df2)


	
}

write.csv(df.all, 'generated/psw/psw.csv')
