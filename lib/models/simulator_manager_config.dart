import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:checked_yaml/checked_yaml.dart' as yaml;

import 'package:json_annotation/json_annotation.dart';

import 'package:simulator_manager/constants.dart' as constants;
import 'package:simulator_manager/exceptions.dart';

part 'simulator_manager_config.g.dart';

abstract class SimulatorDevice {
  final double version;
  final String type;

  SimulatorDevice({required this.type, required this.version});
}

SimulatorDevice simulatorDeviceFromJson(Map json) {
  switch (json['os']) {
    case 'ios':
      return IosSimulatorDevice.fromJson(json);
    case 'android':
      return AndroidSimulatorDevice.fromJson(json);
    default:
      throw UnimplementedError('Unsupported os "${json['os']}"');
  }
}

List<SimulatorDevice> devicesFromJson(List json) {
  return json.map((e) => simulatorDeviceFromJson(e)).toList();
}

@JsonSerializable(anyMap: true, checked: true, createToJson: false)
class IosSimulatorDevice implements SimulatorDevice {
  @override
  final double version;
  @override
  final String type;

  IosSimulatorDevice({required this.type, required this.version});
  factory IosSimulatorDevice.fromJson(Map json) =>
      _$IosSimulatorDeviceFromJson(json);

  @override
  String toString() {
    return 'IosSimulatorDevice(version=$version, type=$type)';
  }
}

@JsonSerializable(anyMap: true, checked: true, createToJson: false)
class AndroidSimulatorDevice implements SimulatorDevice {
  @override
  final double version;
  @override
  final String type;

  AndroidSimulatorDevice({required this.type, required this.version});
  factory AndroidSimulatorDevice.fromJson(Map json) =>
      _$AndroidSimulatorDeviceFromJson(json);

  @override
  String toString() {
    return 'AndroidSimulatorDevice(version=$version, type=$type)';
  }
}

@JsonSerializable(anyMap: true, checked: true, createToJson: false)
class SimulatorManagerConfig {
  @JsonKey(name: 'device_prefix')
  final String devicePrefix;
  @JsonKey(fromJson: devicesFromJson)
  final List<SimulatorDevice> devices;

  SimulatorManagerConfig({required this.devicePrefix, required this.devices});

  @override
  String toString() {
    return 'SimulatorManagerConfig(devicePrefix=$devicePrefix, devices=$devices)';
  }

  factory SimulatorManagerConfig.fromJson(Map json) =>
      _$SimulatorManagerConfigFromJson(json);

  /// Loads simulator manager config from `pubspec.yaml` file
  static SimulatorManagerConfig? loadConfigFromPubSpec(String prefix) {
    try {
      final pubspecFile = File(path.join(prefix, constants.pubspecFilePath));
      if (!pubspecFile.existsSync()) {
        return null;
      }
      final pubspecContent = pubspecFile.readAsStringSync();
      return yaml.checkedYamlDecode<SimulatorManagerConfig?>(
        pubspecContent,
        (json) {
          return json == null || json['simulator_manager'] == null
              ? null
              : SimulatorManagerConfig.fromJson(json['simulator_manager']);
        },
        allowNull: true,
      );
    } on yaml.ParsedYamlException catch (e) {
      throw InvalidConfigException(e.formattedMessage);
    } catch (e) {
      rethrow;
    }
  }
}
