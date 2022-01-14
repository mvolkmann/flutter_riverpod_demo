import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Adding ".autoDispose" causes the provider to lose its state
// there are no longer any widgets listening to it.
// It this case it means rather than using a cached value
// every time we return to this page, it will be recomputed.
final futureProvider = FutureProvider.autoDispose<int>((ref) async {
  // Simulate time to make a API request.
  await Future.delayed(Duration(seconds: 2));
  return 19;
});

class FutureProviderPage extends ConsumerWidget {
  static const route = '/future-provider';

  FutureProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(futureProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('StateProvider Demo'),
      ),
      body: Center(
        child: score.when(
          loading: () => CircularProgressIndicator(),
          data: (value) => Text('$value'),
          error: (e, stack) => Text('Error: $e'),
        ),
      ),
    );
  }
}
