USER=$(shell find . -maxdepth 1 -name kamate_scrape  -printf %u)

nothing:
	@echo Doing nothing as user=$(USER)...

run:
	if [ "`id -un`" = "$(USER)" ] ; then ./kamate_scrape; else setuidgid $(USER) ./kamate_scrape; fi
update:
	if [ "`id -un`" = "$(USER)" ] ; then git pull; else setuidgid $(USER) git pull; fi

publish:
	git commit -a || true
	git push
