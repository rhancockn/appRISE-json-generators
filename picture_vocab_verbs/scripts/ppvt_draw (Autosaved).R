library(imager)
ppvt<-read.csv('verbs.csv')
ppvt$trial=1:dim(ppvt)[1]
for (i in 1:dim(ppvt)[1]) {
	#pdf(file=sprintf('generated/ppvt/trials/trial_%03d.pdf',ppvt$trial[i]))
	png(file=sprintf('VerbsDB1.2/trials/trial_%03d.png',ppvt$trial[i]), width=600, height=600)

	par(mfrow=c(2,2))
	img1<-load.image(sprintf('VerbsDB1.2/Pictures/cropped/resized/%s.jpg', ppvt$word[i]))
	plot(img1,xaxt='n', ann=FALSE, yaxt='n', axes=FALSE)
	img2<-load.image(sprintf('VerbsDB1.2/Pictures/cropped/resized/%s.jpg', ppvt$filler1.word[i]))
	plot(img2,xaxt='n', ann=FALSE, yaxt='n',  axes=FALSE)
	img3<-load.image(sprintf('VerbsDB1.2/Pictures/cropped/resized/%s.jpg', ppvt$filler2.word[i]))
	plot(img3,xaxt='n', ann=FALSE, yaxt='n',  axes=FALSE)
	img4<-load.image(sprintf('VerbsDB1.2/Pictures/cropped/resized/%s.jpg', ppvt$filler3.word[i]))
	plot(img4,xaxt='n', ann=FALSE, yaxt='n',  axes=FALSE)
	
	dev.off()
}