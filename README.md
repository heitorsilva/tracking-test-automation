# Tracking Test Automation

Prototype to find a solution for tracking fired events on BrowserStack browsers.

## Requirements

### Docker

Install Docker on your machine: [https://www.docker.com/get-started](https://www.docker.com/get-started)

After the installation, go to preferences, and set the number of CPUs to the maximum capacity of your computer.

The next commands must be executed from within the root of the project.

```bash
# If you're running for the first time
docker-compose build

# If you're running after the first time
docker-compose up
```

Other usefull commands:

```bash
docker-compose exec api ash # go inside a running api container
docker-compose exec qa bash # go inside a running qa container
docker-compose exec web ash # go inside a running web container
docker-compose down # kills running containers
```
