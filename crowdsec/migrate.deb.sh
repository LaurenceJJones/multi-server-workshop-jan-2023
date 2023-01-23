##Only tested on ubuntu systems
sudo apt install postgresql postgresql-contrib -y
sudo systemctl start postgresql.service
TEMP_DIR=$(mktemp -d)
RANDOM_PASS=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 20)
echo "db_config:
  type: pgx
  user: crowdsec
  password: \"$RANDOM_PASS\" ##Randomly generate password
  db_name: crowdsec
  host: 127.0.0.1
  port: 5432
  flush:
    max_items: 20000
    max_age: 30d
#api:
  #server:
    #use_forwarded_for_headers: true" > /etc/crowdsec/config.yaml.local
sleep 3
sudo -i -u postgres psql -c "CREATE DATABASE crowdsec;"
sudo -i -u postgres psql -c "CREATE USER crowdsec WITH PASSWORD '$RANDOM_PASS';"
sudo -i -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE crowdsec TO crowdsec;"
sudo cscli machines add -a
sudo systemctl restart crowdsec.service
rm -rf $TEMP_DIR