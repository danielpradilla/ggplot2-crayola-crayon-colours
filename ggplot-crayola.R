library(XML)
library(ggplot2)
library(plyr)
library(colorspace)

theurl <- "http://en.wikipedia.org/wiki/List_of_Crayola_crayon_colors"
html <- htmlParse(theurl, encoding="UTF-8")
crayola <- readHTMLTable(html, stringsAsFactors = FALSE)[[1]]
crayola <-crayola[,c("Hex Code\n(approximate)†", "Issued", "Retired")]
names(crayola) <- c("colour", "issued", "retired")
crayola <- crayola[!duplicated(crayola$colour),]
crayola$retired[crayola$retired == ""] <- as.numeric(format(Sys.Date(),"%Y"))

#Instead of geom_rect() I will show two options of plotting the same data using geom_bar() and geom_area() 
#to plot the data, and need to ensure that there’s one entry per colour per year it was(is) in the production.
colours <- ddply(crayola, .(colour), transform, year = issued:retired)



p1 <- ggplot(colours, aes(year, 1, fill = colour)) + geom_area(position = "fill", colour = "white") + theme_bw() + scale_fill_identity()


labels <- c(1903, 1949, 1958, 1972, 1990, 1998, as.numeric(format(Sys.Date(),"%Y")))
breaks <- labels - 1

x <- scale_x_continuous("", breaks = breaks, labels = labels, expand = c(0, 0))
y <- scale_y_continuous("", expand = c(0, 0))
ops <- theme(axis.text.y = element_blank(), axis.ticks = element_blank())

p1 + x + y + ops

sort.colours <- function(col) {
  c.rgb = col2rgb(col)
  c.RGB = RGB(t(c.rgb) %*% diag(rep(1/255, 3)))
  c.HSV = as(c.RGB, "HSV")@coords
  order(c.HSV[, 1], c.HSV[, 2], c.HSV[, 3])
}

colours = ddply(colours, .(year), function(d) d[rev(sort.colours(d$colour)), ])
final <- last_plot() %+% colours

print(final)


