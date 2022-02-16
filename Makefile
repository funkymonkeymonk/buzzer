FILES=`cat env`
.PHONY: list

list:
	@sh -c "$(MAKE) -p no_op__ | \
		awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);\
		for(i in A)print A[i]}' | \
		grep -v '__\$$' | \
		grep -v 'make\[1\]' | \
		grep -v 'Makefile' | \
		sort"

# required for list
no_op__:

clean:
	rm -rf build

build: clean
	faas-cli build -f buzzer.yml

publish:
	faas-cli publish -f ./buzzer.yml --platforms linux/arm,linux/arm64

deploy:
	faas-cli deploy -f ./buzzer.yml --gateway http://192.168.1.23:8080

logs:
	faas-cli logs -f ./buzzer.yml --gateway http://192.168.1.23:8080 buzzer