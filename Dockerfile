FROM ensemblorg/ensembl-vep:latest
USER vep
WORKDIR $HOME/src/ensembl-vep
RUN git pull && \
    git checkout release/91 && \
    ./INSTALL.pl -a acf -s homo_sapiens -y GRCh37

USER root
WORKDIR /mnt
RUN wget http://www.broadinstitute.org/~konradk/loftee/human_ancestor.fa.rz && \
    wget http://www.broadinstitute.org/~konradk/loftee/human_ancestor.fa.rz.fai && \
    wget https://raw.githubusercontent.com/Ensembl/VEP_plugins/release/90/LoFtool_scores.txt && \
    wget https://www.broadinstitute.org/%7Ekonradk/loftee/phylocsf.sql.gz
RUN cp -r /home/vep/.vep/homo_sapiens $(pwd)