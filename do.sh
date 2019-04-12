#!/bin/sh

# for those of us that dont' use python enough to remember the protocols

# check for virtualenv
if [ ! -d ".$(basename $(pwd))" ]; then
  virtualenv ".$(basename $(pwd))"
fi
# source the virtual environment
. ".$(basename $(pwd))/bin/activate"

# install deps
pip install -r requirements.txt

# unit test? 

# deactivate virtualenv
deactivate
