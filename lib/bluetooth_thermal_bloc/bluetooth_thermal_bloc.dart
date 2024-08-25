import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:meta/meta.dart';

part 'bluetooth_thermal_event.dart';
part 'bluetooth_thermal_state.dart';

class BluetoothThermalBloc
    extends Bloc<BluetoothThermalEvent, BluetoothThermalState> {
  BluetoothPrint _bluetoothPrint;
  BluetoothThermalBloc(this._bluetoothPrint)
      : super(BluetoothThermalInitial()) {
    on<BTScanEvent>(_btScan);
    on<BTConnectEvent>(_btConnect);
    on<BTDisconnectEvent>(_btDisconnect);
    on<BTPrintEvent>(_btPrint);
  }

  FutureOr<void> _btScan(
      BTScanEvent event, Emitter<BluetoothThermalState> emit) {
    print("scanning");
    emit(BTScanned());
  }

  FutureOr<void> _btConnect(
      BTConnectEvent event, Emitter<BluetoothThermalState> emit) {
    print("connecting");
    emit(BTConnected());
  }

  FutureOr<void> _btDisconnect(
      BTDisconnectEvent event, Emitter<BluetoothThermalState> emit) {
    print("disconnecting");
    emit(BTDisconnected());
  }

  FutureOr<void> _btPrint(
      BTPrintEvent event, Emitter<BluetoothThermalState> emit) {
    print("printing");
    emit(BTPrinted());
  }
}
