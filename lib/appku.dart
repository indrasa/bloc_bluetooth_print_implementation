import 'package:flutter/material.dart';

class Appku extends StatelessWidget {
  const Appku({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          const Text(
            "Bluetooth Thermal dengan Bloc",
            style: TextStyle(fontSize: 18),
          ),
          // scan
          // connect
          // disconnect
          // state listener
          // print
        ],
      ),
    );
  }
}
