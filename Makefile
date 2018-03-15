info:
	@echo "make clean        - remove all automatically created files"
	@echo "make builddeb     - build .deb file locally"
	
#VERSION=1.3~dev5
VERSION=2.21.4
SRCDIRS=deploy debian conffiles
SRCFILES=Makefile

clean:
	rm -fr DEBUILD
	rm -f meta/*~


update:
	(cd deploy/FreeRADIUS/; git pull)

builddeb:
	make clean
	mkdir -p DEBUILD/privacyidea-ucs-radius.org
	cp -r ${SRCDIRS} ${SRCFILES} DEBUILD/privacyidea-ucs-radius.org || true
	# We need to touch this, so that our config files 
	# are written to /etc
	cp LICENSE DEBUILD/privacyidea-ucs-radius.org/debian/copyright
	(cd DEBUILD; tar -zcf privacyidea-ucs-radius_${VERSION}.orig.tar.gz --exclude=privacyidea.org/debian privacyidea-ucs-radius.org)
	################# Build
	(cd DEBUILD/privacyidea-ucs-radius.org; debuild --no-lintian -uc -us)

sync-forth:
	rsync -r ../privacyidea-ucs-radius root@172.16.200.147:

sync-back:
	rsync -r root@172.16.200.147:privacyidea-ucs-radius .
