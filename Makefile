USER=$(shell find . -maxdepth 1 -name kamate_scrape  -printf %u)
NB_SQL="select (select max(pct10) from kamate  where datum=(select distinct datum from kamate order by datum desc limit 1,1)) as old,(select max(pct10) from kamate  where datum=(select distinct datum from kamate order by datum desc limit 1)) as new where new > old;"

nothing:
	@echo Doing nothing as user=$(USER)...

run:
	if [ "`id -un`" = "$(USER)" ] ; then ./kamate_scrape; else env -i setuidgid $(USER) ./kamate_scrape; fi

newbest:
	if [ "`id -un`" = "$(USER)" ] ; then echo $(NB_SQL) | sqlite3 kamate.db; else env -i setuidgid $(USER) echo $(NB_SQL) | sqlite3 kamate.db; fi

update:
	umask 077; if [ "`id -un`" = "$(USER)" ] ; then git pull; else env -i setuidgid $(USER) git pull; fi
	chmod -R a=rX ChartJS *.html *.js COPYING
	chmod 700 *.cgi kamate_scrape .git

publish:
	git add banks
	git commit -a || true
	git push
