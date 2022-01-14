import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DogNotifier extends ChangeNotifier {
  String _breed = 'Whippet';
  String _name = 'Comet';

  void update({String? breed, String? name}) {
    if (breed != null) _breed = breed;
    if (name != null) _name = name;
    notifyListeners();
  }

  @override
  String toString() => '$_name is a $_breed.';
}

final dogNotifierProvider = ChangeNotifierProvider<DogNotifier>(
  (ref) => DogNotifier(),
);

class ChangeNotifierPage extends ConsumerWidget {
  static const route = '/change-notifier';

  ChangeNotifierPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dog = ref.watch(dogNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(dog.toString()),
            ElevatedButton(
              child: Text('Change Dog'),
              onPressed: () {
                dog.update(breed: 'GSP', name: 'Oscar');
              },
            ),
          ],
        ),
      ),
    );
  }
}
