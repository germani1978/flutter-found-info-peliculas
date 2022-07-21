

import 'dart:async';

class Debouncer<T> {

  Debouncer({required this.duration, this.onValue} );

  final Duration duration;
  T? _value;
  Timer? _timer;

  void Function(T value)? onValue;

  T get value => _value!;

  set value(T val) {
    _value = val;
    _timer?.cancel();
    _timer = Timer(duration, () => onValue!(_value!) ); 
  } 
}