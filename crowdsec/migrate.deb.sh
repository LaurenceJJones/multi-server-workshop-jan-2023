sudo apt install postgresql postgresql-contrib -y
sudo systemctl start postgresql.service
TEMP_DIR=$(mktemp -d)
RANDOM_PASS=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 20)
sudo cscli -oraw decisions list 2>1 > "$TEMP_DIR/decisions.csv"
echo "db_config:
  type: pgx
  user: crowdsec
  password: \"$RANDOM_PASS\" ##DO NOT REUSE MY PASSOWRD SEE README
  db_name: crowdsec
  host: 127.0.0.1
  port: 5432
  flush:
    max_items: 20000
    max_age: 30d
api:
  server:
    use_forwarded_for_headers: true" > /etc/crowdsec/config.yaml.local
sleep 5
sudo su postgres -c "psql -c \"CREATE DATABASE crowdsec;\""
sudo su postgres -c "psql -c \"CREATE USER crowdsec WITH PASSWORD '$RANDOM_PASS';\""
sudo su postgres -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE crowdsec TO crowdsec;\""
sudo cscli machines add -a
sudo systemctl restart crowdsec.service
sudo cscli decisions import -i "$TEMP_DIR/decisions.csv"
rm -rf $TEMP_DIR