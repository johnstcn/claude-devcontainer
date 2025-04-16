FROM codercom/enterprise-node:ubuntu
USER root
RUN apt-get update && \
	apt-get install -y \
	screen
RUN curl -fsSL https://code-server.dev/install.sh | sh -s --
RUN mkdir -p /opt/scripts
COPY --chown=root:root --chmod=0755 scripts/claude-code.sh /opt/scripts/claude-code.sh
COPY --chown=root:root --chmod=0755 scripts/code-server.sh /opt/scripts/code-server.sh
USER coder
