IMAGE=ninjasphere/ninjasphere
BINARIES=\
sphere-go-homecloud \
mqtt-bridgeify \
sphere-go-homecloud \
sphere-client \
sphere-director \
sphere-ui

all: build

build: sphere-config sphere-schemas $(BINARIES)
	docker build -t $(IMAGE) .

sphere-config:
	git clone https://github.com/ninjasphere/sphere-config.git

sphere-schemas:
	git clone https://github.com/ninjasphere/schemas.git sphere-schemas

sphere-client:
	bash build-binary.sh ninjasphere/sphere-client

sphere-director:
	bash build-binary.sh ninjasphere/sphere-director

sphere-go-homecloud:
	bash build-binary.sh ninjasphere/sphere-go-homecloud

mqtt-bridgeify:
	bash build-binary.sh ninjablocks/mqtt-bridgeify

sphere-ui:
	bash build-binary.sh ninjasphere/sphere-ui

clean:
	rm -rf sphere-config sphere-schemas $(BINARIES) bin-*
