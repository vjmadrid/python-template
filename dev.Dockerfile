# ****************************************************************
#      _            ____             _              __ _ _      
#   __| | _____   _|  _ \  ___   ___| | _____ _ __ / _(_) | ___ 
#  / _` |/ _ \ \ / / | | |/ _ \ / __| |/ / _ \ '__| |_| | |/ _ \
# | (_| |  __/\ V /| |_| | (_) | (__|   <  __/ |  |  _| | |  __/
#  \__,_|\___| \_(_)____/ \___/ \___|_|\_\___|_|  |_| |_|_|\___|
#                                                              
# ****************************************************************

# dev.Dockerfile



# **********************************
# 		builder
# **********************************

# Features :
#   * Prepare environment : Os version + Python version
#   * Update OS environment
#   * Download all necessary libraries that will be needed to build the application
#   * Create Virutal environment
#   * Update PIP environment

FROM python:3.9.0-slim-buster AS builder

RUN apt-get update && apt-get install -y --no-install-recommends --yes python3-venv gcc libpython3-dev && \
    python3 -m venv /venv && \
    /venv/bin/pip install --upgrade pip



# **********************************
# 		builder-venv
# **********************************

# Features :
#   * Install dependencies in the Virtual Environment
#   * Use for Chaching 

FROM builder AS builder-venv

COPY requirements.txt /requirements.txt
RUN /venv/bin/pip install -r /requirements.txt



# **********************************
# 		tester
# **********************************

# Features :
#   * Copy app
#   * Run Test

FROM builder-venv AS tester

COPY . /app
WORKDIR /app
RUN /venv/bin/pytest


# **********************************
# 		runner
# **********************************

# Features :
#   * Copy Virtual Environment with Dependencies
#   * Copy application tested
#   * Move to application directory
#   * Define entrypoint -> runs our application when image is started
#   * Set USER 1001 for no use root user

FROM docker.pkg.github.com/acme/projectx/python-3.9.0-buster-tools:latest AS runner

COPY --from=tester /venv /venv
COPY --from=tester /app /app

WORKDIR /app

# ENTRYPOINT ["/venv/bin/python3", "-m", "projectx"]
# USER 1001


LABEL name=projectx
LABEL version=v1.0
