#app.R
# Reload HarvestGolem with this code to get it in to the shiny libraries
#library(withr)
#library(devtools)
#with_libpaths(new = "/data/shiny/packages/", install_github("DrMattG/HarvestGolem", force=TRUE))
#with_libpaths(new = "/home/NINA.NO/matthew.grainger/R/x86_64-pc-linux-gnu-library/4.0", install_github("DrMattG/HarvestGolem", force=TRUE))

install_github("DrMattG/HarvestGolem", force=TRUE)
library(HarvestGolem)
HarvestGolem::run_app()
