# Goal: Capture package dependencies at build time and include in container.
# renv paths need to be readable once the container is running
# package library is in the container. Path set inside the container. 
# When restored, the path is writeable.
FROM ghcr.io/rstudio/r-session-complete:jammy-2023.03.1

ENV RENV_PATHS_LIBRARY renv/library

RUN R -e "install.packages('renv', repos = c(CRAN = 'https://p3m.dev/cran/__linux__/jammy/latest'))"
