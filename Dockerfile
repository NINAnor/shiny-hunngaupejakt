FROM rocker/shiny-verse:4.2.1

# Install R packages
RUN install2.r --error \
    --deps TRUE \
    devtools \
    plotly \
    fuzzyjoin \
    shinyWidgets \
    shinythemes \
    bayestestR

# Install Bioconductor packages
RUN R -e "if (!requireNamespace('BiocManager', quietly = TRUE)) install.packages('BiocManager')" && \
    R -e "BiocManager::install('graph')"

# Install GitHub packages
RUN R -e "devtools::install_github('DrMattG/HarvestGolem')" && \
    R -e "devtools::install_github('dreamRs/capture')"

# Copy the app
COPY app.R /srv/shiny-server/

# Expose port
EXPOSE 3838

# Set permissions
RUN sudo chown -R shiny:shiny /srv/shiny-server

CMD Rscript /srv/shiny-server/app.R
