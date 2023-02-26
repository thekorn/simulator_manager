import 'package:simulator_manager/android/emulator.dart';
import 'package:simulator_manager/ios/simulator.dart';
import 'package:simulator_manager/models/simulator_manager_config.dart';
import 'package:virtual_device/virtual_device.dart';

Future<int> calculate() async {
  //final simulators = await IosSimulator.availableDevices();
  //for (var s in simulators) {
  //  print(s);
  //}
  //final deviceTypes = await IosSimulator.availableDeviceTypes();
  //for (var t in deviceTypes.entries) {
  //  print(t.key);
  //}
//
  //final deviceRuntimes = await IosSimulator.availableRuntimes();
  //for (var t in deviceRuntimes.entries) {
  //  print(t.value);
  //}

  //final newSimulator = FixedIosSimulator(
  //    model: 'iPhone 13 Pro Max',
  //    os: OperatingSystem.iOS,
  //    osVersion: '16.2',
  //    name: "bar");

  //final newSimulator = AndroidEmulator(
  //  model: 'iPad Air 2',
  //  //os: OperatingSystem.iOS,
  //  osVersion: '14.2',
  //);
  final simulatorManagerConfig =
      SimulatorManagerConfig.loadConfigFromPubSpec('.');
  print(simulatorManagerConfig);

  //print('---- types');
  //var x = await AndroidEmulator.availableDeviceTypes();
  //for (var e in x) {
  //  print(e);
  //}
//
  //print('---- devices');
  //var y = await AndroidEmulator.availableDevices();
  //for (var e in y) {
  //  print(e);
  //}
//
  //print('---- runtimes');
  //var z = await AndroidEmulator.availableRuntimes();
  //for (var e in z) {
  //  print(e);
  //}
//
  //final newSimulator = FixedAndroidEmulator(
  //  model: 'pixel_6',
  //  //os: OperatingSystem.iOS,
  //  name: "bar",
  //  //googleApis: false,
  //  osVersion: '33',
  //);
  //await newSimulator.createOrStart();

  //final availableVersions = await AndroidEmulator.availableRuntimes();
  //final discoveredVersion = availableVersions.firstWhere(
  //  (v) => v['apiLevel'].toString() == '32',
  //  orElse: () {
  //    final versions = availableVersions.map((v) => v['apiLevel']).join(', ');
  //    throw StateError('32 is not available in $versions');
  //  },
  //);
  //print(discoveredVersion);

  return 6 * 7;
}
