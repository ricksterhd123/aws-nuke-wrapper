# aws-nuke wrapper script
Used to factory reset test aws account

## Pre-requisites
docker

## Usage
Warning: The script uses the `default` profile in `~/.aws`

Simply add your account in the nuke-config.yml, e.g.
```yaml
accounts:
  "000000000000": {}
```
or refer to the  [aws-nuke usage guide](https://github.com/rebuy-de/aws-nuke#usage)

```bash
# You may need this step:
aws iam create-account-alias --profile default --account-alias abcdeftesting123-account
chmod +x aws-nuke.sh
./aws-nuke.sh
./aws-nuke.sh --no-dry-run
```

This script wraps [aws-nuke](https://github.com/rebuy-de/aws-nuke) by [rebuy-de](https://github.com/rebuy-de)
