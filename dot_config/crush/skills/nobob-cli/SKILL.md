---
name: nobob-cli
description: Use the nobob CLI to manage local development environment - swap services to run on host, manage ECR login, add new services, and inspect environment info. Use when working with local dev routing, Docker service overrides, or setting up new services.
---

# Nobob CLI Skill

## Description
Use the nobob CLI to manage the local development environment, primarily for routing service traffic between Docker and host-based services.

## Commands

### Swap a Service to Run on Host
Route requests to a service running locally on the host instead of in Docker:
```bash
nobob swap SERVICE
```

With a custom port:
```bash
nobob swap SERVICE PORT
```

With a custom host (e.g., another docker-compose service):
```bash
nobob swap SERVICE HOST
nobob swap SERVICE HOST PORT
```

Examples:
```bash
nobob swap blaze                            # Use local host, default port
nobob swap graphter 8888                    # Use local host, custom port
nobob swap navago nobob_navago           # Use custom host
nobob swap navago nobob_navago 7000      # Use custom host and port
```

### Unswap a Service (Back to Docker)
Restore a service to run in Docker:
```bash
nobob unswap SERVICE
```

Example:
```bash
nobob unswap blaze
```

### Show Current Overrides
List all active service swaps:
```bash
nobob swapped
```

Print full override config:
```bash
nobob swapped --show
```

### ECR Login
Authenticate with AWS Elastic Container Registry:
```bash
nobob ecr-login
```

### Add a New Service
Generate Duke routing YAML for a new service:
```bash
nobob add-service SERVICE_TYPE SERVICE_NAME
```

Examples:
```bash
nobob add-service api polecat
nobob add-service ui crayon
```

### Environment Info
Print information about the current environment:
```bash
nobob info
```

### Help
```bash
nobob help           # Main commands
nobob help all       # All commands
nobob help COMMAND_GROUP  # Commands for a specific group
```

## When to Use
- When you need to develop a service locally and route traffic to it instead of Docker
- When switching between local and Docker-based service instances
- When logging into ECR to pull/push images
- When scaffolding routing config for a new service
- When checking what services are currently swapped to host
