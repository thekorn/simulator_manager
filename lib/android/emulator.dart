import 'dart:io';

import 'package:simulator_manager/android/utils.dart';
import 'package:virtual_device/virtual_device.dart';

Future<void> detachedRun(String cmd, List<String> args) async {
  Process.start(cmd, args, mode: ProcessStartMode.detached);
}

class FixedAndroidEmulator extends AndroidEmulator {
  FixedAndroidEmulator(
      {required super.model,
      required super.osVersion,
      super.googleApis,
      required super.name,
      super.uuid});

  @override
  Future<void> create({bool verbose = false}) async {
    final String checkInstalledImageName = getAndroidImageName(osVersion);
    final List<String> installedPackages = await listInstalledPackages();

    final String packageName = installedPackages.firstWhere(
        (element) => element.startsWith(checkInstalledImageName), orElse: () {
      throw StateError(
          'There is no image for $checkInstalledImageName installed, installed packages are $installedPackages');
    });

    await runWithError('avdmanager', [
      if (verbose) '--verbose',
      'create',
      'avd',
      '--force',
      '--name',
      name!,
      '--device',
      model,
      '--package',
      packageName,
    ]);
  }

  @override
  Future<void> createOrStart() async {
    final devices = await availableAvdNames();
    if (devices.indexOf(name!) > 0) {
      return await startByName(name!);
    }
    await create();
    await start();
  }

  @override
  Future<void> start({
    bool bootAnimation = false,
    bool snapshot = false,
    bool wipeData = true,
  }) =>
      startByName(name!,
          bootAnimation: bootAnimation, snapshot: snapshot, wipeData: wipeData);

  static Future<void> startByName(
    String name, {
    bool bootAnimation = false,
    bool snapshot = false,
    bool wipeData = true,
  }) async {
    detachedRun('emulator', [
      '-avd',
      name,
      if (!bootAnimation) '-no-boot-anim',
      if (!snapshot) '-no-snapshot',
      if (wipeData) '-wipe-data',
    ]);
  }
}
