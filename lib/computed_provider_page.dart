import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final priceStateProvider = StateProvider<double>((ref) => 100);
final taxStateProvider = StateProvider<double>((ref) => 0.075);
final totalStateProvider = StateProvider<double>((ref) {
  final price = ref.watch(priceStateProvider);
  final tax = ref.watch(taxStateProvider);
  return price * (1 + tax);
});

class ComputedProviderPage extends ConsumerWidget {
  static const route = '/scoped-provider';

  ComputedProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ref.watch(totalStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('ComputedProvider Demo'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              numberField('Price', priceStateProvider, ref),
              SizedBox(height: 10),
              numberField('Tax', taxStateProvider, ref),
              SizedBox(height: 10),
              Text('Total: \$${total.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField numberField(
    String label,
    StateProvider provider,
    WidgetRef ref,
  ) {
    final value = ref.watch(provider);
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
      initialValue: value.toString(),
      keyboardType: TextInputType.number,
      onChanged: (String value) => setValue(provider, ref, value),
    );
  }

  void setValue(StateProvider provider, ref, value) {
    ref.read(provider.state).state = double.parse(value);
  }
}
