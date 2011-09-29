
.PHONY: clean pack

pack: clean
	tar jcvf DarkDuranceUI.tar.bz2 DarkDurance_

clean:
	rm -f *.tar.bz2


