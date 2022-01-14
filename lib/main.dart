import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This provide a single, immutable value.
// The ref parameter can be used to access other providers.
// These could be used to compute the value of this provider.
final greetingProvider = Provider((ref) => 'Hello, World!');

final counterStateProvider = StateProvider<int>((ref) => 0);

class ScoresNotifier extends StateNotifier<List<int>> {
  ScoresNotifier() : super([]);

  void add(int number) {
    state = [...state, number];
  }
}

final scoresNotifierProvider =
    StateNotifierProvider<ScoresNotifier, List<int>>((ref) {
  return ScoresNotifier();
});

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

// Extending ConsumerWidget instead of StatelessWidget
// causes a WidgetRef argument to be passed to the build method.
// ConsumerWidget extends ConsumerStatefulWidget which extends StatefulWidget.
class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This is one way to access the state of a provider
    // that makes it available throughout this widget.
    // When the value changes, this entire widget will be rebuilt.
    final greeting = ref.watch(greetingProvider);

    // If the value of any watched provider changes,
    // this build method will be called again
    // to rebuild this entire widget.
    final counter = ref.watch(counterStateProvider);
    final scores = ref.watch(scoresNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Riverpod Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(greeting),
            // This is anothe way to access the state of a provider
            // that limits the scope to a single child widget.
            // When the value changes, only this child widget will be rebuilt.
            Consumer(builder: (context, ref, child) {
              final greeting = ref.watch(greetingProvider);
              return Text(greeting);
            }),
            Text('$counter'),
            /*
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Text(scores[index].toString());
                },
                itemCount: scores.length,
              ),
            ),
            */
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => incrementCounter(ref),
            ),
            ElevatedButton(
              child: Text('Add Number'),
              //onPressed: () => scores.add(7),
              onPressed: () => ref.read(scoresNotifierProvider).add(7),
            ),
          ],
        ),
      ),
    );
  }

  void incrementCounter(ref) {
    ref.read(counterStateProvider.state).state += 1;
  }
}
