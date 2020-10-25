# **********************************************************************
#                   ____             _              __ _ _      
#  _ __  _ __ ___  |  _ \  ___   ___| | _____ _ __ / _(_) | ___ 
# | '_ \| '__/ _ \ | | | |/ _ \ / __| |/ / _ \ '__| |_| | |/ _ \
# | |_) | | | (_) || |_| | (_) | (__|   <  __/ |  |  _| | |  __/
# | .__/|_|  \___(_)____/ \___/ \___|_|\_\___|_|  |_| |_|_|\___|
# |_|
#                                                           
# **********************************************************************

# **********************************
# 		builder
# **********************************

FROM debian:buster-slim AS builder
#FROM gcr.io/distroless/python3-debian10 AS runner

RUN apt-get update && \
    apt-get install --no-install-suggests --no-install-recommends --yes python3-venv gcc libpython3-dev && \
    python3 -m venv /venv && \
    /venv/bin/pip install --upgrade pip



# **********************************
# 		builder-venv
# **********************************

FROM builder AS builder-venv

COPY requirements.txt /requirements.txt
RUN /venv/bin/pip install --disable-pip-version-check -r /requirements.txt
