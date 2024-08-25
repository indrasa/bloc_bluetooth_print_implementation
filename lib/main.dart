import 'package:bloc_bluetooth_print/appku.dart';
import 'package:bloc_bluetooth_print/bluetooth_thermal_bloc/bluetooth_thermal_bloc.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final BluetoothPrint _bluetoothPrint = BluetoothPrint.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BluetoothThermalBloc(_bluetoothPrint),
      child: MaterialApp(
        title: 'Flutter Bluetooth Thermal with Bloc',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Appku(),
      ),
    );
  }
}
