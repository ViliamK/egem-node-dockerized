image: build

go-egem:
	@git clone https://git.egem.io/team/go-egem.git
	@cp Dockerfile go-egem/

env: go-egem
	$(eval DOC_GIT_REF=$(shell git rev-parse --short HEAD))
	@cd go-egem; $(eval EGEM_GIT_REF=$(shell git rev-parse --short HEAD))
	$(eval GIT_REF=$(shell echo ${DOC_GIT_REF})$(shell echo ${EGEM_GIT_REF}))

build: env
	@echo building ethergem:${GIT_REF}
	@cd go-egem; docker build -f Dockerfile -t ethergem:${GIT_REF} .

daemon: build
	@docker run -p 8895:8895 -p 30666:30666 -p 30666:30666/udp --mount source=ethergem,target=/root ethergem:${GIT_REF} --maxpendpeers 50 --maxpeers 1000 --rpc --rpcport 8895 --port 30666 --rpcapi "eth,net,web3" --rpcaddr "0.0.0.0" --rpccorsdomain "*"

node: daemon

interactive: build
	@docker run -i --mount source=ethergem,target=/root ethergem:${GIT_REF} attach

attach: interactive

console: interactive

