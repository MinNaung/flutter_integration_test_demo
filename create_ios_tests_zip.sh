output="../build/ios_integ"
product="build/ios_integ/Build/Products"
dev_target="15.2"

# Pass --simulator if building for the simulator.
flutter build ios integration_test/app_test.dart --release

pushd ios
xcodebuild -workspace Runner.xcworkspace -scheme Runner -config Flutter/Release.xcconfig -derivedDataPath $output -sdk iphoneos build-for-testing
popd

pushd $product
zip -r "ios_tests.zip" "Release-iphoneos" "Runner_iphoneos$dev_target-arm64-armv7.xctestrun"
popd
