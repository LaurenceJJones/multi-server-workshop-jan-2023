## Crowdsec

Here are the configuration override files for the main LAPI. When crowdsec runs it will merge `config.yaml` and `config.yaml.local` inside the same configuration tree, however, one in `local` take importance over ones in base `config.yaml`

## generate a random password using:
```
tr -dc A-Za-z0-9 </dev/urandom | head -c 20 ; echo ''
```
If you want to make the password longer or shorter alter the `20` in the command :smile:

## Postgresql command

On ubuntu there a dedicated postgres user so you must switch before you can access postgres `sudo -i --u postgres`

```
postgres=# CREATE DATABASE crowdsec;
postgres=# CREATE USER crowdsec WITH PASSWORD 'INSERTYOURRANDOMGENEREATEDPASSWORDHERE';
postgres=# GRANT ALL PRIVILEGES ON DATABASE crowdsec TO crowdsec;
```

If you mess up and set the password as not the password you generated you can run
```
postgres=# ALTER USER crowdsec WITH PASSWORD 'INSERTYOURRANDOMGENEREATEDPASSWORDHERE';
```

and if you still mess that up then I cant help you :wink:

#### migrate.deb.sh

A helper script that can transfer sqlite to postgresql with all current decisions