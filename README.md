# Linux Ads Agent

Minimal Build agent Azure Devops Server.
This was created from [Running a self hosted agent in Docker](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops)

# Expected Environment-Variables

See [Microsoft Documentation](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops#environment-variables)

* AZP_URL: The URL of the Azure Devops Server
* AZP_POOL: The name of the Agent Pool
* AZP_TOKEN: An AZP Token used for Agent-Registration

# Included Tools

The Images builds with the following Tools installed:

## git 

Installed from the `ppa:git-core/ppa` repository

## docker

Only the CLI, no daemon. Installed by download, version controlled by build-arg `ARG DOCKER_VERSION=18.09.9`

## docker-compose

Installed by download, version controlled by build-arg `ARG DOCKER_COMPOSE_VERSION=1.26.2`