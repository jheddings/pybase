FROM python:3.8

WORKDIR "/opt/pybase"

# this helps keep the python libraries and dependencies contained, rather than
# pip installing a bunch of modules on the local system.

RUN python3 -m pip install --upgrade pip

# install standard modules
ADD requirements.txt requirements.txt
RUN python3 -m pip install -r requirements.txt

# by default, PyBASE does not have any of its own source files
#COPY src/*.py /opt/pybase

CMD ["/bin/bash"]
