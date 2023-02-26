import 'package:virtual_device/virtual_device.dart';

String getAndroidImageName(String osVersion) {
  final imageName = ['system-images', 'android-$osVersion', 'google_apis'];
  return imageName.join(';');
}

Future<List<String>> listInstalledPackages() async {
  List<String> result = [];
  String listInstalled = await runWithError('sdkmanager', ['--list_installed']);
  for (var line in listInstalled.split('-------').last.split('\n')) {
    line = line.trim();
    if (line.isEmpty) {
      continue;
    }
    String packageName = line.split('|').first.trim();
    result.add(packageName);
  }
  return result;
}

Future<List<String>> availableAvdNames() async {
  List<String> result = [];
  String devices = await runWithError('avdmanager', ['list', 'avd', '-c']);
  for (var line in devices.split('\n')) {
    line = line.trim();
    if (line.isEmpty) {
      continue;
    }
    result.add(line);
  }
  return result;
}

Future<List<String>> availableDeviceNames() async {
  List<String> result = [];
  String devices = await runWithError('avdmanager', ['list', 'device', '-c']);
  for (var line in devices.split('\n')) {
    line = line.trim();
    if (line.isEmpty) {
      continue;
    }
    result.add(line);
  }
  return result;
}
