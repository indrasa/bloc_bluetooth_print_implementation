import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bluetooth_thermal_event.dart';
part 'bluetooth_thermal_state.dart';

class BluetoothThermalBloc extends Bloc<BluetoothThermalEvent, BluetoothThermalState> {
  BluetoothThermalBloc() : super(BluetoothThermalInitial()) {
    on<BluetoothThermalEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
