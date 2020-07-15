FROM python:3.8

# this helps keep the python libraries and dependencies contained, rather than
# pip installing a bunch of modules on the local system.

RUN python3 -m pip install --upgrade pip

# common libraries used by multiple apps
RUN python3 -m pip install requests pyyaml

# used for specific applications
RUN python3 -m pip install sqlalchemy ratelimit

# by default, PyBASE does not have any of its own source files
#COPY src/*.py /opt/pybase

WORKDIR "/opt/pybase"

CMD ["/bin/bash"]
