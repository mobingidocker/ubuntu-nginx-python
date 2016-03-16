#!/bin/bash
set -e
PYENV_PYTHON=2.7.11

curl -sL https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | PYENV_DEBUG=true bash
/opt/pyenv/bin/pyenv install ${PYENV_PYTHON}
/opt/pyenv/bin/pyenv global  ${PYENV_PYTHON}
/opt/pyenv/shims/pip install --upgrade pip
/opt/pyenv/shims/pip install uwsgi
