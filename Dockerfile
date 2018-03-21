FROM ensemblorg/ensembl-vep:latest

LABEL maintainer="sueruen@informatik.uni-tuebingen.de"

USER vep
WORKDIR $HOME/src/ensembl-vep
RUN git pull && \
    git checkout release/91 && \
    ./INSTALL.pl -a acf -s homo_sapiens -y GRCh37

WORKDIR /home/vep
RUN wget http://www.broadinstitute.org/~konradk/loftee/human_ancestor.fa.rz && \
    wget http://www.broadinstitute.org/~konradk/loftee/human_ancestor.fa.rz.fai && \
    wget https://raw.githubusercontent.com/Ensembl/VEP_plugins/release/90/LoFtool_scores.txt

RUN wget https://www.broadinstitute.org/%7Ekonradk/loftee/phylocsf.sql.gz && \
    gunzip phylocsf.sql.gz

USER root
COPY copy_data.sh /home/vep
RUN chmod +x copy_data.sh
ENTRYPOINT [ "/home/vep/copy_data.sh" ]
