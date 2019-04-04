.DEFAULT_GOAL := help
socket="unix:///var/run/yggdrasil.sock"

public-peers: ## Extract public peers
	git clone https://github.com/yggdrasil-network/public-peers 
	find public-peers -type f -exec grep tcp {} \;|tr -d '`*'|awk '{print $1}'

get-dht: ## Extract ipv6 from DHT
	yggdrasilctl getDHT | ./filters/extract_ipv6.sh

get-dht-peers: ## Extract ipv6 from DHT peers
	yggdrasilctl -json -v getDHT|jq '.dht|.[]|[.box_pub_key,.coords]|@csv' |  awk -F "\"*,\"*" '{print "yggdrasilctl getPeers box_pub_key="$1" coords="$2}' |./filters/extract_ipv6.sh

requirements: ## Install ansible requirements
	ansible-galaxy install -r requirements.yml -p roles --ignore-errors --force

ping: ## Ping hosts with ansible
	ansible all -m ping

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
