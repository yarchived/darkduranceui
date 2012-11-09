

pack: clean install-vendor
	tar jcvf "DarkDuranceUI-`date +'%Y%m%d'`.tar.bz2" DarkDurance_*

.PHONY: pack

install-vendor: clean-vendor
	git clone --depth 1 git://github.com/haste/oUF.git DarkDurance_UnitFrame/vendor/oUF
	git clone --depth 1 git://github.com/haste/oUF_MovableFrames.git DarkDurance_UnitFrame/vendor/oUF_MovableFrames
	rm -rf DarkDurance_UnitFrame/vendor/*/.git

.PHONY: install-vendor

clean-vendor:
	rm -rf DarkDurance_UnitFrame/vendor/*

.PHONY: clean-vendor

clean:
	-rm -f *.tar.bz2

.PHONY: clean

