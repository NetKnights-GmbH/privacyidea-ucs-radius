This is the meta package to add Two Factor Authentication to a
FreeRADIUS server running on privacyIDEA.

The FreeRADIUS privacyIDEA module is implemented in the privacyIDEA project.

To activate Two Factor Authentication set the UCR variables:

   ucr set privacyidea/radius/url=https://your.server

   ucr set privacyidea/radius/realm=yourRealm

   ucr set privacyidea/radius/enable=1

