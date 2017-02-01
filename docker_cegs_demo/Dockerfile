FROM rocker/rstudio:3.3.2
MAINTAINER ttickle@broadinstitute.org and Brian Haas (bhaas@broadinstitute.org)

######################
## Environment
######################

### locations
ENV BIN /usr/local/bin
ENV DATA /usr/local/data
ENV R_STUDIO /usr/local/R
ENV SRC /usr/local/src

### User setup
RUN groupadd -g 2000 training && useradd -m -u 2000 -g 2000 training
RUN echo 'training:training' | chpasswd
RUN chsh -s /bin/bash training
ENV HOME=/home/training
RUN echo "alias ll='ls -la -G'" >> /home/training/.profile
RUN usermod -G training,www-data training

######################
## Dependencies and Tools
######################
##############
## Helper tools
RUN apt-get update && \
    apt-get install -y unzip wget git \
    libssl-dev libcurl4-openssl-dev libxml2-dev libxt-dev libgstreamer0.10-0 ibgstreamer-plugins-base0.10-0 libcairo2-dev

#    r-base r-base-dev \

##############
## devtools
## seurat

RUN echo ".libPaths(c(\"/usr/local/lib/R/site-library\",\"/usr/local/lib/R/library\"))" > ${SRC}/install_pkgs.R && \
    echo "source(\"https://bioconductor.org/biocLite.R\")" > ${SRC}/install_pkgs.R && \
    echo "biocLite(\"useful\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    Rscript ${SRC}/install_pkgs.R

RUN echo ".libPaths(c(\"/usr/local/lib/R/site-library\",\"/usr/local/lib/R/library\"))" > ${SRC}/install_pkgs.R && \
    echo "source(\"https://bioconductor.org/biocLite.R\")" > ${SRC}/install_pkgs.R && \
    echo "biocLite(\"devtools\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    Rscript ${SRC}/install_pkgs.R

RUN echo ".libPaths(c(\"/usr/local/lib/R/site-library\",\"/usr/local/lib/R/library\"))" > ${SRC}/install_pkgs.R && \
    echo "source(\"https://bioconductor.org/biocLite.R\")" > ${SRC}/install_pkgs.R && \
    echo "biocLite(\"RcppArmadillo\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    Rscript ${SRC}/install_pkgs.R

RUN echo ".libPaths(c(\"/usr/local/lib/R/site-library\",\"/usr/local/lib/R/library\"))" > ${SRC}/install_pkgs.R && \
    echo "source(\"https://bioconductor.org/biocLite.R\")" > ${SRC}/install_pkgs.R && \
    echo "biocLite(\"reshape\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    Rscript ${SRC}/install_pkgs.R

RUN echo ".libPaths(c(\"/usr/local/lib/R/site-library\",\"/usr/local/lib/R/library\"))" > ${SRC}/install_pkgs.R && \
    echo "source(\"https://bioconductor.org/biocLite.R\")" > ${SRC}/install_pkgs.R && \
    echo "biocLite(\"Rook\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    Rscript ${SRC}/install_pkgs.R

RUN echo ".libPaths(c(\"/usr/local/lib/R/site-library\",\"/usr/local/lib/R/library\"))" > ${SRC}/install_pkgs.R && \
    echo "source(\"https://bioconductor.org/biocLite.R\")" > ${SRC}/install_pkgs.R && \
    echo "biocLite(\"rjson\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    Rscript ${SRC}/install_pkgs.R

RUN echo ".libPaths(c(\"/usr/local/lib/R/site-library\",\"/usr/local/lib/R/library\"))" > ${SRC}/install_pkgs.R && \
    echo "source(\"https://bioconductor.org/biocLite.R\")" > ${SRC}/install_pkgs.R && \
    echo "biocLite(\"RMTstat\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    Rscript ${SRC}/install_pkgs.R

RUN echo ".libPaths(c(\"/usr/local/lib/R/site-library\",\"/usr/local/lib/R/library\"))" > ${SRC}/install_pkgs.R && \
    echo "source(\"https://bioconductor.org/biocLite.R\")" > ${SRC}/install_pkgs.R && \
    echo "biocLite(\"extRemes\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    Rscript ${SRC}/install_pkgs.R

RUN echo ".libPaths(c(\"/usr/local/lib/R/site-library\",\"/usr/local/lib/R/library\"))" > ${SRC}/install_pkgs.R && \
    echo "source(\"https://bioconductor.org/biocLite.R\")" > ${SRC}/install_pkgs.R && \
    echo "biocLite(\"pcaMethods\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    Rscript ${SRC}/install_pkgs.R

RUN echo ".libPaths(c(\"/usr/local/lib/R/site-library\",\"/usr/local/lib/R/library\"))" > ${SRC}/install_pkgs.R && \
    echo "source(\"https://bioconductor.org/biocLite.R\")" > ${SRC}/install_pkgs.R && \
    echo "biocLite(\"SummarizedExperiment\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    Rscript ${SRC}/install_pkgs.R

RUN echo ".libPaths(c(\"/usr/local/lib/R/site-library\",\"/usr/local/lib/R/library\"))" > ${SRC}/install_pkgs.R && \
    echo "source(\"https://bioconductor.org/biocLite.R\")" > ${SRC}/install_pkgs.R && \
    echo "biocLite(\"pheatmap\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    Rscript ${SRC}/install_pkgs.R

RUN echo ".libPaths(c(\"/usr/local/lib/R/site-library\",\"/usr/local/lib/R/library\"))" > ${SRC}/install_pkgs.R && \
    echo "source(\"https://bioconductor.org/biocLite.R\")" > ${SRC}/install_pkgs.R && \
    echo "biocLite(\"amap\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    Rscript ${SRC}/install_pkgs.R

RUN echo ".libPaths(c(\"/usr/local/lib/R/site-library\",\"/usr/local/lib/R/library\"))" > ${SRC}/install_pkgs.R && \
    echo "source(\"https://bioconductor.org/biocLite.R\")" > ${SRC}/install_pkgs.R && \
    echo "biocLite(\"vioplot\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    Rscript ${SRC}/install_pkgs.R

RUN echo ".libPaths(c(\"/usr/local/lib/R/site-library\",\"/usr/local/lib/R/library\"))" > ${SRC}/install_pkgs.R && \
    echo "source(\"https://bioconductor.org/biocLite.R\")" > ${SRC}/install_pkgs.R && \
    echo "biocLite(\"codetools\", dependencies=TRUE)" >> ${SRC}/install_pkgs.R && \
    Rscript ${SRC}/install_pkgs.R

RUN echo ".libPaths(c(\"/usr/local/lib/R/site-library\",\"/usr/local/lib/R/library\"))" > ${SRC}/install_pkgs.R && \
    echo "source(\"https://bioconductor.org/biocLite.R\")" > ${SRC}/install_pkgs.R && \
    echo "devtools::install_github(\"satijalab/seurat\")" >> ${SRC}/install_pkgs.R && \
    wget https://cran.r-project.org/src/contrib/Archive/nlme/nlme_3.1-123.tar.gz && \
    R CMD INSTALL nlme_3.1-123.tar.gz && \
    Rscript ${SRC}/install_pkgs.R

RUN echo ".libPaths(c(\"/usr/local/lib/R/site-library\",\"/usr/local/lib/R/library\"))" > ${SRC}/install_pkgs.R && \
    echo "source(\"https://bioconductor.org/biocLite.R\")" > ${SRC}/install_pkgs.R && \
    echo "devtools::install_github(\"RGLab/MAST@summarizedExpt\")" >> ${SRC}/install_pkgs.R && \
    Rscript ${SRC}/install_pkgs.R


# Ports
EXPOSE 8787


## Pull in data from ftp
WORKDIR ${R_STUDIO}/data
RUN wget https://data.broadinstitute.org/Trinity/CTAT/single_cell_workshop/data/bipolar_cluster_seurat_demo.Robj && \
    wget https://data.broadinstitute.org/Trinity/CTAT/single_cell_workshop/data/bipolar_demo_seurat_pca.Robj && \
    wget https://data.broadinstitute.org/Trinity/CTAT/single_cell_workshop/data/bipolar_regress_demo.Robj && \
    wget https://data.broadinstitute.org/Trinity/CTAT/single_cell_workshop/data/bipolar_seurat_demo.Robj && \
    wget https://data.broadinstitute.org/Trinity/CTAT/single_cell_workshop/data/mast_zlm_demo.Robj && \
    wget https://data.broadinstitute.org/Trinity/CTAT/single_cell_workshop/data/small_bipolar.Robj

WORKDIR ${R_STUDIO}/src
RUN wget https://data.broadinstitute.org/Trinity/CTAT/single_cell_workshop/src/dotplot.R && \
    wget https://data.broadinstitute.org/Trinity/CTAT/single_cell_workshop/src/makeNiceMAST.R

WORKDIR ${SRC}
RUN git clone https://github.com/TimothyTickle/single_cell_analysis.git


## For seurat, needs java and unfortunately writes to /usr/local/lib/R/site-library! and needs open permissions
RUN apt-get update && apt-get install -y default-jre htop && apt-get clean
RUN chmod 777 /usr/local/lib/R/site-library

## Rstudio is hard coded to look for /usr/bin/R but I need to the /usr/local/bin/R
## And cringe the solution...
#RUN rm /usr/bin/R && ln -s /usr/local/bin/R /usr/bin/R
