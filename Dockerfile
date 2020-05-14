ARG NB_USER="jovyan"
ARG NB_UID="1000"
ARG NB_GID="100"
FROM jupyter/all-spark-notebook

ARG NB_USER="jovyan"
ARG NB_UID="1000"
ARG NB_GID="100"

ENV JUPYTER_ENABLE_LAB=yes
USER root

RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && \
  bash ~/.bash_it/install.sh --silent

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  apt-get upgrade -y && \
  apt-get install -y nodejs texlive-latex-extra texlive-xetex \
    ca-certificates build-essential \
    wget curl vim raptor2-utils && \
  rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN pip install --upgrade pip && \
  pip install --upgrade \
    'jupyterlab>=2.0' \
    'jedi==0.17.0' \ 
    # jupyterlab-lsp does not support 0.17
    pyspark \
    findspark \
    networkx \
    numpy \
    gensim \
    pandas \
    sklearn \
    beautifulsoup4 \
    keras \
    tensorflow \
    joblib \
    matplotlib \
    mlxtend \
    rdflib \
    xgboost \
    seaborn \
    ipywidgets \
    jupyterlab_latex \
    plotly \
    bokeh \
    scipy \
    numexpr \
    patsy \
    scikit-learn \
    scikit-image \
    ipython \
    sympy \
    nose \
    jupyter-lsp \
    python-language-server \
    jupyterlab-git

  RUN jupyter labextension install \
    @jupyter-widgets/jupyterlab-manager \
    @jupyterlab/latex \
    jupyterlab-drawio \ 
    jupyterlab-plotly \
    @bokeh/jupyter_bokeh \
    @krassowski/jupyterlab-lsp \
    @jupyterlab/git \
    jupyterlab-spreadsheet 

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY config/ /home/$NB_USER/.jupyter/
