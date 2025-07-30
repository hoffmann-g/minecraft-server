# Minecraft Server Docker

This project configures a Minecraft server using Docker with optimized settings.

## Prerequisites

- Docker
- Docker Compose
- Minecraft `server.jar` file (already included)

## Setup

### 1. Build and start the server

```bash
# Build Docker image
docker-compose build

# Start the server
docker-compose up -d
```

### 2. Check logs

```bash
# View real-time logs
docker-compose logs -f

# View container logs
docker logs minecraft-server
```

### 3. Access server console

```bash
# Enter container for administrative commands
docker exec -it minecraft-server bash

# Or use console directly
docker attach minecraft-server
```

## Configuration

### Memory
By default, the server uses:
- Minimum memory: 1GB
- Maximum memory: 2GB

To change, edit `docker-compose.yml`:

```yaml
environment:
  - MEMORY_MIN=2G
  - MEMORY_MAX=4G
```

### Port
The server runs on the default port `25565`. To change:

```yaml
ports:
  - "25566:25565"  # Maps external port 25566 to internal 25565
```

## Volumes

Server data is persisted in the `minecraft_data` volume:
- Game world
- Plugins (if added)
- Configurations
- Logs

## Useful Commands

```bash
# Stop the server
docker-compose down

# Stop and remove volumes (WARNING: deletes world data)
docker-compose down -v

# Restart the server
docker-compose restart

# Rebuild after changes
docker-compose up -d --build
```

## Backup

To backup data:

```bash
# Backup volume
docker run --rm -v minecraft-server_minecraft_data:/data -v $(pwd):/backup alpine tar czf /backup/minecraft-backup-$(date +%Y%m%d).tar.gz -C /data .

# Restore backup
docker run --rm -v minecraft-server_minecraft_data:/data -v $(pwd):/backup alpine tar xzf /backup/minecraft-backup-YYYYMMDD.tar.gz -C /data
```

## Troubleshooting

### Server won't start
1. Check if port 25565 is free
2. Confirm that `server.jar` file exists
3. Check logs: `docker-compose logs`

### Memory issues
1. Increase memory in `docker-compose.yml`
2. Check if there's enough RAM on the host

### Connectivity issues
1. Check if firewall allows port 25565
2. Confirm IP is correct in Minecraft client

## Customization

### Adding plugins
1. Create a `plugins` folder in the project
2. Add plugin .jar files
3. Modify Dockerfile to copy plugins

### Configure server.properties
The server will create a `server.properties` file automatically on first run. You can edit this file to customize server settings.

## Security

- Server runs as `minecraft` user (not root)
- Automatically accepts EULA
- Default secure settings

## Support

For issues or questions, check:
1. Container logs
2. `server.properties` settings
3. System resources (CPU, RAM, disk) 