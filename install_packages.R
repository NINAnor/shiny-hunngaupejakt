# Installed packages: shiny, tidyverse, devtools

packages <- c(
"plotly",
"devtools",
"fuzzyjoin",
"shinyWidgets",
"shinythemes",
"bayestestR"
)
install.packages(packages, dep=T, repos="https://cran.uib.no")

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("graph")

## Install with devtools when github-package is installed
devtools::install_github("DrMattG/HarvestGolem")
devtools::install_github("dreamRs/capture")
