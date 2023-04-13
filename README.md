# aws-nuke wrapper script
A simple wrapper script over [aws-nuke](https://github.com/rebuy-de/aws-nuke) by [rebuy-de](https://github.com/rebuy-de)

## Pre-requisites
docker

## Usage
This script is designed to quickly factory reset test aws accounts.

**Warning**: It uses the `default` profile credentials in `~/.aws`.

### Command usage
```
./aws-nuke.sh [account_number] [...args]
```

## Example
```bash
# You may need this step:
aws iam create-account-alias --profile default --account-alias abcdeftesting123-account
chmod +x aws-nuke.sh
./aws-nuke.sh 000000000000
./aws-nuke.sh 000000000000 --no-dry-run
```
