import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:meta/meta.dart';

part 'bluetooth_thermal_event.dart';
part 'bluetooth_thermal_state.dart';

class BluetoothThermalBloc
    extends Bloc<BluetoothThermalEvent, BluetoothThermalState> {
  BluetoothPrint _bluetoothPrint;
  BluetoothDevice? _selectedPrinter;

  BluetoothThermalBloc(this._bluetoothPrint)
      : super(BluetoothThermalInitial()) {
    on<BTScanEvent>(_btScan);
    on<BTConnectEvent>(_btConnect);
    on<BTDisconnectEvent>(_btDisconnect);
    on<BTPrintEvent>(_btPrint);
    on<PrinterSelected>(_onPrinterSelected);
  }

  FutureOr<void> _onPrinterSelected(
      PrinterSelected event, Emitter<BluetoothThermalState> emit) {
    _selectedPrinter = event.printer;
    emit(PrinterSelectedState(event.printer));
  }

  FutureOr<void> _btScan(
      BTScanEvent event, Emitter<BluetoothThermalState> emit) async {
    print("scanning");
    emit(BTLoading());
    var statusScan =
        await _bluetoothPrint.startScan(timeout: const Duration(seconds: 4));
    print("status scan");
    print(statusScan);
    emit(BTScanned(statusScan));
  }

  FutureOr<void> _btConnect(
      BTConnectEvent event, Emitter<BluetoothThermalState> emit) async {
    print("connecting");

    if (_selectedPrinter != null) {
      var konek = await _bluetoothPrint.connect(_selectedPrinter!);
      emit(BTConnected());
      print("Status Koneksi ke Printer: $konek");
    }
  }

  FutureOr<void> _btDisconnect(
      BTDisconnectEvent event, Emitter<BluetoothThermalState> emit) async {
    print("disconnecting");
    var diskonek = await _bluetoothPrint.disconnect();
    print("status diskonek printer: $diskonek");
    emit(BTDisconnected());
  }

  FutureOr<void> _btPrint(
      BTPrintEvent event, Emitter<BluetoothThermalState> emit) async {
    print("printing");

    Map<String, dynamic> config = Map();
    List<LineText> list = [];
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'A Title',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'this is conent left',
        weight: 0,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'this is conent right',
        align: LineText.ALIGN_RIGHT,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_BARCODE,
        content: 'A12312112',
        size: 10,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_QRCODE,
        content: 'qrcode i',
        size: 10,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));

    await _bluetoothPrint.printReceipt(config, list);
    emit(BTPrinted());
  }
}
