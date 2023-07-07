# Goal: Capture package dependencies at build time and include in container.
# renv paths need to be readable once the container is running
# package library is in the container. Path set inside the container. 
# When restored, the path is writeable.
FROM ghcr.io/rstudio/r-session-complete:jammy-2023.03.1

ENV RENV_PATHS_LIBRARY renv/library

ENV RENV_PATHS_ROOT=/project/renv
ENV RENV_PATHS_LIBRARY=/project/renv/library
ENV R_LIBS_SITE=/project/renv/library/R-4.2/x86_64-pc-linux-gnu:/opt/R/4.2.3/lib/R/library

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    file

RUN echo "" >> ${R_HOME}/etc/Renviron
RUN echo "RENV_PATHS_ROOT=${RENV_PATHS_ROOT}" >> ${R_HOME}/etc/Renviron
RUN echo "RENV_PATHS_LIBRARY=${RENV_PATHS_LIBRARY}" >> ${R_HOME}/etc/Renviron
RUN echo "R_LIBS_SITE=${R_LIBS_SITE}" >> ${R_HOME}/etc/Renviron

WORKDIR /project
# COPY renv.lock .
RUN R -e "install.packages('renv', repos = c(CRAN = 'https://p3m.dev/cran/__linux__/jammy/latest'))"
RUN R -e "renv::restore(lockfile = 'renv.lock')"








