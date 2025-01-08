# Auto Install Titan Agent - Galileo Testnet - Titan Network

## Minimum Hardware Requirements:

| CPU     | Memory | Storage Space | Upstream Bandwidth | NAT          |
|---------|--------|---------------|--------------------|--------------|
| CPU 2v  | RAM 2G | SSD 50G+      | 10Mbps+             | TCP1,2,3 UDP1,2,3 |

**Recommended:**

*   **CPU:** 4 cores or more
*   **Memory:** 6 GB RAM or more

## Install
```
curl -O https://raw.githubusercontent.com/vinatechpro/titan-install/refs/heads/main/agent/main.sh && chmod u+x main.sh && ./main.sh --key=your_key_here --ver=en
```
**Get your key**: `--key=your_key_here`

*Please follow document for get your key:* https://titannet.gitbook.io/titan-network-en/galileo-testnet/node-participation-guide/run-titan-agent-on-linux#id-2.-get-your-key

## Uninstall 
```
curl -O https://raw.githubusercontent.com/vinatechpro/titan-install/refs/heads/main/agent/rm.sh && chmod u+x rm.sh && ./rm.sh --ver=en
```

**Supported languages:**

*   **Vietnamese:** `--ver=vi`
*   **English:** `--ver=en`
*   **Russian:** `--ver=ru`
*   **Indonesian:** `--ver=id`



