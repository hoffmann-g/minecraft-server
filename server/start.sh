#!/bin/bash

# Create eula.txt if it doesn't exist
if [ ! -f eula.txt ]; then
    echo "eula=true" > eula.txt
fi

# Start Minecraft server
echo "Starting Minecraft server..."
echo "Minimum memory: $MEMORY_MIN"
echo "Maximum memory: $MEMORY_MAX"

java -Xms$MEMORY_MIN -Xmx$MEMORY_MAX \
     -XX:+UseG1GC \
     -XX:+ParallelRefProcEnabled \
     -XX:MaxGCPauseMillis=200 \
     -XX:+UnlockExperimentalVMOptions \
     -XX:+DisableExplicitGC \
     -XX:+AlwaysPreTouch \
     -XX:G1NewSizePercent=30 \
     -XX:G1MaxNewSizePercent=40 \
     -XX:G1HeapRegionSize=8M \
     -XX:G1ReservePercent=20 \
     -XX:G1MixedGCCountTarget=8 \
     -XX:InitiatingHeapOccupancyPercent=15 \
     -XX:G1MixedGCLiveThresholdPercent=90 \
     -XX:G1RSetUpdatingPauseTimePercent=5 \
     -XX:SurvivorRatio=32 \
     -XX:+PerfDisableSharedMem \
     -XX:MaxTenuringThreshold=1 \
     -jar server.jar nogui 
