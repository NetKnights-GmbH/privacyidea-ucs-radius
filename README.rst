This is the meta package to add Two Factor Authentication to a
FreeRADIUS server running on privacyIDEA.

The FreeRADIUS privacyIDEA module is implemented in the privacyIDEA project.

# Usage

To activate Two Factor Authentication set the UCR variables:

   ucr set privacyidea/radius/url=https://your.server

   ucr set privacyidea/radius/realm=yourRealm

   ucr set privacyidea/radius/enable=1

# Building

This package requires ``univention-install-config-registry`` and should be built on
a Univention Corporate Server.

On the UCS do:

    ucr set repository/online/unmaintained='yes'
    univention-install build-essential debhelper
    univention-install ucslint
    univention-install univention-config-dev
