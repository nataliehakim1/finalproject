FROM rocker/r-ubuntu 

RUN apt-get update && apt-get install -y pandoc libcurl4-openssl-dev libssl-dev libxml2-dev libfontconfig1-dev cmake

RUN mkdir /project
WORKDIR /project

RUN mkdir code
RUN mkdir output
RUN mkdir raw_data

COPY Makefile .
COPY README.md .
COPY Gitfinal.Rmd .

COPY .Rprofile .
COPY renv.lock .
RUN mkdir renv
COPY renv/settings.dcf renv
COPY renv/activate.R renv

RUN Rscript -e "renv::restore(prompt = FALSE)"

RUN mkdir data
COPY code/* code
COPY data/* data

RUN mkdir FinalProject

CMD make && mv Gitfinal.html FinalProject







