#R code for rs

install.packages("raster")
library(raster)

setwd("/lab") #linux
#setwd("C:/lab") #windows
#setwd("/Users/username/lab") #mac

p224r63_2011 <- brick("p224r63_2011_masked.grd")

plot(p224r63_2011)
#B1: blue
#B2: green
#B3: red
#B4: infrared

cl <- colorRampPalette(c('black','grey','light grey'))(100)

plot(p224r63_2011, col = cl)

par(mfrow=c(2,2))
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) # 
plot(p224r63_2011$B1_sre, col=clb)

clg <- colorRampPalette(c('dark green','green','light green'))(100) # 
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c('dark red','red','pink'))(100) # 
plot(p224r63_2011$B3_sre, col=clr)

cln <- colorRampPalette(c('red','orange','yellow'))(100) # 
plot(p224r63_2011$B4_sre, col=cln)

dev.off()
#RGB

plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") #add NIR on top of the red component
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") #add NIR on top of the green component
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin") #add NIT on top of the blue component


p224r63_1988 <- brick("p224r63_1988_masked.grd") #import the 1988 image
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

#DVI = NRI - RED
#NDVI = (NRI-RED)/(NRI+RED)

DVI_1988 <- p224r63_1988$B4_sre - p224r63_1988$B3_sre
DVI_2011 <- p224r63_2011$B4_sre - p224r63_2011$B3_sre

par(mfrow=c(2,1))
plot(DVI_1988)
plot(DVI_2011)

par(mfrow=c(2,1))
cldvi <- colorRampPalette(c('red','orange','green'))(100) # 
plot(dvi1988, col=cldvi)
plot(dvi2011, col=cldvi)
dev.off()
difdvi <- DVI_2011-DVI_1988
cldif <- colorRampPalette(c('blue','white','red'))(100) #
plot(difdvi, col=cldif)

install.packages("RStoolbox")
library(RStoolbox)

#rescaling
p224r63_2011res <- aggregate(p224r63_2011, fact=10)

par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="Lin")

p224r63_2011_pca <- rasterPCA(p224r63_2011res)
summary(p224r63_2011_pca$model) # look at the PCAs

dev.off()
plotRGB(p224r63_2011_pca$map, r=4, g=3, b=2, stretch="Lin")

#land cover
p224r63_2011_c <- unsuperClass(p224r63_2011, nClasses=5)
clcl <- colorRampPalette(c('blue','green','red','yellow','black'))(100)
plot(p224r63_2011_c$map, col=clcl)
