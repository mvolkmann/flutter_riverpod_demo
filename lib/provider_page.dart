import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This provide a single, immutable value.
// The ref parameter can be used to access other providers.
// This could be used to compute the value of this provider.
final greetingProvider = Provider((ref) => 'Hello, World!');

// Extending ConsumerWidget instead of StatelessWidget
// causes a WidgetRef argument to be passed to the build method.
// ConsumerWidget extends ConsumerStatefulWidget which extends StatefulWidget.
class ProviderPage extends ConsumerWidget {
  static const route = '/provider';

  ProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This is one way to access the state of a provider
    // that makes it available throughout this widget.
    // When the value changes, this entire widget will be rebuilt.
    final greeting = ref.watch(greetingProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(greeting),
            // This is another way to access the state of a provider
            // that limits the scope to a single child widget.
            // When the value changes, only this child widget will be rebuilt.
            Consumer(builder: (context, ref, child) {
              final greeting = ref.watch(greetingProvider);
              return Text(greeting);
            }),
          ],
        ),
      ),
    );
  }
}
