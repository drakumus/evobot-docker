FROM node:14.16.1-slim

RUN bash -c 'echo -e "Starting dockerfile"'

ENV USER=evobot

RUN bash -c 'echo -e "Installing python"'
# install python and make
RUN apt-get update && \
	apt-get install -y python3 build-essential && \
	apt-get purge -y --auto-remove

RUN bash -c 'echo -e "Creating evobot user"'
# create evobot user
RUN groupadd -r ${USER} && \
	useradd --create-home --home /home/evobot -r -g ${USER} ${USER}

RUN bash -c 'echo -e "Setting up volume and user"'
# set up volume and user
USER ${USER}
WORKDIR /home/evobot

RUN bash -c 'echo -e "Starting installing"'
COPY --chown=${USER}:${USER} package*.json ./
RUN npm install
VOLUME [ "/home/evobot" ]

COPY --chown=${USER}:${USER}  . .

ENTRYPOINT [ "node", "index.js" ]
