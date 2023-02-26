import 'dart:io';

import 'package:simulator_manager/android/utils.dart';
import 'package:simulator_manager/doctor/result_spinner.dart';
import 'package:simulator_manager/models/simulator_manager_config.dart';

Future<bool> cmdLineToolExists(String cmd) async {
  var p = await Process.run('which', [cmd], runInShell: true);
  return p.exitCode == 0;
}

Future<void> checkCmdLineToolExists(String cmd, {String? description}) async {
  final checkTools = ResultSpinner(
    successIcon: '  ✅',
    errorIcon: '  ❌',
    rightPrompt: (done) => description ?? cmd,
  ).interact();

  var r = await cmdLineToolExists(cmd);
  checkTools.done(error: !r);
}

Future<void> checkInstalledAndroidImages(
    Iterable<AndroidSimulatorDevice> androidDeviceConfig) async {
  final Iterable<String> imagePackagePrefixes = androidDeviceConfig
      .map((dc) => getAndroidImageName(dc.version.toInt().toString()));
  final List<String> installedPackages = await listInstalledPackages();
  for (var prefix in imagePackagePrefixes) {
    List<String> isInstalled = installedPackages
        .where((element) => element.startsWith(prefix))
        .toList();
    if (isInstalled.isEmpty) {
      print('  ❌ missing android avd image, please install "$prefix"');
    } else {
      print('  ✅ found android avd image for "$prefix"');
    }
  }
}

Future<void> checkDefinedAndroidModels(
    Iterable<AndroidSimulatorDevice> androidDeviceConfig) async {
  final Iterable<String> deviceNames = androidDeviceConfig.map((dc) => dc.type);
  final List<String> configuredDevices = await availableDeviceNames();
  for (var name in deviceNames) {
    bool isInstalled = configuredDevices.contains(name);
    if (isInstalled) {
      print('  ✅ android device config found for "$name"');
    } else {
      print('  ❌ missing android device config, please define "$name"');
    }
  }
}

Future<void> runDoctor() async {
  print('Check if your environment is ready for the simulator manager...');
  print('');
  print('Are all required tools installed?');
  await checkCmdLineToolExists('emulator',
      description: 'android sdk commandline tools: emulator');
  await checkCmdLineToolExists('avdmanager',
      description: 'android sdk commandline tools: avdmanager');
  await checkCmdLineToolExists('sdkmanager',
      description: 'android sdk commandline tools: sdkmanager');
  await checkCmdLineToolExists('xcrun',
      description: 'XCode commandline tools: xcrun');

  final simulatorManagerConfig =
      SimulatorManagerConfig.loadConfigFromPubSpec('.');
  if (simulatorManagerConfig != null) {
    print('Are all required android image packages installed?');
    final Iterable<AndroidSimulatorDevice> androidDeviceConfigs =
        simulatorManagerConfig.devices.whereType<AndroidSimulatorDevice>();
    await checkInstalledAndroidImages(androidDeviceConfigs);
    print('Are all required android models defined?');
    await checkDefinedAndroidModels(androidDeviceConfigs);

    final Set<double> iosVersions = simulatorManagerConfig.devices
        .whereType<IosSimulatorDevice>()
        .map((e) => e.version)
        .toSet();
    print(iosVersions);
  }
}
