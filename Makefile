

pack: clean
	tar jcvf "DarkDuranceUI-`date +'%Y%m%d'`.tar.bz2" DarkDurance_*

.PHONY: clean

clean:
	-rm -f *.tar.bz2

.PHONY: clean

