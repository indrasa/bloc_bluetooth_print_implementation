import 'package:bloc_bluetooth_print/bluetooth_thermal_bloc/bluetooth_thermal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Appku extends StatelessWidget {
  const Appku({super.key});

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
                      context.read<BluetoothThermalBloc>().add(BTScanEvent());
                    },
                    child: const Text("Scan Printer")),
                DropdownButton(
                  items: [],
                  onChanged: (value) {},
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
