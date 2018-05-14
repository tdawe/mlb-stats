all: data

data:
	curl -L --output data.tar.gz https://github.com/chadwickbureau/baseballdatabank/archive/v2018.1.tar.gz
	pip install --user csvs-to-sqlite
	tar -xzvf data.tar.gz
	csvs-to-sqlite baseballdatabank*/core/*.csv database.db
	sqlite3 --init custom.sql database.db

clean:
	rm -rf baseballdatabank* database.db data.tar.gz
