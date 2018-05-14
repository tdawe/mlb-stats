all: data

data:
	curl -L --output data.tar.gz https://github.com/chadwickbureau/baseballdatabank/archive/v2018.1.tar.gz
	pip install --user csvs-to-sqlite
	tar -xzvf data.tar.gz
	csvs-to-sqlite baseballdatabank*/core/*.csv database.db
	echo .quit | sqlite3 -init custom.sql database.db

sample:
	./batting.sh 1992 TOR

clean:
	rm -rf baseballdatabank* database.db data.tar.gz
