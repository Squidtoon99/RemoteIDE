FROM codercom/code-server:4.10.0

USER coder

# Apply VS Code settings
# COPY deploy-container/settings.json .local/share/code-server/User/settings.json

# Use bash shell
ENV SHELL=/bin/bash

# Install Java
RUN sudo apt-get update && \
    sudo apt-get install -y openjdk-17-jdk && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/*

# RUN sudo echo "export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64" >> /etc/profile && \
#     sudo echo "export JDK_HOME=/usr/lib/jvm/java-17-openjdk-amd64"  >> /etc/profile && \
#     sudo echo "export PATH=\$JAVA_HOME/bin:\$PATH"                  >> /etc/profile

ENV CDR_EXT_CACHE=/extensions
ENV API_URL=https://code.squid.pink/
RUN sudo mkdir -p ${CDR_EXT_CACHE}
RUN if [ ${CDR_EXT_CACHE} != "/home/coder/.local/share/code-server/extensions" ]; then sudo rm -rf /home/coder/.local/share/code-server/extensions; fi
RUN sudo chown -R coder:coder ${CDR_EXT_CACHE}

RUN code-server --extensions-dir ${CDR_EXT_CACHE} --install-extension vscjava.vscode-java-pack
RUN code-server --extensions-dir ${CDR_EXT_CACHE} --install-extension usernamehw.errorlens

# download and install custom code-server extension from {API_URL}/extensions/{extension_name}
# RUN curl -L -o history.vsix ${API_URL}/static/extensions/java-ext.vsix
COPY history/history-0.0.1.vsix history.vsix
RUN code-server --extensions-dir ${CDR_EXT_CACHE} --install-extension ./history.vsix
# Fix perms Code
RUN sudo chown -R coder:coder /home/coder/.local

EXPOSE 8080
# Port 
ENV PORT=8080

ENTRYPOINT [ "code-server", "--extensions-dir", "/home/coder/.local/share/code-server/extensions", "--bind-addr", "0.0.0.0:8080"]