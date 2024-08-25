part of 'bluetooth_thermal_bloc.dart';

@immutable
sealed class BluetoothThermalEvent {}

class BTInitial extends BluetoothThermalEvent {}

class BTScanEvent extends BluetoothThermalEvent {}

class BTConnectEvent extends BluetoothThermalEvent {}

class BTDisconnectEvent extends BluetoothThermalEvent {}

class BTPrintEvent extends BluetoothThermalEvent {}

class PrinterSelected extends BluetoothThermalEvent {
  final printer;
  PrinterSelected(this.printer);
}
