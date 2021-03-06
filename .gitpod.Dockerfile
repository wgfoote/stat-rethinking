ARG BASE_CONTAINER=rocker/verse:4.0.4
FROM $BASE_CONTAINER

# install r packages
RUN R -e "install.packages('tidyverse', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('brms', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('osfr', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('cmdstanr', repos = c('https://mc-stan.org/r-packages/', getOption('repos')))"
RUN R -e "devtools::install_github('rmcelreath/rethinking')"

# install cmdstanr
RUN mkdir -p /home/rstudio/.cmdstanr
ENV PATH="/home/rstudio/.cmdstanr:${PATH}"
RUN R -e "cmdstanr::install_cmdstan(dir = '/home/rstudio/.cmdstanr', cores = 4)"

# rstudio setup
COPY .gitpod/database.conf /etc/rstudio/database.conf
COPY .gitpod/.Rprofile /usr/local/lib/R/etc/Rprofile.site
COPY .gitpod/.Rprofile /home/rstudio/.Rprofile
# install lib dependencies

EXPOSE 8787
