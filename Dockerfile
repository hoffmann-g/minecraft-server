FROM eclipse-temurin:21-jre-jammy

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create minecraft user for security
RUN useradd -r -m -U -d /minecraft -s /bin/bash minecraft

# Create server directory
WORKDIR /minecraft

# Set up minecraft user permissions for mounted volume
RUN chown minecraft:minecraft /minecraft

# Switch to minecraft user
USER minecraft

# Expose default Minecraft port
EXPOSE 25565

# Environment variables for configuration
ENV MEMORY_MIN=1G
ENV MEMORY_MAX=2G
ENV EULA=true

# Default command
CMD ["/minecraft/start.sh"] 