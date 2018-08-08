FROM ensemblorg/ensembl-vep:release_93

LABEL maintainer="sueruen@informatik.uni-tuebingen.de"

USER vep
WORKDIR $OPT/src/ensembl-vep
RUN git pull && \
    git checkout release/93 && \
    ./INSTALL.pl -n --CACHE_VERSION 93 --VERSION 93 -a acf -s homo_sapiens -y GRCh37

WORKDIR /opt/vep
RUN wget http://www.broadinstitute.org/~konradk/loftee/human_ancestor.fa.rz && \
    wget http://www.broadinstitute.org/~konradk/loftee/human_ancestor.fa.rz.fai && \
    wget https://raw.githubusercontent.com/Ensembl/VEP_plugins/release/90/LoFtool_scores.txt

RUN wget https://www.broadinstitute.org/%7Ekonradk/loftee/phylocsf.sql.gz && \
    gunzip phylocsf.sql.gz

USER root
COPY copy_data.sh /opt/vep
RUN chmod +x copy_data.sh
ENTRYPOINT [ "/opt/vep/copy_data.sh" ]
