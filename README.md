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


## deploy with kustomize

The repo contains kustomize (https://kustomize.io/) for deployment and CI. 
The originally create helm chart is now obsolete.

### Secrets management

For the Agent to work, these envrionment-variables need to be set.
This is documented here [Running a self hosted agent in Docker](https://docs.microsoft.com/en-us/.azure/devops/pipelines/agents/docker?view=azure-devops)


* AZP_URL: the url of the Azure Devops instance
* AZP_POOL: the name of the Agent Pool
* AZP_TOKEN: a PAT token with the "Agent Pool: Manage" permission

The kustomize manifests a "secretGenerator" named `lnx-adsagent-config` to 
create a secret based on those values. The base manifests (./kustomize/bases) 
use this secret, but doen't define those. It need to be defined in a environment branch.

#### kind

The `kind` environment (./kustomize/kind) defines a secretGenerator based on an .env 
file (./kustomize/kind/.secrets.env). This is not commited into the repo. You need
to create this file if you clone the repo, and use the following structure:

```
AZP_URL=https://ads.example.com
AZP_POOL=the-pool-name
AZP_TOKEN=thetokenvalue
```

#### github-ci

The `github-ci` environment uses also a secrets file (`secrets.subst.env`), but these
only contain references to the corresponsing environment vars. Those are processed
using `envsubst`, and are stored as secrets in the repo

