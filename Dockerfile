FROM rocker/shiny-verse:4.2.1

# Install Bioconductor packages
RUN R -e "if (!requireNamespace('BiocManager', quietly = TRUE)) install.packages('BiocManager')" && \
    R -e "BiocManager::install(c('IRanges', 'graph'))"

# Install R packages
RUN install2.r --error \
    --deps TRUE \
    devtools \
    plotly \
    fuzzyjoin \
    shinyWidgets \
    shinythemes \
    bayestestR


# Install GitHub packages
RUN R -e "devtools::install_github('DrMattG/HarvestGolem')" && \
    R -e "devtools::install_github('dreamRs/capture')"

# Copy the app
COPY app.R /srv/shiny-server/

# Configure logging to stdout/stderr
RUN ln -sf /dev/stdout /var/log/shiny-server.log && \
    ln -sf /dev/stderr /var/log/shiny-server.err

# Set permissions
RUN sudo chown -R shiny:shiny /srv/shiny-server

# Expose port
EXPOSE 3838

# Use shiny-server with logging configuration
CMD ["/usr/bin/shiny-server"]
