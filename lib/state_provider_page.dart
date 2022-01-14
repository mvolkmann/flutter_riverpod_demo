import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Adding ".autoDispose" causes the provider to lose its state
// there are no longer any widgets listening to it.
// The value will reset to zero every time we return to this page.
final counterStateProvider = StateProvider.autoDispose<int>((ref) => 0);

// Extending ConsumerWidget instead of StatelessWidget
// causes a WidgetRef argument to be passed to the build method.
// ConsumerWidget extends ConsumerStatefulWidget which extends StatefulWidget.
class StateProviderPage extends ConsumerWidget {
  static const route = '/state-provider';

  StateProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('StateProvider Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$counter'),
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => incrementCounter(ref),
            ),
          ],
        ),
      ),
    );
  }

  void incrementCounter(ref) {
    // This is overly complex!
    ref.read(counterStateProvider.state).state += 1;
  }
}
