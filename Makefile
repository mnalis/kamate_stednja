USER=$(shell find . -maxdepth 1 -name kamate_scrape  -printf %u)

nothing:
	@echo Doing nothing as user=$(USER)...

run:
	if [ "`id -un`" = "$(USER)" ] ; then ./kamate_scrape; else env -i setuidgid $(USER) ./kamate_scrape; fi
update:
	umask 077; if [ "`id -un`" = "$(USER)" ] ; then git pull; else env -i setuidgid $(USER) git pull; fi
	chmod -R a=rX ChartJS *.html *.js COPYING
	chmod 700 *.cgi kamate_scrape

publish:
	git add banks
	git commit -a || true
	git push
