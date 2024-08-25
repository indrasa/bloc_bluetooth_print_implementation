part of 'bluetooth_thermal_bloc.dart';

@immutable
sealed class BluetoothThermalState {}

final class BluetoothThermalInitial extends BluetoothThermalState {}

final class BTScanned extends BluetoothThermalState {
  final dynamic statusScan;
  BTScanned(this.statusScan);
}

final class BTLoading extends BluetoothThermalState {}

final class BTConnected extends BluetoothThermalState {}

final class BTDisconnected extends BluetoothThermalState {}

final class BTPrinted extends BluetoothThermalState {}

final class BTFailed extends BluetoothThermalState {}
