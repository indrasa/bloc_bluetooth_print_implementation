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
        content: 'Mobil Masya Allah',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Masbagik - Lombok Timur',
        weight: 0,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'HP: 0819-7319-0000',
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Bukti Pembayaran Iuran Mobil',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        align: LineText.ALIGN_LEFT,
        weight: 0,
        linefeed: 1,
        content: "ID Iuran: 1"));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        align: LineText.ALIGN_LEFT,
        weight: 0,
        linefeed: 1,
        content: "Nama: Indra Saputra Ahmadi"));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        align: LineText.ALIGN_LEFT,
        weight: 0,
        linefeed: 1,
        content: "Kelas: 6A"));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        align: LineText.ALIGN_LEFT,
        weight: 0,
        linefeed: 1,
        content: "Tanggal: 25-08-2024"));
    list.add(LineText(linefeed: 1));
    //header
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: '--------------------------------',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Bulan',
        align: LineText.ALIGN_LEFT,
        x: 0,
        weight: 1,
        relativeX: 0,
        linefeed: 0));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Tanggal',
        align: LineText.ALIGN_LEFT,
        x: 130,
        weight: 1,
        relativeX: 0,
        linefeed: 0));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Nominal',
        align: LineText.ALIGN_LEFT,
        x: 280,
        weight: 1,
        relativeX: 0,
        linefeed: 1));

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: '--------------------------------',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    // list iuran
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Januari',
        align: LineText.ALIGN_LEFT,
        x: 0,
        relativeX: 0,
        linefeed: 0));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: '1.1.24',
        align: LineText.ALIGN_LEFT,
        x: 130,
        relativeX: 0,
        linefeed: 0));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: '150000',
        align: LineText.ALIGN_LEFT,
        x: 280,
        relativeX: 0,
        linefeed: 1));
    // end list iuran
    list.add(LineText(linefeed: 3));

    // total
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: '--------------------------------',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Total',
        weight: 1,
        align: LineText.ALIGN_LEFT,
        x: 0,
        relativeX: 0,
        linefeed: 0));

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: '300000',
        align: LineText.ALIGN_LEFT,
        x: 280,
        relativeX: 0,
        linefeed: 1));

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: '--------------------------------',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));

    // ttd
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Masbagik, 17 Agustus 1945',
        weight: 0,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Admin',
        weight: 0,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Lilik Ahmadi',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    await _bluetoothPrint.printReceipt(config, list);
    emit(BTPrinted());
  }
}
