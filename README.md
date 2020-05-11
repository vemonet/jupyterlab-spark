Run all Spark Jupyterlab notebooks.

## Pull

```bash
docker pull umids/jupyterlab-spark:latest
```

## Run

```bash
docker run --rm -it -p 8888:8888 umids/jupyterlab-spark
```

> Notebooks workspace at `/home/jovyan` in the container.

Share volume:

```bash
docker run --rm -it -p 8888:8888 -v $(pwd):/home/jovyan umids/jupyterlab-spark
```

> Use `${pwd}` for Windows current directory.

Define your own password (the sha provided in the example correspond to the password `test`)

```bash
docker run --rm -it -p 8888:8888 umids/jupyterlab-spark start-notebook.sh  --NotebookApp.password='sha1:9316432938f9:93985dffbb854d31308dfe0602a51db947fb7d80'
```

> Generate a hash for your password in a Notebook by running
>
> ```python
> from notebook.auth import passwd
> passwd()
> ```

Run as root:

```bash
docker run --rm -it -p 8888:8888 -e GRANT_SUDO=yes --user root umids/jupyterlab-spark start-notebook.sh  --NotebookApp.password='sha1:HASH1:HASH2'
```

Limit memory and CPU usage:

```bash
docker run --rm -it -p 8888:8888 --memory=128g --cpus=24 umids/jupyterlab-spark
```

## Build from source

```bash
docker build -t umids/jupyterlab-spark .
```

Use the `requirements.txt` file to add packages to be installed at build.

## Installed Jupyterlab extensions

- [Jupyter Widgets](https://ipywidgets.readthedocs.io/en/latest/examples/Widget%20Basics.html)
- [@jupyterlab/latex](https://github.com/jupyterlab/jupyterlab-latex)
- [jupyterlab-plotly](https://www.npmjs.com/package/jupyterlab-plotly)
- [jupyterlab-drawio](https://github.com/QuantStack/jupyterlab-drawio)
- [jupyterlab-spreadsheet](https://github.com/quigleyj97/jupyterlab-spreadsheet)
- [@bokeh/jupyter_bokeh](https://github.com/bokeh/jupyter_bokeh)
- [@jupyterlab/toc](https://www.npmjs.com/package/@jupyterlab/toc)
- [@jupyterlab/git](https://www.npmjs.com/package/@jupyterlab/git)
- [@krassowski/jupyterlab-lsp](https://github.com/krassowski/jupyterlab-lsp)

## Acknowledgments

Alexander Malic for his [amalic/Jupyterlab](https://github.com/amalic/Jupyterlab) used as basis for this build.