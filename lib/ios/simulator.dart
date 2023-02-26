// ignore: implementation_imports
import 'package:virtual_device/virtual_device.dart';

class FixedIosSimulator extends IosSimulator {
  FixedIosSimulator({
    super.model,
    required super.name,
    required super.osVersion,
    required super.os,
    super.status,
    super.uuid,
  });
}
