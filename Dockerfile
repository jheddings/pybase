FROM python:3.8

WORKDIR "/opt/pybase"

# this helps keep the python libraries and dependencies contained, rather than
# pip installing a bunch of modules on the local system.

RUN /usr/local/bin/python3 -m pip install --upgrade pip

# install standard modules
COPY requirements.txt /opt/pybase/
RUN /usr/local/bin/python3 -m pip install -r /opt/pybase/requirements.txt

# by default, PyBASE does not have any of its own source files
#COPY src/*.py /opt/pybase/

# launch the python interpreter
ENTRYPOINT ["/usr/local/bin/python3", "-Ob"]

# enter interactive mode by default - this is somewhat redundant for the default
# case, but we are making it explicit to ensure the python shell comes up
CMD ["-i"]

