USER=$(shell find . -maxdepth 1 -name kamate_scrape  -printf %u)

nothing:
	@echo Doing nothing as user=$(USER)...

update:
	if [ "`id -un`" = "$(USER)" ] ; then git pull; else setuidgid $(USER) git pull; fi

publish:
	git commit -a || true
	git push
