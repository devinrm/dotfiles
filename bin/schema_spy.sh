#!/bin/sh

set -e

echo "===============================================================================================================
If you don't already have Java installed, paste this command into your terminal and install the dmg:
--------------------------------------------------------------------------------------------------------------
curl -L -b 'oraclelicense=a' http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/jdk-9.0.1_osx-x64_bin.dmg -O
--------------------------------------------------------------------------------------------------------------
==============================================================================================================="

echo What is your postgresql username?
read -r username

echo What is the name of the database you would like to import?
read -r database

cd "$HOME"
mkdir "$database"_schema_spy
cd "$database"_schema_spy

curl -s https://api.github.com/repos/schemaspy/schemaspy/releases/latest \
  | grep browser_download_url \
  | cut -d '"' -f 4 \
  | wget -qi -

curl -O https://jdbc.postgresql.org/download/postgresql-42.1.4.jar
curl -O https://graphviz.gitlab.io/pub/graphviz/stable/SOURCES/graphviz.tar.gz

tar -zxvf graphviz.tar.gz
cd graphviz-2.40.1
./configure
make
make install

cd "$HOME/$database"_schema_spy
java -jar schemaspy-6.0.0-rc2.jar -t pgsql -s public -db "$database" -u "$username" -host localhost -o "$database" -dp "$HOME/$database"_schema_spy/postgresql-42.1.4.jar

echo Open "$HOME"/"$database"_schema_spy/"$database"/index.html to view SchemaSpy dashboard.
