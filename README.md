# BetterCode
Bringing the power of Visual Studio Code to students all around the world.

## Installation
! IMPORTANT: This code is written to be hosted on a kubernetes cluster. It is ideal to use the public hosted version of this tool [HERE](https://code.squid.pink).

### Kubernetes
1. Clone this repository
2. Run `kubectl apply -f deployments/` in the root directory of this repository
<!-- Install Traefik -->
3. Install Traefik using the instructions [HERE](https://doc.traefik.io/traefik/getting-started/install-traefik/)
4. Use the yaml file in deployments/traefik.yml to seed the helm installation.
5. Visit the public ip generated by traefik to access the application.