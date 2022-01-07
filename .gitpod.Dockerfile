ARG BASE_CONTAINER=rocker/verse:4.0.4
FROM $BASE_CONTAINER

# fix permissions
# RUN chown rstudio-server:rstudio-server /var/lib/rstudio-server/
# RUN chown gitpod:gitpod /var/lib/rstudio-server/
RUN chmod -R g=u /var/lib/rstudio-server

# install r packages
RUN R -e "install.packages('tidyverse', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('brms', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('osfr', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('cmdstanr', repos = c('https://mc-stan.org/r-packages/', getOption('repos')))"

# install cmdstanr
RUN mkdir -p /home/rstudio/.cmdstanr
ENV PATH="/home/rstudio/.cmdstanr:${PATH}"
RUN R -e "cmdstanr::install_cmdstan(dir = '/home/rstudio/.cmdstanr', cores = 4)"

# rstudio setup
COPY database.conf /etc/rstudio/database.conf

# install lib dependencies

EXPOSE 8787
