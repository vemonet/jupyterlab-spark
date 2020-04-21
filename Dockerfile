FROM jupyter/all-spark-notebook

USER root

RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && \
  bash ~/.bash_it/install.sh --silent

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  apt-get upgrade -y && \
  apt-get install -y nodejs texlive-latex-extra texlive-xetex vim && \
  rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN pip install --upgrade pip && \
  pip install --upgrade \
    jupyterlab==1.2.6 \
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
    jupyterlab-git && \
  jupyter labextension install \
    @jupyter-widgets/jupyterlab-manager \
    @jupyterlab/latex \
    jupyterlab-drawio \ 
    #https://github.com/QuantStack/jupyterlab-drawio/issues/54
    jupyterlab-plotly \
    @bokeh/jupyter_bokeh \
    @jupyterlab/git \
    # https://github.com/jupyterlab/jupyterlab-git/pull/520
    @mflevine/jupyterlab_html \
    # ^to be removed at 2.0.1, now integrated
    jupyterlab-spreadsheet 

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY config/ /home/$NB_USER/.jupyter/
