
REPO=$1
DIR=$(basename $REPO)

if [ ! -d $DIR ]; then
	git clone git@github.com:${REPO}.git $DIR
fi

pushd $DIR
git pull
popd

# Linux 64 Bit
# ARM 6 for Raspberry Pi
# ARM 7 for Raspberry Pi 2 & Beagle Bone
# Windows 386 for 32 Bit 
# Windows amd64 for 64 Bit 


PLATFORMS="linux/amd64 linux/arm/6 linux/arm/7 windows/386 windows/amd64"

for PLATFORM in $PLATFORMS; do
	
	IFS='/' read -a array <<< "$PLATFORM"

	export GOOS=${array[0]}
	export GOARCH=${array[1]}
	export GOVER=${array[2]}
	export BINFILE=bin-$GOOS-$GOARCH${GOVER:+-$GOVER}

	echo '====================='
	echo '===B=U=I=L=D=I=N=G==='
	echo '====================='
	echo 'PLATORM: ' $PLATFORM
	echo '====================='
	echo 'GOOS   : ' $GOOS
	echo 'GOARCH : ' $GOARCH
	echo 'GOVER  : ' ${GOVER:-'N/A'}
	echo 'BINFILE: ' $BINFILE
	echo '====================='
	echo '====================='
	echo '====================='

	pushd $DIR
	test -f ./scripts/build.sh && ./scripts/build.sh
	popd
	mkdir -p $BINFILE
	cp $DIR/bin/* $BINFILE/
done

