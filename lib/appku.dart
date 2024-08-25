import 'package:bloc_bluetooth_print/bluetooth_thermal_bloc/bluetooth_thermal_bloc.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Appku extends StatelessWidget {
  Appku({super.key});

  BluetoothDevice? printerTerpilih;

  List<DropdownMenuItem> isiMenu = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BT Thermal Bloc"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // scan
                TextButton(
                    onPressed: () {
                      //bersihkan menu jika ada
                      if (isiMenu.length > 0) {
                        isiMenu = [];
                      }
                      context.read<BluetoothThermalBloc>().add(BTScanEvent());
                    },
                    child: const Text("Scan Printer")),
                BlocListener<BluetoothThermalBloc, BluetoothThermalState>(
                  listener: (context, state) {
                    if (state is PrinterSelectedState) {
                      printerTerpilih = state.selectedPrinter;
                      // setState(() {
                      // });
                    }
                  },
                  child:
                      BlocBuilder<BluetoothThermalBloc, BluetoothThermalState>(
                    builder: (context, state) {
                      if (state is BTScanned) {
                        for (var item in state.statusScan) {
                          isiMenu.add(
                            DropdownMenuItem(
                              child: Text("${item.name} (${item.address})"),
                              value: item,
                            ),
                          );
                        }

                        return DropdownButton(
                          items: isiMenu,
                          value:
                              printerTerpilih, // Set dropdown value to selected printer
                          onChanged: (printer) {
                            print("printer terpilih: $printer");
                            context.read<BluetoothThermalBloc>().add(
                                PrinterSelected(
                                    printer)); // Trigger event to save selected printer
                          },
                        );
                      } else if (state is PrinterSelectedState) {
                        return DropdownButton(
                          items: isiMenu,
                          value:
                              printerTerpilih, // Set dropdown value to selected printer
                          onChanged: (printer) {
                            print("printer terpilih: $printer");
                            context.read<BluetoothThermalBloc>().add(
                                PrinterSelected(
                                    printer)); // Trigger event to save selected printer
                          },
                        );
                      } else if (state is BTLoading) {
                        return const CircularProgressIndicator();
                      } else {
                        return const Text("No Printer Found or State Berubah");
                      }
                    },
                  ),
                ),

                // connect
                TextButton(
                    onPressed: () {
                      context
                          .read<BluetoothThermalBloc>()
                          .add(BTConnectEvent());
                    },
                    child: const Text("Connect")),
                // disconnect
                TextButton(
                    onPressed: () {
                      context
                          .read<BluetoothThermalBloc>()
                          .add(BTDisconnectEvent());
                    },
                    child: const Text("Disconnect")),
                // state listener
                BlocBuilder<BluetoothThermalBloc, BluetoothThermalState>(
                  builder: (context, state) {
                    return Text("Status Printer: $state");
                  },
                ),
                // print
                TextButton(
                    onPressed: () {
                      context.read<BluetoothThermalBloc>().add(BTPrintEvent());
                    },
                    child: const Text("Print")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
