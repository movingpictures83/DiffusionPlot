library(FELLA)
library(org.Mm.eg.db)
library(KEGGREST)

library(igraph)
library(magrittr)

set.seed(1)

dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")
source("RIO.R")

input <- function(inputfile) {
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1];
    pfix = prefix()
  if (length(pfix) != 0) {
     pfix <<- paste(pfix, "/", sep="")
  }
}

run <- function() {}

output <- function(outputfile) {
pdf(outputfile)

  fella.data <<- loadKEGGdata(
    databaseDir = paste(pfix, parameters["database", 2], sep="/"),#tmpdir,
    internalDir = FALSE,
    loadMatrix = "none"
)


analysis.nafld <- readRDS(paste(pfix, parameters["enriched", 2], sep="/"))

#print(str(analysis.nafld))
write.csv(analysis.nafld@diffusion@pscores, paste(outputfile, "csv", sep="."))
plot(
    analysis.nafld,
    method = "diffusion",
    data = fella.data,
    nlimit = 250,
    plotLegend = FALSE)


}
