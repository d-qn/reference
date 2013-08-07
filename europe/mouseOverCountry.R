library(XML)

# load and parse the svg file
doc <- xmlTreeParse("europe_mouseOverNames.svg")
r <- xmlRoot(doc)

# load the csv file for mapping country names to their abreviation
countries <- read.csv("countries.csv", header = T, sep = ",", encoding = "UTF-8")

mouseOver1a <- "ShowTooltip(evt," 
mouseOver1b <- ")"
mouseOver2 <- "HideTooltip()"


for(i in 1:length(r)) {
  if('id' %in% names(xmlAttrs(r[[i]]))) {
    country <- NA
    id <- toupper(xmlAttrs(r[[i]])['id'])
    id2country <- match(id, countries[, 1])
    if(!is.na(id2country)) {
      country <- countries[id2country, 2]
      xmlAttrs(r[[i]]) <- c(onmousemove = paste(mouseOver1a, "'", country, "'", mouseOver1b, sep=""), onmouseout = mouseOver2)
    } else {
      cat("\n", id)    
    }
  } 
}

sink(file = "europe_mouseOverName.svg")
print(r)
sink()

