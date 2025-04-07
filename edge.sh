#!/bin/bash

# Function to display colored text
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if the script is run as root
if [[ "$(id -u)" -ne "0" ]]; then
    echo -e "${YELLOW}This script requires root access.${NC}"
    echo -e "${YELLOW}Please enter root mode using 'sudo -i', then rerun this script.${NC}"
    exit 1
fi

# Increase UDP buffer sizes for better performance
increase_udp_buffers() {
    echo -e "${YELLOW}Increasing UDP buffer sizes for better performance...${NC}"
    
    # Current values
    echo -e "${BLUE}Current UDP buffer values:${NC}"
    echo "net.core.rmem_max: $(sysctl -n net.core.rmem_max)"
    echo "net.core.wmem_max: $(sysctl -n net.core.wmem_max)"
    
    # Increase UDP buffer sizes
    sysctl -w net.core.rmem_max=2500000 > /dev/null
    sysctl -w net.core.wmem_max=2500000 > /dev/null
    
    # Make changes persistent
    if ! grep -q "net.core.rmem_max" /etc/sysctl.conf; then
        echo "net.core.rmem_max=2500000" >> /etc/sysctl.conf
    else
        sed -i 's/net.core.rmem_max=[0-9]*/net.core.rmem_max=2500000/' /etc/sysctl.conf
    fi
    
    if ! grep -q "net.core.wmem_max" /etc/sysctl.conf; then
        echo "net.core.wmem_max=2500000" >> /etc/sysctl.conf
    else
        sed -i 's/net.core.wmem_max=[0-9]*/net.core.wmem_max=2500000/' /etc/sysctl.conf
    fi
    
    # New values
    echo -e "${BLUE}New UDP buffer values:${NC}"
    echo "net.core.rmem_max: $(sysctl -n net.core.rmem_max)"
    echo "net.core.wmem_max: $(sysctl -n net.core.wmem_max)"
    
    echo -e "${GREEN}✓ UDP buffer sizes increased.${NC}"
}

# Apply UDP buffer size increase
increase_udp_buffers


# Check for remove parameter
if [[ "$1" == "rm" || "$1" == "remove" || "$1" == "-rm" || "$1" == "--rm" ]]; then
    echo -e "${YELLOW}⚠️ Removing all Titan Edge containers, volumes and directories...${NC}"
    
    # Stop and remove all titan-edge containers
    echo -e "${YELLOW}Stopping and removing containers...${NC}"
    titan_containers=$(docker ps -a --filter "name=titan-edge" --format "{{.Names}}")
    
    if [[ -n "$titan_containers" ]]; then
        for container in $titan_containers; do
            echo -e "Removing container ${container}..."
            docker stop "$container" >/dev/null 2>&1
            docker rm -f "$container" >/dev/null 2>&1
        done
        echo -e "${GREEN}✓ All Titan Edge containers removed.${NC}"
    else
        echo -e "${YELLOW}No Titan Edge containers found.${NC}"
    fi
    
    # Remove the titan-edge directories
    echo -e "${YELLOW}Removing Titan Edge directories...${NC}"
    if [[ -d "/root/titan-edge" ]]; then
        rm -rf /root/titan-edge
        echo -e "${GREEN}✓ Directory /root/titan-edge removed.${NC}"
    else
        echo -e "${YELLOW}Directory /root/titan-edge not found.${NC}"
    fi
    
    # Check and remove any other titan edge related directories
    if [[ -d "/root/.titanedge" ]]; then
        rm -rf /root/.titanedge
        echo -e "${GREEN}✓ Directory /root/.titanedge removed.${NC}"
    fi
    
    # Remove titan-related docker volumes (if any)
    echo -e "${YELLOW}Checking for Titan Edge related Docker volumes...${NC}"
    titan_volumes=$(docker volume ls --filter "name=titan" --format "{{.Name}}" 2>/dev/null)
    
    if [[ -n "$titan_volumes" ]]; then
        for volume in $titan_volumes; do
            echo -e "Removing volume ${volume}..."
            docker volume rm "$volume" >/dev/null 2>&1
        done
        echo -e "${GREEN}✓ All Titan Edge volumes removed.${NC}"
    else
        echo -e "${YELLOW}No Titan Edge volumes found.${NC}"
    fi
    
    echo -e "${GREEN}🧹 Cleanup complete! All Titan Edge resources have been removed.${NC}"
    exit 0
fi

# Get hash value from command line argument
hash_value="${1:-}"

# Get node count from command line argument, default to 5
node_count="${2:-5}"

# Check if hash_value is empty
if [[ -z "$hash_value" ]]; then
    echo -e "${YELLOW}No hash value provided via command line. Please provide a hash value when running this script. ${NC}"
    echo -e "${YELLOW}Or use 'rm' parameter to remove all Titan Edge containers and directories. ${NC}"
    echo -e "${YELLOW}Usage: $0 <hash_value> [node_count]${NC}"
    echo -e "${YELLOW}       $0 rm${NC}"
    exit 1
fi

# Validate node count, ensure between 1 and 5
if ! [[ "$node_count" =~ ^[1-5]$ ]]; then
    echo -e "${YELLOW}Invalid node count provided. Please provide a node count between 1 and 5.${NC}"
    echo -e "${YELLOW}Running with default node count : 5.${NC}"
    node_count=5
fi

# Configuration
IMAGE_NAME="laodauhgc/titan-edge"
STORAGE_GB=50
START_PORT=1235
TOTAL_NODES=$node_count  # Renamed for clarity
TITAN_EDGE_DIR="/root/titan-edge"
BIND_URL="https://api-test1.container1.titannet.io/api/v2/device/binding"

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to install Docker
install_docker() {
    echo -e "${GREEN}Installing Docker...${NC}"

    if command_exists apt-get; then
        apt-get update && apt-get install -y ca-certificates curl gnupg lsb-release docker.io
    elif command_exists yum; then
        yum install -y yum-utils docker
    elif command_exists dnf; then
        dnf install -y docker
    elif command_exists pacman; then
        pacman -S --noconfirm docker
    else
        echo -e "${RED}Could not determine package manager. Please install Docker manually.${NC}"
        exit 1
    fi

    systemctl start docker
    systemctl enable docker

    if [[ $? -ne 0 ]]; then
        echo -e "${RED}Failed to install or start Docker.${NC}"
        exit 1
    fi
}

# Check if Docker is installed
if ! command_exists docker; then
    install_docker
else
    echo -e "${GREEN}Docker is already installed.${NC}"
fi

# Pull the Docker image
echo -e "${GREEN}Pulling the Docker image ${IMAGE_NAME}...${NC}"
docker pull "$IMAGE_NAME"
if [[ $? -ne 0 ]]; then
    echo -e "${RED}Failed to pull Docker image.${NC}"
    exit 1
fi

# Create Titan Edge directory
mkdir -p "$TITAN_EDGE_DIR"
if [[ $? -ne 0 ]]; then
    echo -e "${RED}Failed to create Titan Edge directory.${NC}"
    exit 1
fi

# Function to check if container is ready
check_container_ready() {
    local container_name=$1
    local max_attempts=30
    local wait_seconds=2
    
    echo -e "${YELLOW}Waiting for container ${container_name} to be ready...${NC}"
    
    for ((i=1; i<=max_attempts; i++)); do
        # Check container status
        status=$(docker inspect -f '{{.State.Status}}' "$container_name" 2>/dev/null)
        
        if [[ "$status" == "running" ]]; then
            # Check if config.toml exists
            if docker exec "$container_name" test -f /root/.titanedge/config.toml; then
                echo -e "${GREEN}✓ Container ${container_name} is ready with config.toml!${NC}"
                return 0
            else
                echo -e "${YELLOW}Container ${container_name} is running but config.toml not found yet... Attempt $i/$max_attempts${NC}"
            fi
        elif [[ "$status" == "restarting" ]]; then
            echo -e "${YELLOW}Container ${container_name} is restarting... Attempt $i/$max_attempts${NC}"
            
            # Show logs if container is restarting and we've waited a while
            if [[ $i -eq 10 ]]; then
                echo -e "${RED}Container is restarting. Showing logs:${NC}"
                docker logs "$container_name"
            fi
        else
            echo -e "${YELLOW}Container ${container_name} status: $status ... Attempt $i/$max_attempts${NC}"
        fi
        
        sleep $wait_seconds
    done
    
    echo -e "${RED}Container ${container_name} failed to become ready after $((max_attempts * wait_seconds)) seconds.${NC}"
    docker logs "$container_name"
    return 1
}

# Check existing nodes and determine which ones need to be created
existing_nodes=()
for ((i=1; i<=5; i++)); do
    container_name="titan-edge-0${i}"
    if docker ps -a --format '{{.Names}}' | grep -q "^$container_name$"; then
        container_status=$(docker inspect -f '{{.State.Status}}' "$container_name" 2>/dev/null)
        if [[ "$container_status" == "running" ]]; then
            existing_nodes+=($i)
            echo -e "${BLUE}INFO: Node ${container_name} already exists and is running.${NC}"
        fi
    fi
done

existing_count=${#existing_nodes[@]}
nodes_to_create=$((TOTAL_NODES - existing_count))

if [[ $nodes_to_create -le 0 ]]; then
    echo -e "${GREEN}✓ You already have $existing_count nodes running, which meets or exceeds your requested count of $TOTAL_NODES.${NC}"
    echo -e "${GREEN}✓ No new nodes will be created.${NC}"
    
    # List existing nodes
    echo -e "${YELLOW}Existing nodes:${NC}"
    for index in "${existing_nodes[@]}"; do
        echo -e "  - titan-edge-0${index}"
    done
    
    exit 0
fi

echo -e "${BLUE}INFO: Found $existing_count existing nodes. Will create $nodes_to_create additional nodes to reach a total of $TOTAL_NODES.${NC}"

# Find the next available node number
next_node=1
for ((next_node=1; next_node<=5; next_node++)); do
    found=0
    for existing in "${existing_nodes[@]}"; do
        if [[ "$existing" -eq "$next_node" ]]; then
            found=1
            break
        fi
    done
    if [[ "$found" -eq 0 ]]; then
        break
    fi
done

# Create the additional nodes
created_count=0
while [[ $created_count -lt $nodes_to_create && $next_node -le 5 ]]; do
    # Define storage path, container name and current port
    STORAGE_PATH="$TITAN_EDGE_DIR/titan-edge-0${next_node}"
    CONTAINER_NAME="titan-edge-0${next_node}"
    CURRENT_PORT=$((START_PORT + next_node - 1))

    echo -e "${GREEN}Setting up node ${CONTAINER_NAME} on port ${CURRENT_PORT}...${NC}"

    # Clean up if container already exists but is not running
    if docker ps -a --format '{{.Names}}' | grep -q "^$CONTAINER_NAME$"; then
        container_status=$(docker inspect -f '{{.State.Status}}' "$CONTAINER_NAME" 2>/dev/null)
        if [[ "$container_status" != "running" ]]; then
            echo -e "${YELLOW}Container ${CONTAINER_NAME} exists but is not running. Removing it...${NC}"
            docker rm -f "$CONTAINER_NAME" >/dev/null 2>&1
        else
            echo -e "${YELLOW}Container ${CONTAINER_NAME} already exists and is running. Skipping...${NC}"
            next_node=$((next_node + 1))
            continue
        fi
    fi

    # Ensure storage path exists with proper permissions
    mkdir -p "$STORAGE_PATH/.titanedge"
    if [[ $? -ne 0 ]]; then
        echo -e "${RED}Failed to create storage path for container ${CONTAINER_NAME}.${NC}"
        exit 1
    fi

    # Run the container - open both TCP and UDP ports
    echo -e "${YELLOW}Starting container ${CONTAINER_NAME}...${NC}"
    docker run -d \
        --name "$CONTAINER_NAME" \
        -v "$STORAGE_PATH/.titanedge:/root/.titanedge" \
        -p "$CURRENT_PORT:$CURRENT_PORT/tcp" \
        -p "$CURRENT_PORT:$CURRENT_PORT/udp" \
        --restart always \
        "$IMAGE_NAME"

    if [[ $? -ne 0 ]]; then
        echo -e "${RED}Failed to start container ${CONTAINER_NAME}.${NC}"
        exit 1
    fi
    
    # Wait for container to be ready and config.toml to be generated
    # No need to start daemon manually as it's already running in the container
    echo -e "${YELLOW}Waiting for daemon to initialize in ${CONTAINER_NAME}...${NC}"
    check_container_ready "$CONTAINER_NAME"
    if [[ $? -ne 0 ]]; then
        echo -e "${RED}Failed to confirm container ${CONTAINER_NAME} is ready. Stopping script.${NC}"
        exit 1
    fi

    # Modify config.toml to set the port and storage size
    echo -e "${YELLOW}Configuring port ${CURRENT_PORT} and storage for ${CONTAINER_NAME}...${NC}"
    docker exec "$CONTAINER_NAME" bash -c "sed -i 's/^[[:space:]]*#StorageGB = .*/StorageGB = $STORAGE_GB/' /root/.titanedge/config.toml && \
                                         sed -i 's/^[[:space:]]*#ListenAddress = \"0.0.0.0:1234\"/ListenAddress = \"0.0.0.0:$CURRENT_PORT\"/' /root/.titanedge/config.toml"
    if [[ $? -ne 0 ]]; then
        echo -e "${RED}Failed to configure port and storage for ${CONTAINER_NAME}.${NC}"
        exit 1
    fi

    # Restart container to apply new configuration
    echo -e "${YELLOW}Restarting ${CONTAINER_NAME} to apply configuration...${NC}"
    docker restart "$CONTAINER_NAME"
    if [[ $? -ne 0 ]]; then
        echo -e "${RED}Failed to restart ${CONTAINER_NAME}.${NC}"
        exit 1
    fi

    # Wait for container to be ready again
    sleep 10
    check_container_ready "$CONTAINER_NAME"
    if [[ $? -ne 0 ]]; then
        echo -e "${RED}Failed to confirm container ${CONTAINER_NAME} is ready after restart. Stopping script.${NC}"
        exit 1
    fi

    # Bind the node
    echo -e "${YELLOW}Binding ${CONTAINER_NAME} to Titan network...${NC}"
    docker exec "$CONTAINER_NAME" titan-edge bind --hash="$hash_value" "$BIND_URL"
    if [[ $? -ne 0 ]]; then
        echo -e "${RED}Failed to bind node ${CONTAINER_NAME}.${NC}"
        exit 1
    fi

    echo -e "${GREEN}✓ Node ${CONTAINER_NAME} has been successfully initialized.${NC}"
    
    created_count=$((created_count + 1))
    next_node=$((next_node + 1))
done

total_active_nodes=$((existing_count + created_count))
echo -e "${GREEN}🚀 All done! You now have ${total_active_nodes} Titan Edge nodes running.${NC}"

# Display instructions for checking node status
echo -e "${YELLOW}To check the status of your nodes, run:${NC}"
echo -e "    docker ps -a"
echo -e "${YELLOW}To view logs of a specific node, run:${NC}"
echo -e "    docker logs titan-edge-0<number>"
echo -e "${YELLOW}To enter a node's shell, run:${NC}"
echo -e "    docker exec -it titan-edge-0<number> bash"

exit 0
