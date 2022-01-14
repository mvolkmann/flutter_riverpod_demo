import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This is an immutable class.
class Dog {
  final String breed;
  final String name;

  const Dog({
    this.breed = 'Whippet',
    this.name = 'Comet',
  });

  Dog copy({String? breed, String? name}) => Dog(
        breed: breed ?? this.breed,
        name: name ?? this.name,
      );

  @override
  String toString() => '$name is a $breed.';
}

class DogStateNotifier extends StateNotifier<Dog> {
  DogStateNotifier() : super(Dog());

  void setBreed(String breed) {
    state = state.copy(breed: breed);
  }

  void setName(String name) {
    state = state.copy(name: name);
  }

  @override
  void dispose() {
    print('DogStateNotifier dispose called');
    super.dispose();
  }
}

// Adding ".autoDispose" causes the provider to lose its state
// there are no longer any widgets listening to it.
// It also enables its "dispose" method to be called.
final dogNotifierProvider =
    StateNotifierProvider.autoDispose<DogStateNotifier, Dog>(
  (ref) => DogStateNotifier(),
);

class StateNotifierPage extends ConsumerWidget {
  static const route = '/state-notifier';

  StateNotifierPage({Key? key}) : super(key: key);

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
              child: Text('State Dog'),
              onPressed: () {
                final notifier = ref.read(dogNotifierProvider.notifier);
                notifier.setBreed('GSP');
                notifier.setName('Oscar');
              },
            ),
          ],
        ),
      ),
    );
  }
}
