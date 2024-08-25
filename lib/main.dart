import 'package:bloc_bluetooth_print/appku.dart';
import 'package:bloc_bluetooth_print/bluetooth_thermal_bloc/bluetooth_thermal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BluetoothThermalBloc(),
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
