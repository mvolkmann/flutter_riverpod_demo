import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// StreamProvider automatically continues using the same stream.
// Adding ".autoDispose" causes it to dispose of the strean
// when there are no longer any widgets listening to it.
// Every time we return to this page, it will
// create a new stream starting from the beginning.
final streamProvider = StreamProvider.autoDispose<int>(
  (ref) => Stream.periodic(Duration(seconds: 1), (index) => index + 1),
);

class StreamProviderPage extends ConsumerWidget {
  static const route = '/stream-provider';

  StreamProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stream = ref.watch(streamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('StreamProvider Demo'),
      ),
      body: Center(
        child: stream.when(
          loading: () => CircularProgressIndicator(),
          data: (value) => Text('$value'),
          error: (e, stack) => Text('Error: $e'),
        ),
        //TODO: What can't this be used instead of the above code?
        //child: buildStream(stream),
      ),
    );
  }

  Widget buildStream(stream) {
    return stream.when(
      loading: () => CircularProgressIndicator(),
      data: (value) => Text('$value'),
      error: (e, stack) => Text('Error: $e'),
    );
  }
}
