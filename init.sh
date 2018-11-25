#!/bin/bash
#find /var/lib/mysql -type f -exec touch {} \; && \
#/etc/init.d/mysql start && \
#mysql -u root -e "GRANT ALL ON druid.* TO 'druid'@'localhost' IDENTIFIED BY 'diurd'; CREATE database druid CHARACTER SET utf8;" && \
java -cp /usr/local/druid/lib/druid-services-*-selfcontained.jar -Ddruid.extensions.directory=/usr/local/druid/extensions -Ddruid.extensions.loadList=[\"postgresql-metadata-storage\"] -Ddruid.metadata.storage.type=postgresql io.druid.cli.Main tools metadata-init --connectURI="jdbc:postgresql://$DRUID_POSTGRESQL_IP:5432/druid" --user=druid --password=diurd  #&& \
#mysql -u root druid < /sample-data.sql && /etc/init.d/mysql stop