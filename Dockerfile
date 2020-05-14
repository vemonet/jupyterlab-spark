FROM jupyter/all-spark-notebook

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

RUN python -m pip install --upgrade pip

COPY requirements.txt .
RUN pip install --upgrade -r requirements.txt

RUN jupyter labextension install \
  @jupyter-widgets/jupyterlab-manager \
  @jupyterlab/latex \
  jupyterlab-drawio \ 
  jupyterlab-plotly \
  @bokeh/jupyter_bokeh \
  @krassowski/jupyterlab-lsp \
  @jupyterlab/git \
  jupyterlab-spreadsheet 

COPY config/ /home/$NB_USER/.jupyter/
