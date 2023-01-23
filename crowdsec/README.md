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

## Configure crowdsec to use postgres

Create a file `/etc/crowdsec/config.yaml.local` this file will override any settings set within the original `/etc/crowdsec/config.yaml`

```
db_config:
  type: pgx
  user: crowdsec
  password: "INSERTYOURRANDOMGENEREATEDPASSWORDHERE"
  db_name: crowdsec
  host: 127.0.0.1
  port: 5432
  flush:
    max_items: 20000
    max_age: 30d
api:
  server:
    use_forwarded_for_headers: true
```

We set the driver to `pgx` an updated postgres driver for golang. Remeber to update the password to your randomly generated one.

#### migrate.deb.sh

A helper script that can transfer sqlite to postgresql only tested on ubuntu 20.04 LTS