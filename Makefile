all: data

data:
	curl -L --output data.tar.gz https://github.com/chadwickbureau/baseballdatabank/archive/v2018.1.tar.gz
