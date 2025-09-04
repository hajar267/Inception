FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server mariadb-client

COPY tools/mariadb.sh /usr/local/bin

RUN chmod +x /usr/local/bin/mariadb.sh

ENTRYPOINT [ "mariadb.sh" ]

#MariaDB Server This is the database engine (mysqld) that: 
	#Stores data on disk.
	#Handles queries.
	#Manages users, privileges, transactions, replication, etc.
#Without the server, there’s no actual database running — it’s 
#just files.


#MariaDB Client This is the command-line tool (mariadb or mysql)
# that lets you connect to a server (local or remote) and run SQL queries.
#It’s separate because:
#You might want to connect to a remote server without running your own server.
#Many apps/scripts use the client binary to send SQL commands.