SCRIPT_NAME=$(basename "$0")
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
TEMP_CONFIG_FILEPATH=$(realpath .nuke-config.yml)
PROFILE=$1
REGION=$2
shift 2

function print_usage() {
    echo "Usage: $SCRIPT_NAME <profile> <region> [options]"
}

if ! command -v aws &> /dev/null;
then
    echo "Error: Cannot find aws command, please install awscli"
    exit 1
fi

if ! command -v docker &> /dev/null;
then
    echo "Error: Cannot find docker command, please install docker"
    exit 1
fi

if [ -z "$PROFILE" ]; then
    echo "Error: Missing required argument 'profile'"
    print_usage
    exit 1
fi

if [ -z "$REGION" ]; then
    echo "Error: Missing required argument 'region'"
    print_usage
    exit 1
fi

ACCOUNT_NUMBER=$(aws sts get-caller-identity --region $REGION --query Account --output text)
NUKE_CONFIG=$(cat <<-EOM
regions:
- $REGION

account-blocklist:
- "999999999999" # production

accounts:
  "$ACCOUNT_NUMBER": {}
EOM
)

echo "$NUKE_CONFIG" > $TEMP_CONFIG_FILEPATH

docker run \
    --rm -it \
    -v $TEMP_CONFIG_FILEPATH:/home/aws-nuke/config.yml \
    -v /home/$USER/.aws:/home/aws-nuke/.aws \
    quay.io/rebuy/aws-nuke:latest \
    --profile $PROFILE \
    --config /home/aws-nuke/config.yml \
    "$@"

rm $TEMP_CONFIG_FILEPATH
