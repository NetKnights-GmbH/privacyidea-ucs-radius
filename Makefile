info:
	@echo "make clean        - remove all automatically created files"
	@echo "make update	     - update the FreeRADIUS module from github"
	@echo "make builddeb     - build .deb file locally"
	
SRCDIRS=debian conffiles
SRCFILES=Makefile
BUILDDIR_RADIUS=DEBUILD/privacyidea-ucs-radius.orig
# UCS 4.4
BUILDER_IP=10.0.2.59

clean:
	rm -fr DEBUILD
	rm -f meta/*~
	rm -fr deploy

builddeb:
	make clean	
	mkdir -p DEBUILD
	(cd DEBUILD; git clone https://github.com/privacyidea/FreeRADIUS.git privacyidea-ucs-radius.orig)
	(cd ${BUILDDIR_RADIUS}; git checkout v${VERSION})
	cp -r ${SRCDIRS} ${BUILDDIR_RADIUS}
	cp LICENSE ${BUILDDIR_RADIUS}/debian/copyright
	(cd DEBUILD; tar -zcf privacyidea-ucs-radius_${VERSION}.orig.tar.gz --exclude=debian/* privacyidea-ucs-radius.orig)
	################# Build
	#(cd ${BUILD}; debuild --no-lintian -uc -us)
	(cd ${BUILDDIR_RADIUS}; dpkg-buildpackage -us -uc)

sync-up:
	rsync -r ../privacyidea-ucs-radius root@${BUILDER_IP}:

remote-build:
	ssh root@${BUILDER_IP} "cd privacyidea-ucs-radius; VERSION=${VERSION} make builddeb"  

sync-down:
	rsync -r root@${BUILDER_IP}:privacyidea-ucs-radius/* .


ifndef VERSION
        $(error VERSION not set. Set VERSION - a git tag - to build like VERSION=3.1)
endif

