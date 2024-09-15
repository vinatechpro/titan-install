# Bash Shell Auto Install Titan Node L2 - Cassini Testnet on Ubuntu 22.04

- Main Menu - L2 Edge (version v0.1.20)
```
curl -O https://raw.githubusercontent.com/vinatechpro/titan-install/main/main.sh && chmod u+x main.sh && ./main.sh
```

- Just For Install (version v0.1.20)
```
curl -O https://raw.githubusercontent.com/vinatechpro/titan-install/main/install.sh && chmod u+x install.sh && ./install.sh
```
- Just For Update (version v0.1.20)
```
curl -O https://raw.githubusercontent.com/vinatechpro/titan-install/main/update.sh && chmod u+x update.sh && ./update.sh
```
- Show Info & Config node
```
titan-edge config show && titan-edge info
```
- If errors, delete folder `.titanedge` and reinstall
```
systemctl stop titand.service && rm -rf /root/.titanedge && rm -rf /usr/local/titan
```
------------
- Ref Titan Dashboard: https://test1.titannet.io/intiveRegister?code=CtKlIe
- Telegram Offical: https://t.me/titannet_dao
- Hidden Gems Community (HGC): https://t.me/HGCdotGG
