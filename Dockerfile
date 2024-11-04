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
    bayestestR \
    golem \
    shinybusy \
    popbio \
    shinycssloaders \
    maditr \
    MESS \
    shinyvalidate \
    shinyBS \
    shinyscreenshot


# Install GitHub packages
RUN R -e "devtools::install_github('DrMattG/HarvestGolem')" && \
    R -e "devtools::install_github('dreamRs/capture')"

# Install renv package
RUN R -e "install.packages('renv')"

# Copy the renv.lock file generated in Method 1
#COPY renv.lock /renv.lock

# Restore packages listed in renv.lock
#RUN R -e "renv::restore()"

# Copy the custom shiny-server.conf file
COPY shiny-server.conf /etc/shiny-server/shiny-server.conf

# Set environment variable for logging to /dev/null
ENV SHINY_LOG_DIR=/dev/null

# Redirect error output to stderr
ENV SHINY_LOG_STDERR=1

# Copy the app
COPY app.R /srv/shiny-server/
RUN rm -rf /srv/shiny-server/sample-apps /srv/shiny-server/index.html /srv/shiny-server/[0-9]*

# Set permissions and ownership
RUN chown -R shiny:shiny /srv/shiny-server && \
    chmod -R 755 /srv/shiny-server


# Switch to shiny user
USER shiny

# Expose port
EXPOSE 3838

# Use shiny-server
CMD ["/usr/bin/shiny-server"]
