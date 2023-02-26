# flutter simulator manager

**NOTE: this project is still in a very early stage.**

This package helps you to define a a common set of ios simulators and android
emulators in the `pubspec` of your flutter app.

Besides defining versions and device form factors common tasks like providing
images in the media library of the virtual devices, dns based routing to the
host network and importing of certificates can easily be done via simple 
configuration.

## usage

### define virtual devices in your pubspec

Add a section like this to your `pubspec.yaml`:

```
simulator_manager:
  device_prefix: sample-app
  devices:
    -
      os: ios
      version: 16.2
      type: iPhone 14 Pro Max
    -
      os: ios
      version: 16.2
      type: iPhone 13 mini
    -
      os: android
      version: 33
      type: pixel_6
```

### check if your setup is prepared

The simulator manager provides an easy way to check if all prerequisists are matched:

```
$ flutter pub run simulator_manager:doctor
Check if your environment is ready for the simulator manager...

Are all required tools installed?
  ✅ android sdk commandline tools: emulator
  ✅ android sdk commandline tools: avdmanager
  ✅ android sdk commandline tools: sdkmanager
  ✅ XCode commandline tools: xcrun
Are all required android image packages installed?
  ✅ found android avd image for "system-images;android-33;google_apis"
Are all required android models defined?
  ✅ android device config found for "pixel_6"
```