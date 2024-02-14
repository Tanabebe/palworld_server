FROM python:slim

RUN apt-get update -y \
    && apt-get install -y openssh-client sshpass \
    && apt-get install -y --no-install-recommends ca-certificates make \
    curl apt-transport-https lsb-release gnupg vim \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /etc/apt/keyrings \
    && curl -sLS https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/keyrings/microsoft.gpg > /dev/null \
    && chmod go+r /etc/apt/keyrings/microsoft.gpg

RUN AZ_DIST=$(lsb_release -cs) \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_DIST main" | tee /etc/apt/sources.list.d/azure-cli.list \
    && apt-get update \
    && apt-get install -y azure-cli

RUN pip install --upgrade pip \
    && pip install ansible \
    && ansible-galaxy collection install azure.azcollection --force \
    && pip install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt \
    && pip install passlib

WORKDIR /palworld_playbooks