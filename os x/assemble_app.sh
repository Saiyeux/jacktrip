#!/bin/sh

APPNAME="QJackTrip"
BUNDLE_ID="org.psi-borg.qjacktrip"

if [ "$#" -lt 1 ]; then
    echo "You need to supply a version number for this script to work."
    exit 1
fi
VERSION="$1"

if [ "$#" -gt 1 ]; then
    APPNAME="$2"
fi

if [ "$#" -gt 1 ]; then
    BUNDLE_ID="$3"
fi

# Make sure that jacktrip has been built with GUI support.
../builddir/jacktrip --test-gui || { echo "You need to build jacktrip with GUI support to build an app bundle."; exit 1; }

# The qt bin folder needs to be in your PATH for this script to work.
rm -rf "$APPNAME.app"
[ ! -d "QJackTrip.app_template/Contents/MacOS" ] && mkdir QJackTrip.app_template/Contents/MacOS
cp -a QJackTrip.app_template "$APPNAME.app"
cp -f ../builddir/jacktrip "$APPNAME.app/Contents/MacOS/"
sed -i '' "s/%VERSION%/$VERSION/" "$APPNAME.app/Contents/Info.plist"
sed -i '' "s/%BUNDLENAME%/$APPNAME/" "$APPNAME.app/Contents/Info.plist"
sed -i '' "s/%BUNDLEID%/$BUNDLE_ID/" "$APPNAME.app/Contents/Info.plist"

# If you want to create a signed package, uncomment and modify the codesign parameter below as appropriate.
macdeployqt "$APPNAME.app" #-codesign="Developer ID Application: Aaron Wyatt"
exit 0

# If you have Packages installed, you can build an installer for the newly created app bundle.
# Remove the exit line above to do this.

# Needed for notarization. Uncomment the line and update the developer ID as required.
#codesign -f -s "Developer ID Application: Aaron Wyatt" --entitlements entitlements.plist --options "runtime" "$APPNAME.app"

cp package/QJackTrip.pkgproj_template package/QJackTrip.pkgproj
sed -i '' "s/%VERSION%/$VERSION/" package/QJackTrip.pkgproj
sed -i '' "s/%BUNDLENAME%/$APPNAME/" package/QJackTrip.pkgproj
sed -i '' "s/%BUNDLEID%/$BUNDLE_ID/" package/QJackTrip.pkgproj

packagesbuild package/QJackTrip.pkgproj
exit 0

# Remove or comment out the exit line above to submit a notarization request to apple.
# Make sure you adjust the parameters to match your developer account.
read -n1 -rsp "Press any key to submit a notarization request to apple..."
echo
xcrun altool --notarize-app --primary-bundle-id "org.psi-borg.qjacktrip" --username USERNAME --password PASSWORD --asc-provider ASCPROVIDER --file "package/build/$APPNAME.pkg"
read -n1 -rsp "Press any key to staple the notarization once it's been approved..."
echo
xcrun stapler staple "package/build/$APPNAME.pkg"
