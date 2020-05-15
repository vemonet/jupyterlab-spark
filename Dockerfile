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

# Install YARRRML using npm and download RMLMapper jar file
RUN npm i --save @rmlio/yarrrml-parser
RUN wget -O /home/$NB_USER/rmlmapper.jar https://github.com/RMLio/rmlmapper-java/releases/download/v4.7.0/rmlmapper-4.7.0-r150.jar

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
