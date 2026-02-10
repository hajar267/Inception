# Inception

*This project has been created as part of the 42 curriculum by hfiqar.*

## Description

Inception is a system administration project that introduces Docker containerization. 
The goal is to set up a small infrastructure using Docker Compose, consisting of NGINX,
WordPress, and MariaDB services, each running in dedicated containers with proper networking and volume management.

## Instructions

**Prerequisites:**
- Docker and Docker Compose installed
- A virtual machine

**Setup:**
```bash
# Clone the repository
git clone git@github.com:hajar267/Inception.git
cd Inception

# Build and launch all services
make

# Stop all services
make down

# Clean everything (containers, volumes, images)
make fclean
```

Access the website at: `https://hfiqar.42.fr`

## Resources

**Documentation:**
- [Docker Official Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [NGINX Documentation](https://nginx.org/en/docs/)
- [WordPress with Docker](https://hub.docker.com/_/wordpress)
- [MariaDB Documentation](https://mariadb.com/kb/en/documentation/)

**AI Usage:**
AI tools were used for:
- Understanding Docker networking concepts
- Debugging Dockerfile syntax
- Researching best practices for container security
