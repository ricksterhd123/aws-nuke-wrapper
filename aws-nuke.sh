
if ! command -v docker &> /dev/null;
then
    echo "Cannot find docker command"
    exit 1
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
CONFIG_DIR=$SCRIPT_DIR/nuke-config.yml
PROFILE=default

docker run \
    --rm -it \
    -v $CONFIG_DIR:/home/aws-nuke/config.yml \
    -v /home/$USER/.aws:/home/aws-nuke/.aws \
    quay.io/rebuy/aws-nuke:latest \
    --profile $PROFILE \
    --config /home/aws-nuke/config.yml \
    "$@"
