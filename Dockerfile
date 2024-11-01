FROM rocker/shiny-verse:4.2.1

# Install R packages
RUN install2.r --error \
    --deps TRUE \
    devtools

# Install packages
RUN R -e "BiocManager::install('graph')"
RUN R -e "devtools::install_github('DrMattG/HarvestGolem')"

# copy the app and scripts to the image. *.r if multiple
COPY app.R /srv/shiny-server/


# Ports exposed on the container
EXPOSE 3838

# allow permission
RUN sudo chown -R shiny:shiny /srv/shiny-server

CMD Rscript /srv/shiny-server/app.R