SCRIPT_NAME=$(basename "$0")
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
TEMP_CONFIG_FILEPATH=$(realpath .nuke-config.yml)
PROFILE=default
ACCOUNT_NUMBER=$1
shift

function print_usage() {
    echo "Usage: $SCRIPT_NAME [account_number] [...args]"
}

if ! command -v docker &> /dev/null;
then
    echo "Fatal: Cannot find docker command"
    exit 1
fi

if [ -z "$ACCOUNT_NUMBER" ]; then
    echo "Fatal: Missing required argument 'account_number'"
    print_usage
    exit 1
fi

NUKE_CONFIG=$(cat <<-EOM
regions:
- eu-west-2

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
