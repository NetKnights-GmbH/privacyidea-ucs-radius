info:
	@echo "make clean        - remove all automatically created files"
	@echo "make builddeb     - build .deb file locally"
	
#VERSION=1.3~dev5
VERSION=2.4~dev1
SRCDIRS=deploy debian conffiles
SRCFILES=Makefile

clean:
	rm -fr DEBUILD
	rm -f meta/*~


builddeb:
	make clean
	mkdir -p DEBUILD/privacyidea-ucs-radius.org
	cp ../privacyidea/authmodules/FreeRADIUS/privacyidea_radius.pm deploy || true
	cp -r ${SRCDIRS} ${SRCFILES} DEBUILD/privacyidea-ucs-radius.org || true
	# We need to touch this, so that our config files 
	# are written to /etc
	cp LICENSE DEBUILD/privacyidea-ucs-radius.org/debian/copyright
	(cd DEBUILD; tar -zcf privacyidea-ucs-radius_${VERSION}.orig.tar.gz --exclude=privacyidea.org/debian privacyidea-ucs-radius.org)
	################# Build
	(cd DEBUILD/privacyidea-ucs-radius.org; debuild --no-lintian)

