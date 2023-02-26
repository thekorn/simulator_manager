// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulator_manager_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IosSimulatorDevice _$IosSimulatorDeviceFromJson(Map json) => $checkedCreate(
      'IosSimulatorDevice',
      json,
      ($checkedConvert) {
        final val = IosSimulatorDevice(
          type: $checkedConvert('type', (v) => v as String),
          version: $checkedConvert('version', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );

AndroidSimulatorDevice _$AndroidSimulatorDeviceFromJson(Map json) =>
    $checkedCreate(
      'AndroidSimulatorDevice',
      json,
      ($checkedConvert) {
        final val = AndroidSimulatorDevice(
          type: $checkedConvert('type', (v) => v as String),
          version: $checkedConvert('version', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );

SimulatorManagerConfig _$SimulatorManagerConfigFromJson(Map json) =>
    $checkedCreate(
      'SimulatorManagerConfig',
      json,
      ($checkedConvert) {
        final val = SimulatorManagerConfig(
          devicePrefix: $checkedConvert('device_prefix', (v) => v as String),
          devices:
              $checkedConvert('devices', (v) => devicesFromJson(v as List)),
        );
        return val;
      },
      fieldKeyMap: const {'devicePrefix': 'device_prefix'},
    );
