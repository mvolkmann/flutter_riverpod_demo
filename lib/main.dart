import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'future_provider_page.dart';
import 'provider_page.dart';
import 'state_provider_page.dart';
import 'stream_provider_page.dart';

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
        routes: {
          ProviderPage.route: (_) => ProviderPage(),
          StateProviderPage.route: (_) => StateProviderPage(),
          FutureProviderPage.route: (_) => FutureProviderPage(),
          StreamProviderPage.route: (_) => StreamProviderPage(),
        });
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // If the value of any watched provider changes,
    // this build method will be called again
    // to rebuild this entire widget.
    //final scores = ref.watch(scoresNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Riverpod Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Provider'),
              onPressed: () {
                Navigator.pushNamed(context, ProviderPage.route);
              },
            ),
            ElevatedButton(
              child: Text('StateProvider'),
              onPressed: () {
                Navigator.pushNamed(context, StateProviderPage.route);
              },
            ),
            ElevatedButton(
              child: Text('FutureProvider'),
              onPressed: () {
                Navigator.pushNamed(context, FutureProviderPage.route);
              },
            ),
            ElevatedButton(
              child: Text('StreamProvider'),
              onPressed: () {
                Navigator.pushNamed(context, StreamProviderPage.route);
              },
            ),
            /*
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Text(scores[index].toString());
                },
                itemCount: scores.length,
              ),
            ),
            ElevatedButton(
              child: Text('Add Number'),
              //onPressed: () => scores.add(7),
              onPressed: () => ref.read(scoresNotifierProvider).add(7),
            ),
            */
          ],
        ),
      ),
    );
  }
}
