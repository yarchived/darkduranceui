
.PHONY: clean pack

pack: clean
	tar jcvf "DarkDuranceUI-`date +'%Y%m%d'`.tar.bz2" DarkDurance_*

clean:
	-rm -f *.tar.bz2


