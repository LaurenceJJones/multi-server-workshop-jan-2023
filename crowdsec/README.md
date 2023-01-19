## Crowdsec

Here are the configuration override files for the main LAPI. When crowdsec runs it will merge `config.yaml` and `config.yaml.local` inside the same configuration tree, however, one in `local` take importance over ones in base `config.yaml`

## generate a random password using:
```
< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-20};echo;
```
If you want to make the password longer or shorter alter the `20` in the command :smile:
