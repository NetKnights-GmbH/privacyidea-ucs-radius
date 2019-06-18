info:
	@echo "make clean        - remove all automatically created files"
	@echo "make update	 - update the FreeRADIUS module fromg github"
	@echo "make builddeb     - build .deb file locally"
	
#VERSION=1.3~dev5
VERSION=2.23.1
SRCDIRS=deploy debian conffiles
SRCFILES=Makefile
BUILDER_IP=10.0.2.56

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
	(cd DEBUILD; tar -zcf privacyidea-ucs-radius_${VERSION}.orig.tar.gz --exclude=debian/* privacyidea-ucs-radius.org)
	################# Build
	(cd DEBUILD/privacyidea-ucs-radius.org; debuild --no-lintian -uc -us)

sync-up:
	rsync -r ../privacyidea-ucs-radius root@${BUILDER_IP}:

remote-build:
	ssh root@10.0.2.56 "cd privacyidea-ucs-radius; make builddeb"  

sync-down:
	rsync -r root@${BUILDER_IP}:privacyidea-ucs-radius/* .
