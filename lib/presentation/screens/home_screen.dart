import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/constants/enums.dart';
import 'package:flutter_bloc_concepts/logic/blocs/counter/counter_cubit.dart';
import 'package:flutter_bloc_concepts/logic/blocs/internet/internet_cubit.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  final Color color;

  const HomeScreen({super.key, required this.title, required this.color});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.internetConnectionType == InternetConnectionType.wifi) {
          BlocProvider.of<CounterCubit>(context).increment();
        } else if (state is InternetConnected &&
            state.internetConnectionType == InternetConnectionType.mobile) {
          BlocProvider.of<CounterCubit>(context).decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: widget.color,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('connected to'),
              BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
                  if (state is InternetConnected &&
                      state.internetConnectionType ==
                          InternetConnectionType.wifi) {
                    return const Text('Wi-Fi');
                  } else if (state is InternetConnected &&
                      state.internetConnectionType ==
                          InternetConnectionType.mobile) {
                    return const Text('Mobile Data');
                  } else if (state is InternetDisconnected) {
                    return const Text('Disconnected');
                  } else {
                    return const Text('None');
                  }
                },
              ),
              const SizedBox(height: 24.0),
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
              MaterialButton(
                onPressed: () => Navigator.of(context).pushNamed('/second'),
                color: Colors.red,
                child: const Text(
                  'Go to Second Screen',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              MaterialButton(
                onPressed: () => Navigator.of(context).pushNamed('/third'),
                color: Colors.green,
                child: const Text(
                  'Go to Third Screen',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
