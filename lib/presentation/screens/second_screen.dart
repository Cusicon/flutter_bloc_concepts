import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/logic/blocs/counter/counter_cubit.dart';

class SecondScreen extends StatefulWidget {
  final String title;
  final Color color;

  const SecondScreen({super.key, required this.title, required this.color});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  backgroundColor: widget.color,
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  child: const Icon(Icons.remove),
                ),
                BlocConsumer<CounterCubit, CounterState>(
                  listener: (context, state) {
                    if (state.wasIncremented) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Incremented!')),
                      );
                    }
                    if (!state.wasIncremented) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Decremented!')),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Text(
                      '${state.counterValue}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  },
                ),
                FloatingActionButton(
                  backgroundColor: widget.color,
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 48.0),
            // MaterialButton(
            //   onPressed: () {},
            //   color: widget.color,
            //   child: const Text(
            //     'Go to Second Screen',
            //     style: TextStyle(color: Colors.white),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
