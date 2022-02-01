# flutter_integration_test_demo

This demostrates a integration test in flutter.

## Firebase Project
https://console.firebase.google.com/u/0/project/flutter-integration-test-demo/testlab/histories


## Running using the flutter command

These tests can be launched with the flutter test command, where <DEVICE_ID>: is the optional device ID or pattern displayed in the output of the `flutter devices` command:

```flutter test integration_test/app_test.dart -d <DEVICE_ID>```

This runs the tests in foo_test.dart. To run all tests in this directory on the default device, run:

```flutter test integration_test```

## Using Flutter Driver to Run Tests

```flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart```


## To run integration_test/foo_test.dart on a local Android device (emulated or physical):

```./gradlew app:connectedAndroidTest -Ptarget=`pwd`/../integration_test/foo_test.dart```


## Create an APK using Gradle:

```
pushd android
# flutter build generates files in android/ for building the app
flutter build apk
./gradlew app:assembleAndroidTest
./gradlew app:assembleDebug -Ptarget=integration_test/<name>_test.dart
popd
```

## 
Upload the build apks Firebase Test Lab, making sure to replace <PATH_TO_KEY_FILE>, <PROJECT_NAME>, <RESULTS_BUCKET>, and <RESULTS_DIRECTORY> with your values.

```
gcloud auth activate-service-account --key-file=<PATH_TO_KEY_FILE>
gcloud --quiet config set project <PROJECT_NAME>
gcloud firebase test android run --type instrumentation \
  --app build/app/outputs/apk/debug/app-debug.apk \
  --test build/app/outputs/apk/androidTest/debug/app-debug-androidTest.apk\
  --timeout 2m \
  --results-bucket=<RESULTS_BUCKET> \
  --results-dir=<RESULTS_DIRECTORY>
```

You can pass additional parameters on the command line, such as the devices you want to test on. See [gcloud firebase test android run](https://cloud.google.com/sdk/gcloud/reference/firebase/test/android/run)


