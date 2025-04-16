FROM codercom/enterprise-node:ubuntu
USER root
RUN apt-get update && \
	apt-get install -y \
	screen
USER coder
COPY --chown=coder:coder --chmod=0755 scripts/postCreate.sh /home/coder/postCreate.sh
