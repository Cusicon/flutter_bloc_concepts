// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'counter_cubit.dart';

class CounterState {
  final int counterValue;
  bool wasIncremented;

  CounterState({required this.counterValue, this.wasIncremented = false});

  CounterState copyWith({
    int? counterValue,
    bool? wasIncremented,
  }) {
    return CounterState(
      counterValue: counterValue ?? this.counterValue,
      wasIncremented: wasIncremented ?? this.wasIncremented,
    );
  }
}
