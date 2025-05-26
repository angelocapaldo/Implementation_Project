#install icosia
install.packages("icosa")
library("icosa")

# set seed for exact reproducibility
set.seed(0)

# 10000 random points
randPoints <- rpsphere(10000, output="polar")

# the first 6 points
head(randPoints)

#install sf
install.packages("sf")
library("sf")

# reading in example data
ne <- sf::st_read(file.path(system.file(package="icosa"), "extdata/ne_110m_land.shx"))

# plotting the world map
plot(ne$geometry, col="white", border="black")

# plotting the point cloud
points(randPoints, col="#FF000055", pch=3)

#installing terra
install.packages("terra")
library("terra")

#10x10° raster grid
r <- terra::rast(res=10)

#count points number
counts <- terra::rasterize(randPoints,r, fun=length)
counts

#visualize on map
plot(counts)
plot(ne$geometry, col=NA, border="white", add=TRUE)

# create a trigrid class object
hexa <- hexagrid(deg=5, sf=TRUE)
hexa
plot(hexa)

# plotting the world map
plot(ne$geometry, col="gray", border=NA)

# the grid
plot(hexa, add=TRUE)

# plotting the point cloud
points(randPoints, col="#FF000022", pch=3)

#gridding with F<integer> naming of cells
plot(hexa)
gridlabs(hexa, cex=0.5)

# the first five points
examples <- randPoints[1:5,]
examples

# visualize exact locations
points(examples, col="#FF0000", pch=3, cex=3)

# add an identifier 
text(label=1:nrow(examples), examples, col="#FF0000", pch=3, pos=2, cex=3)

#returning cell name under a point
exampleCells <- locate(hexa, examples)
exampleCells

# replot the map for clarity
plot(hexa)

# Subsetting the sf representation of the grid
plot(hexa, exampleCells, col="green", add=TRUE)

# labels
gridlabs(hexa, cex=0.5)

# points again
points(examples, col="#FF0000", pch=3, cex=3)

# localization of points
cells <- locate(hexa, randPoints)
str(cells)

# transform this to a data frame
rdf <- data.frame(randPoints)

# assign the face names as a column
rdf$cells <- cells

# the first 6 rows
head(rdf)

# counting the cells
tCells <- table(cells)
str(tCells)

# plotting the frequency
plot(hexa, tCells)
plot(hexa, tCells,
     border="white",
     pal=c("#440154FF", "#2D708EFF", "#29AF7FFF", "#FDE725FF"), 
     breaks=c(0, 10, 15, 20, 40)
     )

# the base map
plot(hexa, tCells, 
     crs="ESRI:54009", 
     border="white",
     pal=c("#440154FF", "#2D708EFF", "#29AF7FFF", "#FDE725FF"), 
     breaks=c(0, 10, 15, 20, 40)
)

neMoll <- sf::st_transform(ne, "ESRI:54009")

# the base map
plot(hexa, tCells,
     crs="ESRI:54009", 
     border="white",
     pal=c("#440154FF", "#2D708EFF", "#29AF7FFF", "#FDE725FF"), 
     breaks=c(0, 10, 15, 20, 40), 
     reset=FALSE
)

# the landmasses tranparent gray with black contour
plot(neMoll$geometry, add=TRUE, col="#66666688")

# translate the returned 2-column matrix to a data.frame
faceInfo <- as.data.frame(centers(hexa))

# the first 6 rows
head(faceInfo)

# using calculation results
faceInfo$count <- tCells[rownames(faceInfo)]

# the first 6 rows
head(faceInfo)

# associating with latitude
plot(faceInfo$lat, faceInfo$count, 
     xlab="Latitude (deg)", ylab="Point count", 
     pch=16, col="#99000044")

# summary with shorter code and coarser grid

gr <- hexagrid(deg=10, sf=TRUE) # create grid
cells<- locate(gr, randPoints) # locate points
tab <- table(cells) # tabulate, calculate
plot(gr, tab) # plot named vector/table