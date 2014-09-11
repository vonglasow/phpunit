COMPOSER := ./composer
PHP_EXTENSION := $(shell php -m | grep xsl)
GIT := $(shell basename $(shell which git))

vendor: check composer
	@echo 'Install dependencies';
	$(COMPOSER) install
	@echo 'PATH=$$PATH:$(CURDIR)/bin'

update: check composer
	@echo 'Update vendor';
	$(COMPOSER) update

check:
	@echo 'Check dependencies'
ifeq ($(PHP_EXTENSION)$(GIT),xslgit)
	@echo 'Dependencies are installed!'
else
	@echo 'Please install php5-xsl, git before'
	@exit 2
endif

composer:
	@echo 'Install composer';
	$(shell curl -sS https://getcomposer.org/installer | php > /dev/null 2>&1)
	$(shell mv ./composer.phar composer)

clean:
	@echo 'Remove vendor folder and composer'
	rm -rf vendor
	rm -rf composer
	rm -rf bin

.PHONY: clean update check help

